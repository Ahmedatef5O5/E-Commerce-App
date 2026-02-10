part of 'cart_cubit.dart';

sealed class CartState {
  const CartState();
}

final class CartInitial extends CartState {}

final class CartLoading extends CartState {}

final class CartLoaded extends CartState {
  final List<AddToCartModel> cartItems;
  final double subtotal;
  const CartLoaded({required this.subtotal, required this.cartItems});
}

final class QuantityCounterLoaded extends CartState {
  final int value;
  final String productId;
  QuantityCounterLoaded({required this.value, required this.productId});
}

final class SubtotalUpdated extends CartState {
  final double subtotal;

  SubtotalUpdated({required this.subtotal});
}

final class CartFailure extends CartState {
  final String message;

  CartFailure({required this.message});
}
