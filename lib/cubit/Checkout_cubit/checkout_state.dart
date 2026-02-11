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
}

final class CheckoutFailure extends CheckoutState {
  final String errMsg;

  CheckoutFailure({required this.errMsg});
}
