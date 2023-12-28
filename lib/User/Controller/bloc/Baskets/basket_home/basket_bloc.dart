import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../Model/basket_list_model.dart';
import '../../../repositories/Basket/basket_list_repository.dart';

part 'basket_event.dart';
part 'basket_state.dart';

class BasketBloc extends Bloc<BasketEvent, BasketState> {
  BasketBloc() : super(BasketInitial()) {
    on<BasketEvent>((event, emit) {
    });
     on<onBasketLoading>((event, emit)async {
      emit(BasketLoading());
      BasketListRepository basketList = new BasketListRepository();
      BasketListModel basketListModel = await basketList.fetchBasketList();
      if(basketListModel.serviceProviderWithItemsCount!.isEmpty){
        emit(BasketEmpty());
      }
      else{
        emit(BasketLoaded(basketListModel));
      }
    });

     on<onBasketLoaded>((event, emit) {
    });

     on<getBasketCounter>((event, emit)async {
      int counter=0;
      BasketListRepository basketList = new BasketListRepository();
      BasketListModel basketListModel = await basketList.fetchBasketList();
      if(basketListModel.serviceProviderWithItemsCount!.isEmpty){
        counter =0;
      }
      else{
        counter = basketListModel.serviceProviderWithItemsCount!.length;
      }
      emit(BasketCounterLoaded(counter));

    });
  }
}
