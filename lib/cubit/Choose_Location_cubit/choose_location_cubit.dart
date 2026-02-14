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
    emit(AddingLocations());
    Future.delayed(Duration(seconds: 1), () {
      final splittedLocation = location.split('-');
      final locationItem = LocationItemModel(
        id: DateTime.now().toIso8601String(),
        city: splittedLocation[0],
        country: splittedLocation[1],
      );
      dummyLocations.add(locationItem);
      emit(AddedLocations());
      emit(FetchLocationsSuccessLoaded(locations: dummyLocations));
    });
  }
}
