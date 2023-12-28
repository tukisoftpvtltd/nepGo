import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/User/View/custome_loader.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart' as places;
import 'package:google_maps_webservice/places.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../Controller/bloc/Baskets/basket_home/basket_bloc.dart';
import '../../../../../Controller/bloc/Home/home_navigation/home_navigation_bloc.dart';
import '../../../../../Controller/bloc/Home/home_page/bloc/home_page_bloc.dart';
import '../../../../../Controller/bloc/Home/location/bloc/location_bloc.dart';
import '../../../../constants/colors.dart';
import '../HomeScreensNavigation.dart';

class MapPage3 extends StatefulWidget {
    bool? fromPayment;
  LatLng? centerPoint;
  Function? callback;
  MapPage3({super.key,
  this.fromPayment,
  this.centerPoint,
  this.callback});

  @override
  State<MapPage3> createState() => _MapPage3State();
}

class _MapPage3State extends State<MapPage3> {
  bool showMap = true;
  GoogleMapController? _mapController;
  List<places.Prediction> _suggestions = [];
  TextEditingController _searchController = TextEditingController();
  final places.GoogleMapsPlaces _places = places.GoogleMapsPlaces(
      apiKey: "AIzaSyBV7ECMpja47Pu0shoRXUMUAPYY2CSX8n0");
  void _onTextChanged(String value) async {
    final response = await _places.autocomplete(
      value,
      components: [Component(places.Component.country, "NP")],
    );
    print(value);
    if (response.isOkay) {
      setState(() {
        _suggestions = response.predictions;
        print(_suggestions[0].description.toString());
      });
    }
    if (value == '') {
      setState(() {
        _suggestions = [];
      });
    }
  }
  bool disappear = false;
  void _onSearchButtonPressed(String input) async {
    print("The nimput value is");
    setState(() {
      _suggestions = [];
    });
    print(input);
    if (input.isNotEmpty) {
      final places =
          GoogleMapsPlaces(apiKey: 'AIzaSyBV7ECMpja47Pu0shoRXUMUAPYY2CSX8n0');
      PlacesSearchResponse response = await places.searchByText(input);
      print("The latitude and longitude is");
      if (response.isOkay && response.results.isNotEmpty) {
        final place = response.results[0];
        print(place.geometry?.location.lat);
        print(place.geometry?.location.lng);
        _mapController?.animateCamera(
          CameraUpdate.newLatLng(LatLng(place.geometry?.location.lat ?? 0,
              place.geometry?.location.lng ?? 0)),
        );
        setState(() {
          disappear = false;
        });
        FocusScope.of(context).requestFocus(FocusNode());
      }
    }
  }
    Widget _buildSuggestionsList() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: _suggestions.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(_suggestions[index].description.toString()),
          onTap: () {
            _searchController.text = _suggestions[index].description.toString();
            _onSearchButtonPressed(_searchController.text);
          },
        );
      },
    );
  }
  LatLng? _center ;
  double latitude =0.0;
  double longitude =0.0;
  @override
  void initState() {
    print("here");
    latitude = widget.centerPoint!.latitude;
  longitude= widget.centerPoint!.longitude;
    print(widget.centerPoint);
    //setState(() {
      _center = widget.centerPoint ?? LatLng(28.215238987519914, 83.97509330307373) ;
    //});
    
    super.initState();
  }
  bool loading=false;
   bool locationloaded = false;
  String? locationName = 'null';
  String? placeName = 'null';
  Position? currentLocation;
  Position? currentPosition;
  
    Future<void> getLocation(double latitude, double longitude) async {
    try {
      setState(() {
        loading = true;
      });
      print("the loader is");
      print(loading);
      SharedPreferences _locationDetail = await SharedPreferences.getInstance();
      List<Placemark> placemarks = await placemarkFromCoordinates(
        latitude,
        longitude,
        localeIdentifier: 'en',
      );

      Placemark currentPlacemark = placemarks.first;
      setState(() {
        loading = true;
        locationName = currentPlacemark.name ?? '';
        placeName = currentPlacemark.street ?? '';
        _locationDetail.setString('locationName', locationName!);
        _locationDetail.setString('placeName', placeName!);
        _locationDetail.setString('latitude', latitude.toString()!);
        _locationDetail.setString('longitude', longitude.toString()!);
        locationloaded = true;
        print("The current location is: $locationName, $placeName");
      });
      await Future.delayed(Duration(seconds: 2));
      if (widget.fromPayment == true) {
        
        print("This is from payment page");
        await Future.delayed(Duration(seconds: 2));
        setState(() {
          showMap =false;
        });
        widget.callback!();
        Get.back();
        Get.back();
      } else {
        Get.offAll(BlocProvider(
          create: (context) => HomePageBloc(),
          child: BlocProvider(
            create: (context) => HomeNavigationBloc(),
            child: BlocProvider(
              create: (context) => LocationBloc(),
              child: BlocProvider(
                create: (context) => BasketBloc(),
                child: HomeScreensNavigation(
                  currentIndexNumber: 0,
                  loginStatus: "true",
                  homeData: [],
                  advertisementData: [],
                ),
              ),
            ),
          ),
        ));
      }
    } catch (e) {
      // Handle any errors that occur during location retrieval
      print('Error getting current location: $e');
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
          //   print("Will pop scope called");
          //   setState(() {
          //     loading = true;
          //     showMap = false;
          //   });
          //   Future.delayed(Duration(seconds: 2), () {
          //   Get.back();
          // });
          return false;
      },
      child: Scaffold(
         resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: BackButton(
            color: Colors.black,
            onPressed: (){
              setState(() {
                loading = true;
              });
              Future.delayed(Duration(seconds: 2), () {
                setState(() {
                showMap = false;
              });
              Get.back();
            });
            
            },
          ),
          title: const Text(
                  "Set Delivery Location",
                  style: TextStyle(color: Colors.black),
                ),
        ),
        body:
        Stack(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
              child:showMap ?  GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: _center!,
                    zoom: 20.0, // Initial zoom level
                  ),
                  onMapCreated: (GoogleMapController controller) {
                   _mapController = controller;
                  },
                  myLocationEnabled: true,
                  onCameraMove: (CameraPosition position){
                    latitude = position.target.latitude;
                    longitude = position.target.longitude;
                  },
                ):Container(),
            ),
              Align(alignment: Alignment.center,
                          child: Container(
                            child: Icon(
                              Icons.location_pin,
                              size: 60,
                              color: Colours.primarygreen,
                            ),
                          ),
                        ),
              showMap? Padding(
                padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
                child: Container(
                                  color: Colors.white,
                                  child: _buildSuggestionsList()),
              ):Container(),
               showMap?Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 5),
                    child: Container(
                                    width: 500,
                                    height: 40,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(color: Colors.grey)),
                                    child: TextFormField(
                                      style: TextStyle(fontSize: 16),
                                      controller: _searchController,
                                      decoration: InputDecoration(
                                        hintText: 'Search...',
                                        border: InputBorder.none,
                                        hintStyle: TextStyle(fontSize: 16),
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 16, vertical: 0),
                                        suffixIcon: IconButton(
                                          icon: Icon(Icons.search),
                                          onPressed: () {},
                                        ),
                                      ),
                                      onChanged: _onTextChanged,
                                      onTap: () {
                                      },
                                    ),
                                  ),
                  ),
                   
                   Padding(
                     padding: const EdgeInsets.fromLTRB(0, 0, 0, 30),
                     child: Center(
                       child: Container(
                        width: Get.width*0.55,
                         child: ElevatedButton(
                          
                          onPressed: () async {
                                                      getLocation(
                                                          latitude
                                                              .toDouble(),
                                                         longitude
                                                              .toDouble());
                                                    },
                                                    child: Text("SET LOCATION"),
                                                    style: ButtonStyle(
                                                      
                                                      backgroundColor:
                                                          MaterialStateProperty.all<Color>(
                                                              Colours.primarygreen),
                                                    ),
                                                  ),
                       ),
                     ),
                   ),
                   
                 ],
               ):Container(),
              
              loading ? CustomeLoader():Container(),
          ],
        ),
      ),
    );
  }
}