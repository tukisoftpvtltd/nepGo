import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:food_app/User/Model/Advertisement.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../Model/home_page_model.dart';
import '../../../../repositories/advertisement.dart';
import '../../../../repositories/home_repository.dart';
part 'home_page_event.dart';
part 'home_page_state.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  final homeRepository = HomePageRepository();
  HomePageModel? homePageData;
  HomePageBloc() : super(HomePageInitial()) {
    on<HomePageEvent>((event, emit) {});
  
    on<onHomePageLoading>((event,emit)async{
    emit(HomePageLoading());
    SharedPreferences locationDetail = await SharedPreferences.getInstance();
    String? latitude = locationDetail.getString('latitude');
    String? longitude = locationDetail.getString('longitude');
    print("The Latitude is");
    print(latitude);
    print("The longitude is ");
    print(longitude);
    if (latitude == null || longitude == null) {
      Position position = await Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.high,
            );
            List<Placemark> placemarks = await placemarkFromCoordinates(
              position.latitude,
              position.longitude,
              localeIdentifier: 'en',
            );
            double lat = position.latitude;
            double long = position.longitude;
            Placemark currentPlacemark = placemarks.first;
            String locationName = currentPlacemark.name ?? '';
            String placeName = currentPlacemark.street ?? '';
            print("The current location is: $locationName, $placeName");
            String latString = lat.toString();
            String longString = long.toString();
            SharedPreferences _locationDetail = await SharedPreferences.getInstance();
            _locationDetail.setString('latitude',lat.toString());
            _locationDetail.setString('longitude',long.toString());
            print("getting home data");
            HomePageRepository home = HomePageRepository();
      homePageData = await home.getHomePageData(latString, longString);
       print("getting advert data");
      GetAdvertismentRepository advertisment = GetAdvertismentRepository();
      Advertisement? advertisementData = await advertisment.GetAdvertismentList(latString,longString,"TOP");
      Advertisement? middleAdvertisementData = await advertisment.GetAdvertismentList(latString,longString,"MIDDLE");
      Advertisement? bottomAdvertisementData = await advertisment.GetAdvertismentList(latString,longString,"BOTTOM");
      if(homePageData?.featuredRestaurant.toString() == "[]"){
        emit(NoDataState());
      }
      else{
      emit(HomePageLoaded(homePageData!,advertisementData!,middleAdvertisementData!,bottomAdvertisementData!));
  
      }
      
    } else {
      HomePageRepository home = HomePageRepository();
      homePageData = await home.getHomePageData(latitude, longitude);
      GetAdvertismentRepository advertisment = GetAdvertismentRepository();
      Advertisement? advertisementData = await advertisment.GetAdvertismentList(latitude,longitude,"TOP");
      Advertisement? middleAdvertisementData = await advertisment.GetAdvertismentList(latitude,longitude,"MIDDLE");
      Advertisement? bottomAdvertisementData = await advertisment.GetAdvertismentList(latitude,longitude,"BOTTOM");
      if(homePageData?.featuredRestaurant.toString() == "[]"){
        emit(NoDataState());
      }
      else{
      emit(HomePageLoaded(homePageData!,advertisementData!,middleAdvertisementData!,bottomAdvertisementData!));
      }
    }
    });
     on<onNoData>((event,emit){
      emit(NoDataState());
    });

    // on<onLocationLoading>((event,emit)async{
    //   LocationPermission permission = await Geolocator.checkPermission();
    //     try {
    //   if (permission == LocationPermission.denied) {
    //     permission = await Geolocator.requestPermission();
    //     if (permission == LocationPermission.denied) {
    //       return Future.error('Location permissions are denied');
    //     }
    //     if (permission == LocationPermission.deniedForever) {
    //       return Future.error(
    //           'Location permissions are permanently denied, we cannot request');
    //     }
    //   }
    // } catch (e) {}
    //   try {
    //   emit(LocationLoadingState());
    //   print("Location Loading");
      
    //   SharedPreferences _locationDetail = await SharedPreferences.getInstance();
    //   String? latitude = _locationDetail.getString('latitude');
    //   String? locationName = '';
    //   String? placeName = '';
    //   Position? currentLocation;
    //   double? lat;
    //   double? long;
    //   if (latitude != '') {
    //     print("Location Loaded1");
    //     locationName = _locationDetail.getString('locationName')!;
    //     placeName = _locationDetail.getString('placeName')!;
        
    //     emit(LocationLoadedState(locationName,placeName));
    //   } else {
       
    //     if (permission == LocationPermission.denied) {
    //        print("Permission Denied2");
    //       permission = await Geolocator.requestPermission();
    //       if (permission == LocationPermission.denied) {
    //         print("Location Loaded2");
    //         return Future.error('Location permissions are denied');
    //       }
    //       if (permission == LocationPermission.deniedForever) {
    //          print("Location Loaded3");
    //         return Future.error(
    //             'Location permissions are permanently denied, we cannot request');
    //       } else {
            
    //         Position position = await Geolocator.getCurrentPosition(
    //           desiredAccuracy: LocationAccuracy.high,
    //         );
    //         List<Placemark> placemarks = await placemarkFromCoordinates(
    //           position.latitude,
    //           position.longitude,
    //           localeIdentifier: 'en',
    //         );
    //         lat = position.latitude;
    //         long = position.longitude;
    //         Placemark currentPlacemark = placemarks.first;
    //         locationName = currentPlacemark.name ?? '';
    //         placeName = currentPlacemark.street ?? '';
    //         print("The current location is: $locationName, $placeName");
    //          emit(LocationLoadedState(locationName,placeName));
    //       }
         
    //     }
    //   }
    // } catch (e) {
    //   print('Error getting current location: $e');
    // }
    
    // });
  }
}
