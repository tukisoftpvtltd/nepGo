part of 'basket_detail_bloc.dart';

@immutable
abstract class BasketDetailEvent {}

class onBasketDetailLoading extends BasketDetailEvent{
  String sid;
  onBasketDetailLoading(this.sid);

}

class onBasketLoaded extends BasketDetailEvent{}