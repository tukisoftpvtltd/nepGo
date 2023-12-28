part of 'location_bloc.dart';

@immutable
abstract class LocationEvent {}

class GetlocationEvent extends LocationEvent {
  final double latitude;
  final double longitude;
  final String locationName;
  final String placeName;
  GetlocationEvent(
      this.latitude, this.longitude, this.locationName, this.placeName);
}

class OnLocationLoading extends LocationEvent {}

class OnLocationLoaded extends LocationEvent {}
