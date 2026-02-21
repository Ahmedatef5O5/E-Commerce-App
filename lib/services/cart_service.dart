import 'package:ecommerce_app/models/add_to_cart_model.dart';
import 'package:ecommerce_app/services/firestore_services.dart';
import 'package:ecommerce_app/utilities/api_paths.dart';

abstract class CartServices {
  Stream<List<AddToCartModel>> fetchCartItems(String userId);

  Future<void> deleteCartItems(String userId, String cartItemId);
  Future<void> updateQuantity(String userId, String cartItemId, int quantity);
}

class CartServicesImpl implements CartServices {
  final firestoreServices = FirestoreServices.instance;
  @override
  Stream<List<AddToCartModel>> fetchCartItems(String userId) =>
      firestoreServices.collectionStream(
        path: ApiPaths.cartItems(userId),
        builder: (data, documentId) {
          data['id'] = documentId;
          return AddToCartModel.fromMap(data);
        },
      );

  @override
  Future<void> updateQuantity(
    String userId,
    String cartItemId,
    int quantity,
  ) async => await firestoreServices.updateData(
    path: ApiPaths.cartItem(userId, cartItemId),
    data: {'quantity': quantity},
  );

  @override
  Future<void> deleteCartItems(String userId, String cartItemId) async =>
      await firestoreServices.deleteData(
        path: ApiPaths.cartItem(userId, cartItemId),
      );
}
