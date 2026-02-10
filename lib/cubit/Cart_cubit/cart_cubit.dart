import 'package:ecommerce_app/models/add_to_cart_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());

  int quantity = 1;

  double get _subtotal => dummyCart.fold<double>(
    0,
    (previousValue, item) => previousValue + item.product.price * item.quantity,
  );

  void getCartItem() {
    emit(CartLoading());

    Future.delayed(Duration(seconds: 1), () {
      if (!isClosed) {
        emit(CartLoaded(cartItems: dummyCart, subtotal: _subtotal));
      }
    });
  }

  void addProductToCart(AddToCartModel newItem) {
    dummyCart.add(newItem);
    emit(CartLoaded(cartItems: List.from(dummyCart), subtotal: _subtotal));
  }

  void incrementQuantity(String cartItemId, [int? initialValue]) {
    if (initialValue != null) {
      quantity = initialValue;
    }
    quantity++;
    final index = dummyCart.indexWhere((item) => item.product.id == cartItemId);
    dummyCart[index] = dummyCart[index].copyWith(quantity: quantity);
    emit(QuantityCounterLoaded(value: quantity, productId: cartItemId));
    emit(SubtotalUpdated(subtotal: _subtotal));
  }

  void decrementQuantity(String cartItemId, [int? initialValue]) {
    if (initialValue != null) {
      quantity = initialValue;
    }
    if (quantity > 1) {
      quantity--;
      final index = dummyCart.indexWhere(
        (item) => item.product.id == cartItemId,
      );
      dummyCart[index] = dummyCart[index].copyWith(quantity: quantity);
      emit(QuantityCounterLoaded(value: quantity, productId: cartItemId));
      emit(SubtotalUpdated(subtotal: _subtotal));
    }
    emit(QuantityCounterLoaded(value: quantity, productId: cartItemId));
  }
}
