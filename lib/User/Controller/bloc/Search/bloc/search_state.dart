part of 'search_bloc.dart';

abstract class SearchState {}

class SearchInitial extends SearchState {}

class SearchLoadingState extends SearchState{

}
class SearchLoadedState extends SearchState{
      List searchData;
      SearchLoadedState(this.searchData);
}
