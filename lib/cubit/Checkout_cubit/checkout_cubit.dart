import 'package:ecommerce_app/models/add_to_cart_model.dart';
import 'package:ecommerce_app/models/payment_card_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'checkout_state.dart';

class CheckoutCubit extends Cubit<CheckoutState> {
  CheckoutCubit() : super(CheckoutInitial());
  final double shiping = 6.00;
  void getCartItems() {
    emit(CheckoutLoading());
    final cartItems = dummyCart;
    final subtotal = cartItems.fold(
      0.0,
      (prev, curr) => prev + (curr.product.price * curr.quantity),
    );
    final numOfProducts = cartItems.fold(
      0,
      (prev, curr) => prev + curr.quantity,
    );
    final PaymentCardModel? chosenPaymentCard = dummyPaymentCards.isNotEmpty
        ? dummyPaymentCards.first
        : null;

    emit(
      CheckoutLoaded(
        numOfProducts: numOfProducts,
        cartItems: cartItems,
        totalAmount: subtotal + shiping,
        chosenPaymentCard: chosenPaymentCard,
      ),
    );
  }
}
