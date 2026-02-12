enum CardType { masterCard, visaCard, paypalCard }

class PaymentCardModel {
  final String id;
  final String cardNumber;
  final String cardHolderName;
  final String expirtyDate;
  final String cvv;
  final CardType cardType;

  PaymentCardModel({
    required this.id,
    required this.cardNumber,
    required this.cardHolderName,
    required this.expirtyDate,
    required this.cvv,
    required this.cardType,
  });
}

List<PaymentCardModel> dummyPaymentCards = [
  PaymentCardModel(
    id: '1',
    cardNumber: '5234 5678 9012 3456',
    cardHolderName: 'Ahmed atef',
    expirtyDate: '228',
    cvv: '673',
    cardType: CardType.masterCard,
  ),
  PaymentCardModel(
    id: '2',
    cardNumber: '6578 5146 9806 5478',
    cardHolderName: 'amgad safy',
    expirtyDate: '627',
    cvv: '836',
    cardType: CardType.paypalCard,
  ),
  PaymentCardModel(
    id: '3',
    cardNumber: '4658 1214 3896 9403',
    cardHolderName: 'Mohamed atef',
    expirtyDate: '129',
    cvv: '319',

    cardType: CardType.visaCard,
  ),
];
