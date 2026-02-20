import 'package:ecommerce_app/models/add_to_cart_model.dart';
import 'package:ecommerce_app/models/product_item_model.dart';
import 'package:ecommerce_app/services/auth_services.dart';
import 'package:ecommerce_app/services/product_details_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'product_details_state.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  ProductDetailsCubit() : super(ProductDetailsInitial());
  final productDetailsServices = ProductDetailsServicesImpl();
  final authServices = AuthServicesImpl();
  ProductSize? selectedSize;
  int quantity = 1;

  void getProductDetails(String id) async {
    emit(ProductDetailsLoading());
    try {
      final selectedProduct = await productDetailsServices.fetchProductDetails(
        id,
      );

      if (!isClosed) {
        emit(ProductDetailsSuccessLoaded(product: selectedProduct));
      }
    } catch (e) {
      emit(ProductDetailsFailureLoaded(message: e.toString()));
    }
  }

  void incrementQuantity(String productId) {
    quantity++;
    emit(QuantityCounterLoaded(value: quantity));
  }

  void decrementQuantity(String productId) {
    if (quantity > 1) {
      quantity--;
    }
    emit(QuantityCounterLoaded(value: quantity));
  }

  void selectSizeFunc(ProductSize size) {
    selectedSize = size;
    emit(SelectedSizeState(size: size));
  }

  Future<void> addToCart(String productId) async {
    if (selectedSize == null) {
      emit(ProductDetailsFailureLoaded(message: 'Please select size'));
      return;
    }
    emit(ProductAddingToCart());

    try {
      final selectedProduct = await productDetailsServices.fetchProductDetails(
        productId,
      );
      final currentUser = authServices.getCurrentUser();
      final cartItem = AddToCartModel(
        id: DateTime.now().toIso8601String(),
        product: selectedProduct,
        size: selectedSize!,
        quantity: quantity,
      );
      await productDetailsServices.addToCart(cartItem, currentUser!.uid);
      emit(ProductAddedToCart(productId: productId));
    } catch (e) {
      emit(ProductAddToCartFailure(e.toString()));
    }
    // final AddToCartModel cartItem = AddToCartModel(
    //   id: DateTime.now().toIso8601String(),
    //   product: dummyProducts.firstWhere((product) => product.id == productId),
    //   size: selectedSize!,
    //   quantity: quantity,
    // );
    // Future.delayed(
    //   Duration(seconds: 2),
    //   () => emit(ProductAddedToCart(productId: productId)),
    // );
    // return cartItem;
  }
}
