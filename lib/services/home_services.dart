import 'package:ecommerce_app/models/carousel_item_model.dart';
import 'package:ecommerce_app/models/category_model.dart';
import 'package:ecommerce_app/models/product_item_model.dart';
import 'package:ecommerce_app/services/firestore_services.dart';
import 'package:ecommerce_app/utilities/api_paths.dart';

abstract class HomeServices {
  Future<List<ProductItemModel>> fetchProducts();
  Future<List<CarouselSlideModel>> fetchCarouselItems();
  Future<List<CategoryModel>> fetchCategories();
}

class HomeServicesImpl implements HomeServices {
  final firestoreServices = FirestoreServices.instance;

  @override
  Future<List<ProductItemModel>> fetchProducts() async {
    final res = await firestoreServices.getCollection<ProductItemModel>(
      path: ApiPaths.products(),
      builder: (data, documentId) => ProductItemModel.fromMap(data),
    );
    return res;
  }

  @override
  Future<List<CarouselSlideModel>> fetchCarouselItems() async {
    final res = await firestoreServices.getCollection<CarouselSlideModel>(
      path: ApiPaths.announcements(),
      builder: (data, documentId) => CarouselSlideModel.fromMap(data),
    );
    return res;
  }

  @override
  Future<List<CategoryModel>> fetchCategories() async {
    final res = await firestoreServices.getCollection<CategoryModel>(
      path: ApiPaths.categories(),
      builder: (data, documentId) => CategoryModel.fromMap(data),
    );
    return res;
  }
}
