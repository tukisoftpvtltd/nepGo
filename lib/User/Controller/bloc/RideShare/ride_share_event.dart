part of 'ride_share_bloc.dart';

@immutable
sealed class RideShareEvent {}

class findRideShareDriver extends RideShareEvent{
  BuildContext context;
  String category;
  String yourLocation;
  String destinationLocation;
  String fare;
  String comment;
  double sourceLat;
  double sourceLong;
  double destinationLat;
  double destinationLong;
  Function orderAccepted;
  findRideShareDriver(
    this.context,
    this.category,
    this.yourLocation,
    this.destinationLocation,
    this.fare,
    this.comment,
    this.sourceLat,this.sourceLong,
    this.destinationLat,this.destinationLong,
    this.orderAccepted);
}


class findDriver extends RideShareEvent{
  
}
class driverFound extends RideShareEvent{
  
  
}