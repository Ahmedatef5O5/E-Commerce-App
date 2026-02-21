import 'package:ecommerce_app/models/product_item_model.dart';
import 'package:ecommerce_app/services/auth_services.dart';
import 'package:ecommerce_app/services/favorite_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  FavoriteCubit() : super(FavoriteInitial());
  final favoriteServices = FavoriteServicesImpl();
  final authServices = AuthServicesImpl();

  Future<void> getFavoriteProducts() async {
    emit(FavoriteLoading());

    try {
      final currentUser = authServices.getCurrentUser();
      final favoriteProducts = await favoriteServices.getFavorites(
        currentUser!.uid,
      );
      emit(FavoriteSuccessLoaded(favoriteProducts));
    } catch (e) {
      emit(FavoriteFailure(e.toString()));
    }
  }

  Future<void> removeFavorite(String productId) async {
    emit(FavoriteRemoving(productId));
    try {
      final currentUser = authServices.getCurrentUser();
      await favoriteServices.removeFavorite(currentUser!.uid, productId);
      emit(FavoriteSuccessRemoved(productId));
      final favoriteProducts = await favoriteServices.getFavorites(
        currentUser.uid,
      );
      emit(FavoriteSuccessLoaded(favoriteProducts));
    } catch (e) {
      emit(FavoriteFailureRemoved(e.toString()));
    }
  }
}
