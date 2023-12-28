part of 'search_bloc.dart';

abstract class SearchEvent {}

class SearchLoading extends SearchEvent{
    int index;
    String searchKey;
    bool BestMatch;
    bool TopSales;
    bool New;
    String openPlace;
    String name;
    String distance;
    String sales;
    SearchLoading(
      this.index,
      this.searchKey,
      this.BestMatch,
      this.TopSales,
      this.New,
      this.openPlace,
      this.name,
      this.distance,
      this.sales);
}
class SearchLoaded extends SearchEvent{
  
}