part of 'internet_bloc_bloc.dart';

abstract class InternetBlocEvent {
  const InternetBlocEvent();
}

class InternetLostEvent extends InternetBlocEvent {}

class InternetGainedEvent extends InternetBlocEvent {}

class SlowInternetEvent extends InternetBlocEvent {}
