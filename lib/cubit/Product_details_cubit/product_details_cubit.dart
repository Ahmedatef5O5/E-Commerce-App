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
}
