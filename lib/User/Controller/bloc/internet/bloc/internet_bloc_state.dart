part of 'internet_bloc_bloc.dart';

abstract class InternetBlocState {}

class InternetInitialState extends InternetBlocState {}

class InternetLostState extends InternetBlocState {}

class InternetGainedState extends InternetBlocState {}

class SlowInternetState extends InternetBlocState {}
