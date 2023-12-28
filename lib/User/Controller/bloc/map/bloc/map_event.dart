part of 'map_bloc.dart';

@immutable
sealed class MapEvent {}

class MapLoadingEvent extends MapEvent{}

class MapLoadedEvent extends MapEvent{}