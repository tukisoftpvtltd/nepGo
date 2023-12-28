import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/User/Controller/bloc/Baskets/basket_home/basket_bloc.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';

import '../../../../../Model/basket_list_model.dart';
import '../../../../../View/Screens/HomeScreens/Home/HomeScreensNavigation.dart';
import '../../../../repositories/Basket/basket_list_repository.dart';
import '../../../Account/sign_in/bloc/sign_in_bloc.dart';
import '../../../Home/home_navigation/home_navigation_bloc.dart';
import '../../../Home/home_page/bloc/home_page_bloc.dart';

part 'basket_detail_event.dart';
part 'basket_detail_state.dart';

class BasketDetailBloc extends Bloc<BasketDetailEvent, BasketDetailState> {
  BasketDetailBloc() : super(BasketDetailInitial()) {
    on<BasketDetailEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<onBasketDetailLoading>((event, emit) async {
      emit(BasketDetailLoading());
      BasketListRepository basketList = new BasketListRepository();
      BasketListModel basketListModel = await basketList.fetchBasketList();
      List BasketList = basketListModel.serviceProviderWithItemsCount!;
      int BasketListLength = BasketList.length;
      int count = 0;
      var ServiceProviderData;
      List BasketItem = [];
      bool loading = true;
      int total_sum = 0;
      for (int i = 0; i < BasketListLength; i++) {
        if (event.sid ==
            basketListModel.serviceProviderWithItemsCount![i].sId) {
          print("The Service Provider Data is");
          ServiceProviderData =
              basketListModel.serviceProviderWithItemsCount![i];
          BasketItem =
              basketListModel.serviceProviderWithItemsCount![i].basketItems!;
          print("The Basket Item is");
          print(BasketItem);
          count++;
        }
      }
      print("The Basket Items are:");
      for (int k = 0; k < BasketItem.length; k++) {
        int OneRate = BasketItem[k].rate;
        int OneQuantity = BasketItem[k].quantity;
        total_sum += OneRate * OneQuantity;
      }
      loading = false;
      if (count == 0) {
        Get.offAll(BlocProvider<SignInBloc>(
          create: (context) => SignInBloc(context),
          child: BlocProvider<HomePageBloc>(
            create: (context) => HomePageBloc(),
            child: BlocProvider(
              create: (context) => HomeNavigationBloc(),
              child: BlocProvider(
                create: (context) => BasketBloc(),
                child: HomeScreensNavigation(
                  currentIndexNumber: 1,
                  loginStatus: "true",
                  homeData: [],
                  advertisementData: [],
                ),
              ),
            ),
          ),
        ));
      } else {
        emit(BasketDetailLoaded(BasketItem, ServiceProviderData, total_sum));
      }
    });

    on<onBasketLoaded>((event, emit) {});
  }
}
