import 'package:ecommerce_app/models/payment_card_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'Payment_methods_state.dart';

class PaymentMethodsCubit extends Cubit<PaymentMethodsState> {
  PaymentMethodsCubit() : super(AddNewCardInitial());

  String selectedPaymentId = dummyPaymentCards.first.id;

  CardType getCardTypeFromNumber(String cardNumber) {
    if (cardNumber.startsWith('4')) {
      return CardType.visaCard;
    } else if (cardNumber.startsWith('5')) {
      return CardType.masterCard;
    } else if (cardNumber.startsWith('6')) {
      return CardType.paypalCard;
    } else {
      // throw Exception('Invalid card number'); make app stop (will handle it )
      return CardType.masterCard; // default card
    }
  }

  void addNewCard(
    String cardNumber,
    String cardHolderName,
    String expirtyDate,
    String cvvCode,
    CardType cardType,
  ) {
    emit(AddNewCardLoading());
    final newCard = PaymentCardModel(
      id: DateTime.now().toIso8601String(),
      cardNumber: cardNumber,
      cardHolderName: cardHolderName,
      expirtyDate: expirtyDate,
      cvv: cvvCode,
      cardType: cardType,
    );
    Future.delayed(Duration(seconds: 1), () {
      dummyPaymentCards.add(newCard);
      emit(AddNewCardSuccessLoaded());
    });
  }

  void fetchPaymentMethods() {
    emit(PaymentMethodsFetching());
    Future.delayed(Duration(seconds: 1), () {
      if (dummyPaymentCards.isNotEmpty) {
        final chosenPaymentMethod = dummyPaymentCards.firstWhere(
          (paymentCard) => paymentCard.isChosen == true,
          orElse: () => dummyPaymentCards.first,
        );
        emit(PaymentMethodsFetched(paymentCards: dummyPaymentCards));
        emit(PaymentMethodChosen(chosenPayment: chosenPaymentMethod));
      } else {
        emit(PaymentMethodsFetchError(errMsg: 'No payment methods found'));
      }
    });
  }

  void changePaymentMethod(String id) {
    selectedPaymentId = id;
    var tempChosenPaymentMethod = dummyPaymentCards.firstWhere(
      (paymentCard) => paymentCard.id == selectedPaymentId,
    );
    emit(PaymentMethodChosen(chosenPayment: tempChosenPaymentMethod));
  }

  void confirmPaymentMethod() {
    emit(ConfirmPaymentLoading());
    Future.delayed(Duration(seconds: 1), () {
      var chosenPaymentMethod = dummyPaymentCards.firstWhere(
        (paymentCard) => paymentCard.id == selectedPaymentId,
      );
      var previousPaymentMethod = dummyPaymentCards.firstWhere(
        (paymnetCard) => paymnetCard.isChosen == true,
        orElse: () => dummyPaymentCards.first,
      );
      previousPaymentMethod = previousPaymentMethod.copyWith(isChosen: false);
      chosenPaymentMethod = chosenPaymentMethod.copyWith(isChosen: true);

      final previousIndex = dummyPaymentCards.indexWhere(
        (paymentCard) => paymentCard.id == previousPaymentMethod.id,
      );
      final chosenIndex = dummyPaymentCards.indexWhere(
        (paymentCard) => paymentCard.id == chosenPaymentMethod.id,
      );

      dummyPaymentCards[previousIndex] = previousPaymentMethod;
      dummyPaymentCards[chosenIndex] = chosenPaymentMethod;

      emit(ConfirmPaymentSuccessLoaded());
    });
  }
}
