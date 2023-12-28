part of 'deliveries_bloc.dart';

@immutable
sealed class DeliveriesState {}

final class DeliveriesInitial extends DeliveriesState {}

final class DeliveriesLoadingState extends DeliveriesState {}

final class DeliveriesLoadedState extends DeliveriesState {
  MyDeliveriesModel model;
  DeliveriesLoadedState(this.model);
}