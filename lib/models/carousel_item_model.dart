import 'package:ecommerce_app/utilities/app_images.dart';

class CarouselSlideModel {
  final String id;
  final String imgPath;

  CarouselSlideModel({required this.id, required this.imgPath});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'id': id, 'imgPath': imgPath};
  }

  factory CarouselSlideModel.fromMap(Map<String, dynamic> map) {
    return CarouselSlideModel(
      id: map['id'] as String,
      imgPath: map['imgPath'] as String,
    );
  }

  // String toJson() => json.encode(toMap());

  // factory CarouselSlideModel.fromJson(String source) => CarouselSlideModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

List<CarouselSlideModel> homeCarouselSlideItem = [
  CarouselSlideModel(id: '1', imgPath: AppImages.slider1),
  CarouselSlideModel(id: '2', imgPath: AppImages.slider2),
  CarouselSlideModel(id: '3', imgPath: AppImages.slider3),
];
