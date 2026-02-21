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
            final subtotal = cartItems.fold<double>(
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

  void removeFromCart(String cartItemId) async {
    final uid = authServices.getCurrentUser()?.uid;
    if (uid == null) return;
    try {
      await cartServices.deleteCartItems(uid, cartItemId);
    } catch (e) {
      emit(CartFailure(message: 'Failed to delete item: ${e.toString()}'));
    }
  }

  void incrementQuantity(AddToCartModel product) {
    final uid = authServices.getCurrentUser()!.uid;
    cartServices.updateQuantity(uid, product.id, product.quantity + 1);
  }

  void decrementQuantity(AddToCartModel product) {
    final uid = authServices.getCurrentUser()!.uid;

    if (product.quantity > 1) {
      cartServices.updateQuantity(uid, product.id, product.quantity - 1);
    } else {
      // cartServices.deleteCartItems(uid, product.id);
    }
  }

  @override
  Future<void> close() {
    _cartSub?.cancel();
    return super.close();
  }
}
