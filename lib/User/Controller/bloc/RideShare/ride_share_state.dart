part of 'ride_share_bloc.dart';

@immutable
sealed class RideShareState {}

final class RideShareInitial extends RideShareState {}

final class DriverLoading extends RideShareState {}

final class DriverLoaded extends RideShareState {}

final class yourlocationError extends RideShareState {}

final class destinationlocationError extends RideShareState {}

final class fareError extends RideShareState {}

final class commentError extends RideShareState {}

final class diverFoundState extends RideShareState {
  
}
final class searchingForDriver extends RideShareState {
  
}

final class firstDriverFound extends RideShareState {
  Map<String, dynamic> data;
  firstDriverFound(this.data);
  
}
