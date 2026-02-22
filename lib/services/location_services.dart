import 'package:ecommerce_app/models/location_item_model.dart';
import 'package:ecommerce_app/services/firestore_services.dart';
import 'package:ecommerce_app/utilities/api_paths.dart';

abstract class LocationServices {
  Future<List<LocationItemModel>> fetchLocations(String userId);
  Future<void> addLocation(String userId, LocationItemModel locationItem);
  Future<void> selectLocation(String userId, String locationId);
  Future<void> deleteLocation(String userId, String locationId);
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
  Future<List<LocationItemModel>> fetchLocations(String userId) async =>
      await firestoreServices.getCollection(
        path: ApiPaths.locations(userId),
        builder: (data, documentId) => LocationItemModel.fromMap(data),
      );

  @override
  Future<void> selectLocation(String userId, String locationId) async {
    final allLocations = await fetchLocations(userId);
    for (var loc in allLocations) {
      await firestoreServices.updateData(
        path: ApiPaths.location(userId, loc.id),
        data: {'isChosen': loc.id == locationId},
      );
    }
  }

  @override
  Future<void> deleteLocation(String userId, String locationId) async =>
      await firestoreServices.deleteData(
        path: ApiPaths.location(userId, locationId),
      );
}
