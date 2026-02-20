part of 'favorite_cubit.dart';

sealed class FavoriteState {}

final class FavoriteInitial extends FavoriteState {}

final class FavoriteLoading extends FavoriteState {}

final class FavoriteSuccessLoaded extends FavoriteState {
  final List<ProductItemModel> productItems;

  FavoriteSuccessLoaded(this.productItems);
}

final class FavoriteFailure extends FavoriteState {
  final String errMsg;

  FavoriteFailure(this.errMsg);
}

final class FavoriteRemoving extends FavoriteState {
  final String productId;

  FavoriteRemoving(this.productId);
}

final class FavoriteSuccessRemoved extends FavoriteState {
  final String productId;

  FavoriteSuccessRemoved(this.productId);
}

final class FavoriteFailureRemoved extends FavoriteState {
  final String errMsg;

  FavoriteFailureRemoved(this.errMsg);
}
