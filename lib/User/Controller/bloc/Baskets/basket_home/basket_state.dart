part of 'basket_bloc.dart';

@immutable
abstract class BasketState {}

class BasketInitial extends BasketState {}

class BasketLoading extends BasketState {}

class BasketLoaded extends BasketState {
  BasketListModel basketListModel;
  BasketLoaded(this.basketListModel);
}

class BasketEmpty extends BasketState {}

class BasketCounter extends BasketState {}

class BasketCounterLoaded extends BasketState {
  int count;
  BasketCounterLoaded(this.count);
}