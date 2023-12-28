part of 'deliveries_bloc.dart';

@immutable
 class DeliveriesEvent {}

class LoadDeliveries extends DeliveriesEvent{
  String did;
  LoadDeliveries(this.did);

}
class DeliveriesLoaded extends DeliveriesEvent{

}
