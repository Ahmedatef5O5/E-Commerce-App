import 'package:ecommerce_app/models/add_to_cart_model.dart';
import 'package:ecommerce_app/models/location_item_model.dart';
import 'package:ecommerce_app/models/payment_card_model.dart';
import 'package:ecommerce_app/services/cart_service.dart';
import 'package:ecommerce_app/services/checkout_services.dart';
import 'package:ecommerce_app/services/location_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../services/auth_services.dart';
part 'checkout_state.dart';

class CheckoutCubit extends Cubit<CheckoutState> {
  CheckoutCubit() : super(CheckoutInitial());
  final double shippingValue = 6.00;
  LocationItemModel? selectedLocation;
  final authServices = AuthServicesImpl();
  final checkoutServices = CheckoutServicesImpl();
  final locationServices = LocationServicesImpl();
  final cartServices = CartServicesImpl();

  Future<void> getCheckoutContent() async {
    emit(CheckoutLoading());
    try {
      final currrentUser = authServices.getCurrentUser();

      if (currrentUser == null) {
        emit(CheckoutFailure(errMsg: 'User not logged in'));
        return;
      }

      final List<AddToCartModel> cartItems = await cartServices
          .fetchCartItems(currrentUser.uid)
          .first;
      final subtotal = cartItems.fold(
        0.0,
        (prev, curr) => prev + (curr.product.price * curr.quantity),
      );
      final numOfProducts = cartItems.fold(
        0,
        (prev, curr) => prev + curr.quantity,
      );

      List<PaymentCardModel> cards = [];
      cards = await CheckoutServicesImpl().fetchPaymentMethods(
        currrentUser.uid,
      );

      final chosenPaymentCard = cards.isEmpty
          ? null
          : cards.firstWhere(
              (e) => e.isChosen == true,
              orElse: () => cards.first,
            );

      emit(
        CheckoutLoaded(
          numOfProducts: numOfProducts,
          cartItems: cartItems,
          shippingValue: shippingValue,
          subtotal: subtotal,
          totalAmount: subtotal + shippingValue,
          chosenPaymentCard: chosenPaymentCard,
        ),
      );
    } catch (e) {
      emit(CheckoutFailure(errMsg: e.toString()));
    }
  }

  void updateChosenCard(PaymentCardModel paymentCard) {
    if (state is CheckoutLoaded) {
      final currState = state as CheckoutLoaded;
      emit(currState.copyWith(chosenPaymentCard: paymentCard));
    }
  }

  void setLocation(LocationItemModel location) {
    selectedLocation = location;
    if (state is CheckoutLoaded) {
      final currentState = state as CheckoutLoaded;
      emit(
        CheckoutLoaded(
          numOfProducts: currentState.numOfProducts,
          cartItems: currentState.cartItems,
          shippingValue: shippingValue,
          subtotal: currentState.subtotal,
          totalAmount: currentState.totalAmount,
        ),
      );
    }
  }
}
