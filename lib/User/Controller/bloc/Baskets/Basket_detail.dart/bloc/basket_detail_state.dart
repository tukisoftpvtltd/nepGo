part of 'basket_detail_bloc.dart';

@immutable
abstract class BasketDetailState {}

class BasketDetailInitial extends BasketDetailState {}

class BasketDetailLoading extends BasketDetailState {}

class BasketDetailLoaded extends BasketDetailState {
  List BasketItem;
  var ServiceProviderData;
  int total_sum;
  BasketDetailLoaded(this.BasketItem,this.ServiceProviderData,this.total_sum);

}
