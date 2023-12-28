import 'package:bloc/bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  LocationBloc() : super(LocationInitial()) {
    on<LocationEvent>((event, emit) {
      // TODO: implement event handler
    });
     on<OnLocationLoading>((event,emit)async{
      emit(LocationLoadingState());
      LocationPermission permission = await Geolocator.checkPermission();
        try {
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
        if (permission == LocationPermission.deniedForever) {
          return Future.error(
              'Location permissions are permanently denied, we cannot request');
        }
      
    } catch (e) {}
      try {
      SharedPreferences _locationDetail = await SharedPreferences.getInstance();
      String? latitude = _locationDetail.getString('latitude');
      String? longitude= _locationDetail.getString('longitude');
      String? locationName = '';
      String? placeName = '';
      Position? currentLocation;
      double? lat;
      double? long;
      print(latitude);
      print(longitude);
      if (latitude != null) {
        print("Location was saved");
        locationName = _locationDetail.getString('locationName')!;
        placeName = _locationDetail.getString('placeName')!;
        print(locationName);
        print(placeName);
        emit(LocationLoadedState(locationName,placeName,latitude,longitude!));
        print("Location was saved");
      }
      else if(latitude == null ){
        print("location was not saved");
        Position position = await Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.high,
            );
            List<Placemark> placemarks = await placemarkFromCoordinates(
              position.latitude,
              position.longitude,
              localeIdentifier: 'en',
            );
            lat = position.latitude;
            long = position.longitude;
            Placemark currentPlacemark = placemarks.first;
            locationName = currentPlacemark.name ?? '';
            placeName = currentPlacemark.street ?? '';
            _locationDetail.setString('locationName',locationName);
            _locationDetail.setString('placeName',placeName);
            _locationDetail.setString('latitude',lat.toString());
            _locationDetail.setString('longitude',long.toString());
            print("The current location is: $locationName, $placeName");
            print(locationName);
            print(placeName);
            print(lat.toString());
            print(long.toString());
             emit(LocationLoadedState(locationName,placeName,lat.toString(),long.toString()));

      } else {
       
          if (permission == LocationPermission.denied) {
            permission = await Geolocator.requestPermission();
          }
          else if (permission == LocationPermission.deniedForever) {
            return Future.error(
                'Location permissions are permanently denied, we cannot request');
          } else {
            Position position = await Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.high,
            );
            List<Placemark> placemarks = await placemarkFromCoordinates(
              position.latitude,
              position.longitude,
              localeIdentifier: 'en',
            );
            lat = position.latitude;
            long = position.longitude;
            Placemark currentPlacemark = placemarks.first;
            locationName = currentPlacemark.name ?? '';
            placeName = currentPlacemark.street ?? '';
            print("The current location is: $locationName, $placeName");
            emit(LocationLoadedState(locationName,placeName,latitude,longitude!));
          }
         
        
      }
    } catch (e) {
      print('Error getting current location: $e');
    }
    
    });
  }
}
