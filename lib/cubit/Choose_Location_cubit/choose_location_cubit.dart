import 'package:ecommerce_app/models/location_item_model.dart';
import 'package:ecommerce_app/services/auth_services.dart';
import 'package:ecommerce_app/services/location_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'choose_location_state.dart';

class ChooseLocationCubit extends Cubit<ChooseLocationState> {
  ChooseLocationCubit() : super(ChooseLocationInitial());
  LocationItemModel? selectedLocation;

  final locationServices = LocationServicesImpl();
  final authServices = AuthServicesImpl();

  Future<void> fetchLocations() async {
    emit(FetchLocationsLoading());
    try {
      final currentUser = authServices.getCurrentUser();
      if (currentUser == null) return;
      final locations = await locationServices.fetchLocations(currentUser.uid);
      emit(FetchLocationsSuccessLoaded(locations: locations));
    } catch (e) {
      emit(FetchLocationsFailure(errMsg: e.toString()));
    }
  }

  Future<void> addLocation(String location) async {
    emit(AddingLocations());

    try {
      if (!location.contains('-') || location.split('-').length < 2) {
        emit(
          AddingLocationsFailuer(errMsg: 'Please use "City-Country" format'),
        );
        return;
      }
      final splittedLocation = location.split('-');
      if (splittedLocation[0].trim().isEmpty ||
          splittedLocation[1].trim().isEmpty) {
        // throw Exception('Empty fields');  throw Exception
        emit(
          AddingLocationsFailuer(
            errMsg: 'Invalid format Fields cannot be empty! Try:London-UK',
          ),
        );
        return; // without Throw Exception
      }
      final locationItem = LocationItemModel(
        id: DateTime.now().toIso8601String(),
        city: splittedLocation[0],
        country: splittedLocation[1],
      );

      final currentUser = authServices.getCurrentUser();
      if (currentUser == null) return;
      await locationServices.addLocation(currentUser.uid, locationItem);
      emit(AddedLocations());
      final locations = await locationServices.fetchLocations(currentUser.uid);
      // dummyLocations.add(locationItem);
      emit(FetchLocationsSuccessLoaded(locations: locations));
    } catch (e) {
      // emit(AddingLocationsFailuer(errMsg: e.toString())); // errMsg: 'Please use "City-Country" format'
      emit(AddingLocationsFailuer(errMsg: 'Invalid format! Try:London-UK'));
    }
  }

  void selectLocation(LocationItemModel location) {
    selectedLocation = location;
    emit(LocationSelected(locationId: location.id));
    emit(FetchLocationsSuccessLoaded(locations: List.from(dummyLocations)));
  }
}
