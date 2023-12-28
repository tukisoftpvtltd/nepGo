part of 'home_page_bloc.dart';

@immutable
abstract class HomePageState {}

class HomePageInitial extends HomePageState {}

class HomePageLoading extends HomePageState{}

class HomePageLoaded extends HomePageState{
  final HomePageModel data;
  final Advertisement advertisement;
  final Advertisement middleAdvertisement;
  final Advertisement bottomAdvertisement;
  HomePageLoaded(this.data, this.advertisement,this.middleAdvertisement,this.bottomAdvertisement);
}

class NoDataState extends HomePageState{}

class UserLoggedIn extends HomePageState{}

class UserLoggedOut extends HomePageState{}

class LoadFirstPage extends HomePageState {}

class LoadSecondPage extends HomePageState {}

class LoadThirdPage extends HomePageState {}

class LoadFourthPage extends HomePageState {}

// class LocationLoadingState extends HomePageState {}

// class LocationLoadedState extends HomePageState {
//   String LocationName;
//   String PlaceName;
//   LocationLoadedState(this.LocationName,this.PlaceName);
// }

