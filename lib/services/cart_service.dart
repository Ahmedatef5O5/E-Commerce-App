import 'package:ecommerce_app/models/add_to_cart_model.dart';
import 'package:ecommerce_app/services/firestore_services.dart';
import 'package:ecommerce_app/utilities/api_paths.dart';

abstract class CartServices {
  Stream<List<AddToCartModel>> fetchCartItems(String userId);
}

class CartServicesImpl implements CartServices {
  final firestoreServices = FirestoreServices.instance;
  @override
  Stream<List<AddToCartModel>> fetchCartItems(String userId) =>
      firestoreServices.collectionStream(
        path: ApiPaths.cartItems(userId),
        builder: (data, documentId) => AddToCartModel.fromMap(data),
      );
}
