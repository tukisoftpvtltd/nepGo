import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:food_app/User/Model/service_provider_detail_model.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../repositories/service_provider_repository.dart';
part 'service_provider_detail_event.dart';
part 'service_provider_detail_state.dart';

class ServiceProviderDetailBloc extends Bloc<ServiceProviderDetailEvent, ServiceProviderDetailState> {
  ServiceProviderDetailBloc() : super(ServiceProviderDetailInitial()) {
    on<ServiceProviderDetailEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<OnServiceProviderDetailLoading>((event, emit) async{
      
    emit(ServiceProviderDetailLoadingState());
    SharedPreferences userData = await SharedPreferences.getInstance();
    String? userId = userData.getString('user_id');
    print("The userId is");
    print(userId);
    // if(userId!.isEmpty){
    //   userId = "0";
    // }
    if(userId == null){
      userId = "0";
    }
    print(userId);
    ServiceProviderDetailRepository serviceProvider = new ServiceProviderDetailRepository();
    ServiceProviderDetailModel? response =
        await serviceProvider.getServiceProviderData(userId,event.sid);
      emit(ServiceProviderDetailLoadedState(response!));
    });
    on<OnServiceProviderDetailLoaded>((event, emit) {
    });
  }
}
