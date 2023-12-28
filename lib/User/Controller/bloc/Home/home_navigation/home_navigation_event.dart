part of 'home_navigation_bloc.dart';

@immutable
abstract class HomeNavigationEvent {}
class onHomeIndexChanged extends HomeNavigationEvent {
  final int index;
  onHomeIndexChanged(this.index);
}