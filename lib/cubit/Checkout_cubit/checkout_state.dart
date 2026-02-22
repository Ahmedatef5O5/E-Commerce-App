part of 'checkout_cubit.dart';

sealed class CheckoutState {}

final class CheckoutInitial extends CheckoutState {}

final class CheckoutLoading extends CheckoutState {}

final class CheckoutLoaded extends CheckoutState {
  final List<AddToCartModel> cartItems;
  final double totalAmount;
  final int numOfProducts;
  final PaymentCardModel? chosenPaymentCard;

  CheckoutLoaded({
    required this.numOfProducts,
    required this.cartItems,
    required this.totalAmount,
    this.chosenPaymentCard,
  });

  CheckoutLoaded copyWith({
    List<AddToCartModel>? cartItems,
    double? totalAmount,
    int? numOfProducts,
    PaymentCardModel? chosenPaymentCard,
  }) {
    return CheckoutLoaded(
      numOfProducts: numOfProducts ?? this.numOfProducts,
      cartItems: cartItems ?? this.cartItems,
      totalAmount: totalAmount ?? this.totalAmount,
      chosenPaymentCard: chosenPaymentCard ?? this.chosenPaymentCard,
    );
  }
}

final class CheckoutFailure extends CheckoutState {
  final String errMsg;

  CheckoutFailure({required this.errMsg});
}
