import 'package:ecommerce_app/models/location_item_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'choose_location_state.dart';

class ChooseLocationCubit extends Cubit<ChooseLocationState> {
  ChooseLocationCubit() : super(ChooseLocationInitial());

  void fetchLocations() {
    emit(FetchLocationsLoading());
    Future.delayed(Duration(seconds: 1), () {
      emit(FetchLocationsSuccessLoaded(locations: dummyLocations));
    });
  }

  void addLocation(String location) {
    try {
      if (!location.contains('-') || location.split('-').length < 2) {
        emit(
          AddingLocationsFailuer(errMsg: 'Please use "City-Country" format'),
        );
        return;
      }
      emit(AddingLocations());
      Future.delayed(Duration(seconds: 1), () {
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
        dummyLocations.add(locationItem);
        emit(AddedLocations());
        emit(FetchLocationsSuccessLoaded(locations: dummyLocations));
      });
    } catch (e) {
      // emit(AddingLocationsFailuer(errMsg: e.toString())); // errMsg: 'Please use "City-Country" format'
      emit(AddingLocationsFailuer(errMsg: 'Invalid format! Try:London-UK'));
    }
  }
}
