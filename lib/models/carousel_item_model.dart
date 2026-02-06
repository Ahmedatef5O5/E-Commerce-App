import 'package:ecommerce_app/utilities/app_images.dart';

class CarouselSlideModel {
  final String id, imgPath;

  CarouselSlideModel({required this.id, required this.imgPath});
}

List<CarouselSlideModel> homeCarouselSlideItem = [
  CarouselSlideModel(id: '1', imgPath: AppImages.slider1),
  CarouselSlideModel(id: '2', imgPath: AppImages.slider2),
  CarouselSlideModel(id: '3', imgPath: AppImages.slider3),
];
