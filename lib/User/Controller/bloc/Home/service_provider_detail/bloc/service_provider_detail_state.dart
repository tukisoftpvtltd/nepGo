part of 'service_provider_detail_bloc.dart';

@immutable
abstract class ServiceProviderDetailState {}

class ServiceProviderDetailInitial extends ServiceProviderDetailState {}

class ServiceProviderDetailLoadingState extends ServiceProviderDetailState {}

class ServiceProviderDetailLoadedState extends ServiceProviderDetailState {
  ServiceProviderDetailModel data;
  ServiceProviderDetailLoadedState(this.data);
}

class MenuOpenState extends ServiceProviderDetailState {}
