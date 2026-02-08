import 'package:ecommerce_app/models/product_item_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'product_details_state.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  ProductDetailsCubit() : super(ProductDetailsInitial());

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
    final selectedIndex = dummyProducts.indexWhere(
      (item) => item.id == productId,
    );
    // dummyProducts[selectedIndex].quantity + 1;
    //// invalid as quantity is final use copyWith instead:
    ///  The original object was not modified, but a new copy was made with an updated value.
    dummyProducts[selectedIndex] = dummyProducts[selectedIndex].copyWith(
      quantity: dummyProducts[selectedIndex].quantity + 1,
    );
    emit(QuantityCounterLoaded(value: dummyProducts[selectedIndex].quantity));
  }

  void decrementQuantity(String productId) {
    final selectedIndex = dummyProducts.indexWhere(
      (item) => item.id == productId,
    );
    if (dummyProducts[selectedIndex].quantity > 1) {
      dummyProducts[selectedIndex] = dummyProducts[selectedIndex].copyWith(
        quantity: dummyProducts[selectedIndex].quantity - 1,
      );
    }
    emit(QuantityCounterLoaded(value: dummyProducts[selectedIndex].quantity));
  }

  void selectSize(ProductSize size) {
    emit(SelectedSizeState(size: size));
  }
}
