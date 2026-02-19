import 'package:ecommerce_app/models/carousel_item_model.dart';
import 'package:ecommerce_app/models/product_item_model.dart';
import 'package:ecommerce_app/services/home_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  final homeServices = HomeServicesImpl();

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
      final homeCarouselSlideItems = homeCarouselSlideItem;
      emit(
        HomeSuccessLoaded(
          productItems: products,
          homeCarouselSlideItem: homeCarouselSlideItems,
        ),
      );
    } catch (e) {
      emit(HomeFailureLoaded(e.toString()));
    }

    // Future.delayed(const Duration(seconds: 1), () {
    //   if (!isClosed) {
    //     emit(
    //       HomeSuccessLoaded(
    //         productItems: dummyProducts,
    //         homeCarouselSlideItem: homeCarouselSlideItem,
    //       ),
    //     );
    //   }
    // }
    // );
  }
}
