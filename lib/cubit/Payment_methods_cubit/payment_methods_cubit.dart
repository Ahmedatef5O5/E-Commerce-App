import 'package:ecommerce_app/cubit/Checkout_cubit/checkout_cubit.dart';
import 'package:ecommerce_app/models/payment_card_model.dart';
import 'package:ecommerce_app/services/auth_services.dart';
import 'package:ecommerce_app/services/checkout_services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'Payment_methods_state.dart';

class PaymentMethodsCubit extends Cubit<PaymentMethodsState> {
  PaymentMethodsCubit() : super(AddNewCardInitial());

  List<PaymentCardModel> _allCards = [];
  String selectedPaymentId = dummyPaymentCards.first.id;
  final checkoutServices = CheckoutServicesImpl();
  final authServices = AuthServicesImpl();

  CardType getCardTypeFromNumber(String cardNumber) {
    String clearNumber = cardNumber.replaceAll(' ', '');
    if (clearNumber.startsWith('4')) {
      return CardType.visaCard;
    } else if (clearNumber.startsWith('5')) {
      return CardType.masterCard;
    } else if (clearNumber.startsWith('6')) {
      return CardType.paypalCard;
    } else {
      // throw Exception('Invalid card number'); make app stop (will handle it )
      return CardType.masterCard; // default card
    }
  }

  Future<void> addNewCard(
    String cardNumber,
    String cardHolderName,
    String expirtyDate,
    String cvvCode,
    CardType cardType,
  ) async {
    emit(AddNewCardLoading());
    try {
      final newCard = PaymentCardModel(
        id: DateTime.now().toIso8601String(),
        cardNumber: cardNumber,
        cardHolderName: cardHolderName,
        expirtyDate: expirtyDate,
        cvv: cvvCode,
        cardType: cardType,
      );
      final currentUser = authServices.getCurrentUser();
      if (currentUser == null) return;
      await checkoutServices.setCard(currentUser.uid, newCard);
      emit(AddNewCardSuccessLoaded());

      // Future.delayed(Duration(seconds: 1), () {
      //   dummyPaymentCards.add(newCard);
      //   emit(AddNewCardSuccessLoaded());
      // });
    } catch (e) {
      emit(AddNewCardFailure(errMsg: e.toString()));
    }
  }

  Future<void> fetchPaymentMethods() async {
    emit(PaymentMethodsFetching());
    try {
      final currrentUser = authServices.getCurrentUser();
      if (currrentUser == null) return;
      final paymentCards = await checkoutServices.fetchPaymentMethods(
        currrentUser.uid,
      );
      _allCards = paymentCards;

      emit(PaymentMethodsFetched(paymentCards: _allCards));
      if (paymentCards.isNotEmpty) {
        final chosenPaymentMethod = _allCards.firstWhere(
          (paymentCard) => paymentCard.isChosen == true,
          orElse: () => _allCards.first,
        );
        emit(PaymentMethodChosen(chosenPayment: chosenPaymentMethod));
      }
    } catch (e) {
      emit(PaymentMethodsFetchError(errMsg: e.toString()));
    }
  }

  void changePaymentMethod(String id) {
    selectedPaymentId = id;
    final tempChosenPaymentMethod = _allCards.firstWhere(
      (paymentCard) => paymentCard.id == id,
    );
    emit(PaymentMethodChosen(chosenPayment: tempChosenPaymentMethod));
  }

  Future<void> confirmPaymentMethod(BuildContext context) async {
    emit(ConfirmPaymentLoading());
    try {
      final currentUser = authServices.getCurrentUser();
      if (currentUser == null) return;
      await checkoutServices.updateSelectedCard(
        currentUser.uid,
        selectedPaymentId,
      );

      _allCards
          .map((card) => card.copyWith(isChosen: card.id == selectedPaymentId))
          .toList();
      emit(ConfirmPaymentSuccessLoaded());

      final confirmedCard = _allCards.firstWhere((card) => card.isChosen);
      context.read<CheckoutCubit>().updateChosenCard(confirmedCard);

      //  final chosenPayment = _allCards.firstWhere(
      //     (card) => card.id == selectedPaymentId,
      //     orElse: () => _allCards.first,
      //   );

      //   emit(ConfirmPaymentSuccessLoaded());
      //   Navigator.of(context).pop(chosenPayment);
    } catch (e) {
      emit(PaymentMethodsFetchError(errMsg: e.toString()));
    }

    // Future.delayed(Duration(seconds: 1), () {
    //   var chosenPaymentMethod = _allCards.firstWhere(
    //     (paymentCard) => paymentCard.id == selectedPaymentId,
    //   );
    //   var previousPaymentMethod = _allCards.firstWhere(
    //     (paymnetCard) => paymnetCard.isChosen == true,
    //     orElse: () => _allCards.first,
    //   );
    //   previousPaymentMethod = previousPaymentMethod.copyWith(isChosen: false);
    //   chosenPaymentMethod = chosenPaymentMethod.copyWith(isChosen: true);

    //   final previousIndex = _allCards.indexWhere(
    //     (paymentCard) => paymentCard.id == previousPaymentMethod.id,
    //   );
    //   final chosenIndex = _allCards.indexWhere(
    //     (paymentCard) => paymentCard.id == chosenPaymentMethod.id,
    //   );

    //   _allCards[previousIndex] = previousPaymentMethod;
    //   _allCards[chosenIndex] = chosenPaymentMethod;

    //   emit(ConfirmPaymentSuccessLoaded());
    // });
  }
}
