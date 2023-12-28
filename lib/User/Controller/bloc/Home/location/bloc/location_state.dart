part of 'location_bloc.dart';

@immutable
abstract class LocationState {}

class LocationInitial extends LocationState {}

class LocationLoadingState extends LocationState {}

class LocationLoadedState extends LocationState {
  String LocationName;
  String PlaceName;
  String latitude;
  String longitude;
  LocationLoadedState(this.LocationName,this.PlaceName,this.latitude,this.longitude);
}

