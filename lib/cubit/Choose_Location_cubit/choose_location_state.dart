part of 'choose_location_cubit.dart';

sealed class ChooseLocationState {}

final class ChooseLocationInitial extends ChooseLocationState {}

final class FetchLocationsLoading extends ChooseLocationState {}

final class FetchLocationsSuccessLoaded extends ChooseLocationState {
  final List<LocationItemModel> locations;

  FetchLocationsSuccessLoaded({required this.locations});
}

final class FetchLocationsFailure extends ChooseLocationState {
  final String errMsg;

  FetchLocationsFailure({required this.errMsg});
}

final class AddingLocations extends ChooseLocationState {}

final class AddedLocations extends ChooseLocationState {}

final class AddingLocationsFailuer extends ChooseLocationState {
  final String errMsg;

  AddingLocationsFailuer({required this.errMsg});
}

final class LocationSelected extends ChooseLocationState {
  final String locationId;

  LocationSelected({required this.locationId});
}
