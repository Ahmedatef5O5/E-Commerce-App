import 'package:ecommerce_app/models/add_to_cart_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());

  int quantity = 1;

  void getCartItem() async {
    emit(CartLoading());
    Future.delayed(
      Duration(seconds: 1),
      () => emit(CartLoaded(cartItems: dummyCart)),
    );
  }

  void incrementQuantity(String cartItemId, [int? initialValue]) {
    if (initialValue != null) {
      quantity = initialValue;
    }
    quantity++;
    emit(QuantityCounterLoaded(value: quantity, productId: cartItemId));
  }

  void decrementQuantity(String cartItemId, [int? initialValue]) {
    if (initialValue != null) {
      quantity = initialValue;
    }
    if (quantity > 1) {
      quantity--;
    }
    emit(QuantityCounterLoaded(value: quantity, productId: cartItemId));
  }
}
