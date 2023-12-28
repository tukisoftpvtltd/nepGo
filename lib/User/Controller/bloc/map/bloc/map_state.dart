part of 'map_bloc.dart';

@immutable
sealed class MapState {}

final class MapInitial extends MapState {}

class MapLoadingState extends MapState{}


class MapLoadedState extends MapState{
  LatLng center;
  MapLoadedState(this.center);
}
