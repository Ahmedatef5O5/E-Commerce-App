class PaymentCardModel {
  final String id;
  final String cardNumber;
  final String cardHolderName;
  final String expirtyDate;
  final String cvv;

  PaymentCardModel({
    required this.id,
    required this.cardNumber,
    required this.cardHolderName,
    required this.expirtyDate,
    required this.cvv,
  });
}

List<PaymentCardModel> dummyPaymentCards = [];
