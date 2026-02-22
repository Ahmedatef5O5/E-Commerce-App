import 'package:ecommerce_app/models/location_item_model.dart';
import 'package:ecommerce_app/services/firestore_services.dart';
import 'package:ecommerce_app/utilities/api_paths.dart';

abstract class LocationServices {
  Future<List<LocationItemModel>> fetchLocations(String userId);
  Future<void> addLocation(String userId, LocationItemModel locationItem);
}

class LocationServicesImpl implements LocationServices {
  final firestoreServices = FirestoreServices.instance;

  @override
  Future<void> addLocation(
    String userId,
    LocationItemModel locationItem,
  ) async => await firestoreServices.setData(
    path: ApiPaths.location(userId, locationItem.id),
    data: locationItem.toMap(),
  );

  @override
  Future<List<LocationItemModel>> fetchLocations(String userId) async {
    throw UnimplementedError();
  }
}
