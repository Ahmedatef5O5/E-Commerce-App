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

// List<CarouselSlideModel> dummyHomeCarouselItems = [
//   CarouselSlideModel(
//     id: 'jf385EsSP2RzdIKucgW7',
//     imgPath:
//         'https://edit.org/photos/img/blog/mbp-template-banner-online-store-free.jpg-840.jpg',
//   ),
//   CarouselSlideModel(
//     id: 'btgMW23JED1zRsxqdKms',
//     imgPath:
//         'https://casalsonline.es/wp-content/uploads/2018/12/CASALS-ONLINE-18-DICIEMBRE.png',
//   ),
//   CarouselSlideModel(
//     id: 'XjZBor795dLTO2ErQGi3',
//     imgPath:
//         'https://e0.pxfuel.com/wallpapers/606/84/desktop-wallpaper-ecommerce-website-design-company-noida-e-commerce-banner-design-e-commerce.jpg',
//   ),
//   CarouselSlideModel(
//     id: '8u3jP9mBZYVSGq7JGoc6',
//     imgPath:
//         'https://marketplace.canva.com/EAFMdLQAxDU/1/0/1600w/canva-white-and-gray-modern-real-estate-modern-home-banner-NpQukS8X1oo.jpg',
//   ),
// ];
