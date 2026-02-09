import 'package:ecommerce_app/models/add_to_cart_model.dart';
import 'package:ecommerce_app/models/product_item_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'product_details_state.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  ProductDetailsCubit() : super(ProductDetailsInitial());

  late ProductSize size;
  int quantity = 1;

  void getProductDetails(String id) {
    emit(ProductDetailsLoading());
    Future.delayed(Duration(seconds: 1), () {
      final selectedProduct = dummyProducts.firstWhere(
        (product) => product.id == id,
      );
      emit(ProductDetailsSuccessLoaded(product: selectedProduct));
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

  void selectSize(ProductSize size) {
    this.size = size;
    emit(SelectedSizeState(size: size));
  }

  void addToCart(String productId) {
    emit(ProductAddingToCart());
    final AddToCartModel cartItem = AddToCartModel(
      productId: productId,
      size: size,
      quantity: quantity,
    );
    dummyCart.add(cartItem);
    Future.delayed(
      Duration(seconds: 2),
      () => emit(ProductAddedToCart(productId: productId)),
    );
  }
}
