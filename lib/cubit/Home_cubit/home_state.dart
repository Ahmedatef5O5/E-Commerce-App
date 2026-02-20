part of 'home_cubit.dart';

sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {}

final class HomeSuccessLoaded extends HomeState {
  final List<ProductItemModel> productItems;
  final List<CarouselSlideModel> homeCarouselSlideItem;
  final int currentCarouselIndex;
  HomeSuccessLoaded({
    required this.productItems,
    required this.homeCarouselSlideItem,
    this.currentCarouselIndex = 0,
  });
  HomeSuccessLoaded copyWith({int? currentCarouselIndex}) => HomeSuccessLoaded(
    productItems: productItems,
    homeCarouselSlideItem: homeCarouselSlideItem,
    currentCarouselIndex: currentCarouselIndex ?? this.currentCarouselIndex,
  );
}

final class HomeFailureLoaded extends HomeState {
  final String message;
  HomeFailureLoaded(this.message);
}

final class SetFavoriteLoading extends HomeState {}

final class SetFavoriteSuccessLoaded extends HomeState {
  final bool isFavorite;

  SetFavoriteSuccessLoaded(this.isFavorite);
}

final class SetFavoriteError extends HomeState {
  final String message;
  SetFavoriteError(this.message);
}
