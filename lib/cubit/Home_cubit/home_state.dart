part of 'home_cubit.dart';

sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {}

final class HomeSuccessLoaded extends HomeState {
  final List<ProductItemModel> productItems;
  final List<CarouselSlideModel> homeCarouselSlideItem;

  HomeSuccessLoaded({
    required this.productItems,
    required this.homeCarouselSlideItem,
  });
}

final class HomeFailureLoaded extends HomeState {
  final String message;
  HomeFailureLoaded({required this.message});
}
