import 'package:ecommerce_app/models/carousel_item_model.dart';
import 'package:ecommerce_app/models/product_item_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  void changeCarouselIndex(int index) {
    if (state is HomeSuccessLoaded) {
      // final currentState = state as HomeSuccessLoaded;
      // emit(currentState.copyWith(currentCarouselIndex: index));
      emit((state as HomeSuccessLoaded).copyWith(currentCarouselIndex: index));
    }
  }

  void getHomeData() {
    emit(HomeLoading());
    Future.delayed(
      const Duration(seconds: 1),
      () => emit(
        HomeSuccessLoaded(
          productItems: dummyProducts,
          homeCarouselSlideItem: homeCarouselSlideItem,
        ),
      ),
    );
  }
}
