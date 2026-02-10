import 'package:ecommerce_app/models/add_to_cart_model.dart';
import 'package:ecommerce_app/models/product_item_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'product_details_state.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  ProductDetailsCubit() : super(ProductDetailsInitial());

  ProductSize? selectedSize;
  int quantity = 1;

  void getProductDetails(String id) {
    emit(ProductDetailsLoading());
    Future.delayed(Duration(seconds: 1), () {
      final selectedProduct = dummyProducts.firstWhere(
        (product) => product.id == id,
      );
      if (!isClosed) {
        emit(ProductDetailsSuccessLoaded(product: selectedProduct));
      }
    });
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

  AddToCartModel? addToCart(String productId) {
    if (selectedSize == null) {
      emit(ProductDetailsFailureLoaded(message: 'Please select size'));
      return null;
    }
    emit(ProductAddingToCart());

    final AddToCartModel cartItem = AddToCartModel(
      id: DateTime.now().toIso8601String(),
      product: dummyProducts.firstWhere((product) => product.id == productId),
      size: selectedSize!,
      quantity: quantity,
    );
    Future.delayed(
      Duration(seconds: 2),
      () => emit(ProductAddedToCart(productId: productId)),
    );
    return cartItem;
  }
}
