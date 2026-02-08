part of 'product_details_cubit.dart';

sealed class ProductDetailsState {}

final class ProductDetailsInitial extends ProductDetailsState {}

final class ProductDetailsLoading extends ProductDetailsState {}

final class ProductDetailsSuccessLoaded extends ProductDetailsState {
  final ProductItemModel product;

  ProductDetailsSuccessLoaded({required this.product});
}

final class QuantityCounterLoaded extends ProductDetailsState {
  final int value;

  QuantityCounterLoaded({required this.value});
}

final class SelectedSizeState extends ProductDetailsState {
  final ProductSize size;
  SelectedSizeState({required this.size});
}

final class ProductDetailsFailureLoaded extends ProductDetailsState {
  final String message;

  ProductDetailsFailureLoaded({required this.message});
}
