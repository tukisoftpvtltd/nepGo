part of 'basket_bloc.dart';

@immutable
abstract class BasketEvent {}

class onBasketLoading extends BasketEvent{}


class onBasketLoaded extends BasketEvent{}

class getBasketCounter extends BasketEvent{
 
}