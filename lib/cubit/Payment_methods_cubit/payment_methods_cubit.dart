import 'package:ecommerce_app/models/payment_card_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'Payment_methods_state.dart';

class PaymentMethodsCubit extends Cubit<PaymentMethodsState> {
  PaymentMethodsCubit() : super(AddNewCardInitial());

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

  void fetchPaymentMethods() {
    emit(PaymentMethodsFetching());
    Future.delayed(Duration(seconds: 1), () {
      if (dummyPaymentCards.isNotEmpty) {
        emit(PaymentMethodsFetched(paymentCards: dummyPaymentCards));
      } else {
        emit(PaymentMethodsFetchError(errMsg: 'No payment methods found'));
      }
    });
  }
}
