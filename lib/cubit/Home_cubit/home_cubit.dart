import 'package:ecommerce_app/models/carousel_item_model.dart';
import 'package:ecommerce_app/models/product_item_model.dart';
import 'package:ecommerce_app/services/auth_services.dart';
import 'package:ecommerce_app/services/favorite_services.dart';
import 'package:ecommerce_app/services/home_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  final homeServices = HomeServicesImpl();
  final authServices = AuthServicesImpl();
  final favoriteServices = FavoriteServicesImpl();
  void changeCarouselIndex(int index) {
    if (state is HomeSuccessLoaded) {
      // final currentState = state as HomeSuccessLoaded;
      // emit(currentState.copyWith(currentCarouselIndex: index));
      emit((state as HomeSuccessLoaded).copyWith(currentCarouselIndex: index));
    }
  }

  Future<void> getHomeData() async {
    emit(HomeLoading());

    try {
      final products = await homeServices.fetchProducts();
      final carouselItems = await homeServices.fetchCarouselItems();

      final currentUser = authServices.getCurrentUser();
      final favorites = await favoriteServices.getFavorites(currentUser!.uid);

      emit(
        HomeSuccessLoaded(
          productItems: products,
          homeCarouselSlideItem: carouselItems,
          favoriteProductIds: favorites.map((e) => e.id).toSet(),
        ),
      );
    } catch (e) {
      emit(HomeFailureLoaded(e.toString()));
    }
  }

  Future<void> setFavorite(ProductItemModel product) async {
    // emit(SetFavoriteLoading());
    if (state is! HomeSuccessLoaded) return;
    final currentState = state as HomeSuccessLoaded;
    final isFavorite = currentState.favoriteProductIds.contains(product.id);

    // optimistic update
    final updatedFavorites = Set<String>.from(currentState.favoriteProductIds);
    isFavorite
        ? updatedFavorites.remove(product.id)
        : updatedFavorites.add(product.id);

    emit(
      currentState.copyWith(
        favoriteProductIds: updatedFavorites,
        loadingFavoriteId: product.id,
      ),
    );

    try {
      final currentUser = authServices.getCurrentUser();
      isFavorite
          ? await favoriteServices.removeFavorite(currentUser!.uid, product.id)
          : await favoriteServices.addFavorite(currentUser!.uid, product);

      emit(
        currentState.copyWith(
          favoriteProductIds: updatedFavorites,
          loadingFavoriteId: null,
        ),
      );
    } catch (e) {
      // rollback
      emit(
        currentState.copyWith(
          favoriteProductIds: currentState.favoriteProductIds,
          // loadingFavoriteId: null,
        ),
      );
    }
  }
}
