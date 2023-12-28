part of 'home_page_bloc.dart';

@immutable
abstract class HomePageEvent {}


class onHomePageLoading extends HomePageEvent {
  onHomePageLoading();
}
class FetchDataEvent extends HomePageEvent {}

class onHomePageLoaded extends HomePageEvent {
  onHomePageLoaded();
}

class onNoData extends HomePageEvent {
  onNoData();
}
// class onLocationLoading extends HomePageEvent {
//   onLocationLoading();
// }
// class onLocationLoaded extends HomePageEvent {
//   onLocationLoaded();
// }

