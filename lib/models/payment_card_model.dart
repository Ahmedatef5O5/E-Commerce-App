// ignore_for_file: public_member_api_docs, sort_constructors_first
enum CardType { masterCard, visaCard, paypalCard }

class PaymentCardModel {
  final String id;
  final String _cardNumber;
  final String cardHolderName;
  final String expirtyDate;
  final String cvv;
  final CardType cardType;
  final bool isChosen;

  PaymentCardModel({
    required this.id,
    required String cardNumber,
    required this.cardHolderName,
    required this.expirtyDate,
    required this.cvv,
    required this.cardType,
    this.isChosen = false,
  }) : _cardNumber = cardNumber;

  String get maskedNumber {
    if (_cardNumber.length >= 4) {
      String lastFourDigits = _cardNumber.substring(_cardNumber.length - 4);
      return "**** **** **** $lastFourDigits";
    } else {
      return _cardNumber;
    }
  }

  PaymentCardModel copyWith({
    String? id,
    String? cardNumber,
    String? cardHolderName,
    String? expirtyDate,
    String? cvv,
    CardType? cardType,
    bool? isChosen,
  }) {
    return PaymentCardModel(
      id: id ?? this.id,
      cardNumber: cardNumber ?? _cardNumber,
      cardHolderName: cardHolderName ?? this.cardHolderName,
      expirtyDate: expirtyDate ?? this.expirtyDate,
      cvv: cvv ?? this.cvv,
      cardType: cardType ?? this.cardType,
      isChosen: isChosen ?? this.isChosen,
    );
  }
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
    cardHolderName: 'Mohamed atef',
    expirtyDate: '627',
    cvv: '836',
    cardType: CardType.paypalCard,
  ),
  PaymentCardModel(
    id: '3',
    cardNumber: '4658 1214 3896 9403',
    cardHolderName: 'Atef fathi',
    expirtyDate: '129',
    cvv: '319',

    cardType: CardType.visaCard,
  ),
  PaymentCardModel(
    id: '4',
    cardNumber: '5678 658 1214 3126 9466',
    cardHolderName: 'Youssef joo',
    expirtyDate: '0873',
    cvv: '891',

    cardType: CardType.masterCard,
  ),
  PaymentCardModel(
    id: '5',
    cardNumber: '6678 907 7432 3126 1254',
    cardHolderName: 'Sam rami',
    expirtyDate: '1030',
    cvv: '671',

    cardType: CardType.paypalCard,
  ),
];
