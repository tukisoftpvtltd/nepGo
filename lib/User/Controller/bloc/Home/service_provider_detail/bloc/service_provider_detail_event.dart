part of 'service_provider_detail_bloc.dart';

@immutable
abstract class ServiceProviderDetailEvent {}

class OnServiceProviderDetailLoading extends ServiceProviderDetailEvent{
  String sid;
  OnServiceProviderDetailLoading(this.sid);
}

class OnServiceProviderDetailLoaded extends ServiceProviderDetailEvent{}

class onMenuOpened extends ServiceProviderDetailEvent{}
