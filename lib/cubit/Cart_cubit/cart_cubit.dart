import 'dart:async';

import 'package:ecommerce_app/models/add_to_cart_model.dart';
import 'package:ecommerce_app/services/auth_services.dart';
import 'package:ecommerce_app/services/cart_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());
  List<AddToCartModel> dummyCart = [];
  int quantity = 1;

  final cartServices = CartServicesImpl();
  final authServices = AuthServicesImpl();

  StreamSubscription<List<AddToCartModel>>? _cartSub;
  void listenToCartItems() {
    emit(CartLoading());
    final currentUser = authServices.getCurrentUser();
    if (currentUser == null) return;
    _cartSub?.cancel();

    _cartSub = cartServices
        .fetchCartItems(currentUser.uid)
        .listen(
          (cartItems) {
            final subtotal = dummyCart.fold<double>(
              0,
              (previousValue, item) =>
                  previousValue + item.product.price * item.quantity,
            );
            emit(CartLoaded(cartItems: cartItems, subtotal: subtotal));
          },
          onError: (e) {
            emit(CartFailure(message: e.toString()));
          },
        );
  }

  double get _subtotal => dummyCart.fold<double>(
    0,
    (previousValue, item) => previousValue + item.product.price * item.quantity,
  );

  // void getCartItem() async {
  //   emit(CartLoading());
  //   try {
  //     final currentUser = authServices.getCurrentUser();
  //     if (currentUser == null) return;
  //     // final cartItems = await cartServices.fetchCartItems(currentUser.uid);
  //     // final subtotal = cartItems.fold<double>(
  //     //   0,
  //     //   (previousValue, item) =>
  //     //       previousValue + item.product.price * item.quantity,
  //     // );
  //     // emit(CartLoaded(cartItems: cartItems, subtotal: subtotal));
  //   } catch (e) {
  //     emit(CartFailure(message: e.toString()));
  //   }

  //   // Future.delayed(Duration(seconds: 1), () {
  //   //   if (!isClosed) {
  //   //     emit(CartLoaded(cartItems: dummyCart, subtotal: _subtotal));
  //   //   }
  //   // });
  // }

  // void addProductToCart(AddToCartModel newItem) {
  //   dummyCart.add(newItem);
  //   emit(CartLoaded(cartItems: List.from(dummyCart), subtotal: _subtotal));
  // }

  void incrementQuantity(String cartItemId, [int? initialValue]) {
    if (initialValue != null) {
      quantity = initialValue;
    }
    quantity++;
    final index = dummyCart.indexWhere((item) => item.product.id == cartItemId);
    dummyCart[index] = dummyCart[index].copyWith(quantity: quantity);
    emit(SubtotalUpdated(subtotal: _subtotal));

    emit(QuantityCounterLoaded(value: quantity, productId: cartItemId));
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
      emit(SubtotalUpdated(subtotal: _subtotal));
      emit(QuantityCounterLoaded(value: quantity, productId: cartItemId));
    }
    emit(QuantityCounterLoaded(value: quantity, productId: cartItemId));
  }

  @override
  Future<void> close() {
    _cartSub?.cancel();
    return super.close();
  }
}
