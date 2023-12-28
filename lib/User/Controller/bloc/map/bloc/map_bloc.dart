import 'package:bloc/bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  MapBloc() : super(MapInitial()) {
    
  bool locationloaded = false;
  String? locationName = 'null';
  String? placeName = 'null';
  Position? currentLocation;
  Position? currentPosition;
  bool loading = true;
   LatLng _center =
   LatLng(28.21754500300589, 83.98650613439649); 
    on<MapEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<MapLoadingEvent>((event, emit) async{
      try {
        print("loading");
      emit(MapLoadingState());
      
      SharedPreferences _locationDetail = await SharedPreferences.getInstance();
      String? latitude = _locationDetail.getString('latitude');
      String? longitude = _locationDetail.getString('longitude');
      print(latitude);
      if (latitude != null) {
        print("Part 1");
          _center = LatLng(double.parse(latitude!), double.parse(longitude!));
          locationloaded = true;
          loading = false;
        locationName = _locationDetail.getString('locationName');
        placeName = _locationDetail.getString('placeName');
        } else {
        currentPosition = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
        );

        List<Placemark> placemarks = await placemarkFromCoordinates(
          currentPosition!.latitude,
          currentPosition!.longitude,
          localeIdentifier: 'en',
        );
          _center =
              LatLng(currentPosition!.latitude, currentPosition!.longitude);
          Placemark currentPlacemark = placemarks.first;
          locationName = currentPlacemark.name ?? '';
          placeName = currentPlacemark.street ?? '';
          print("The current location is: $locationName, $placeName");

          loading = false;
          locationloaded = true;
         
        
      }
      print("The center is");
      print(_center.latitude);
      print(_center.longitude);
       emit(MapLoadedState(_center));
    } catch (e) {
      // Handle any errors that occur during location retrieval
      print('Error getting current location: $e');
    }
    });
  }
}
