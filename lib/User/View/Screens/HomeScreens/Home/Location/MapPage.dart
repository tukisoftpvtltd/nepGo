import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/User/Controller/bloc/Home/home_navigation/home_navigation_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../Controller/bloc/Baskets/basket_home/basket_bloc.dart';
import '../../../../../Controller/bloc/Home/home_page/bloc/home_page_bloc.dart';
import '../../../../../Controller/bloc/Home/location/bloc/location_bloc.dart';
import '../../../../constants/colors.dart';
import '../../../../custome_loader.dart';
import '../HomeScreensNavigation.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:google_maps_webservice/places.dart' as places;

class MapPage extends StatefulWidget {
  bool? fromPayment;
  PageController? page;
  LatLng? centerPoint;
  Function? callback;
  MapPage(
      {super.key,
      this.fromPayment,
      this.page,
      this.centerPoint,
      this.callback});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  LatLng _center =
      LatLng(28.21754500300589, 83.98650613439649); // Initial map center
  LatLng markerPosition = LatLng(28.21754500300589, 83.98650613439649);
  void findLocation() {
    final double latitude = markerPosition.latitude;
    final double longitude = markerPosition.longitude;
  }

  Set<Marker> markers = {};

  GoogleMapController? mapController;
  Marker staticMarker = Marker(
    markerId: MarkerId('static_marker'),
    position: LatLng(0, 0),
    draggable: false,
  );

  bool locationloaded = false;
  String? locationName = 'null';
  String? placeName = 'null';
  Position? currentLocation;
  Position? currentPosition;
  bool loading = false;



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
        await Future.delayed(Duration(seconds: 2));
        widget.callback!();
        // BlocProvider.of<LocationBloc>(context).add(OnLocationLoading());
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
  initState() {
    
    super.initState();
    _center =widget.centerPoint ?? LatLng(28.21754500300589, 83.98650613439649);
  }
  bool backButtonClicked = false;

   @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    print("the map controller is");
    print(mapController);
    // if(backButtonClicked){
    //   return Scaffold();
    // }
    try{
    return  WillPopScope(
      onWillPop: () async {
        if (mapIsRendering == false) {
          setState(() {
            loading = true;
          });
          mapController?.dispose();
          await Future.delayed(Duration(seconds: 1));
          setState(() {
            makeTheMapDisappear = true;
          });
          await Future.delayed(Duration(milliseconds: 100));
          print("The widget page is");
          print(widget.page);
          if (widget.page == null) {
            print("heree");
            // Get.back();
          } else {
            print("here 2");
            widget.page?.animateToPage(
              0,
              duration: Duration(milliseconds: 400),
              curve: Curves.easeInOut,
            );
          }
          //  Get.back();
          return true;
        } else {
          return false;
        }
      },
      child: Stack(
        children: [
          Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              leading: BackButton(
                  color: Colors.black,
                  onPressed: () async {
                    try{
                      backButtonClicked= true;
                    if (widget.page == null) {
                      setState(() {
                        loading = true;
                      });
                      mapController?.dispose();
                      await Future.delayed(Duration(seconds: 1));
                      setState(() {
                        makeTheMapDisappear = true;
                      });
                      await Future.delayed(Duration(milliseconds: 100));
                      Get.back();
                    } else {
                      setState(() {
                        loading = true;
                      });
                      mapController?.dispose();
                      await Future.delayed(Duration(seconds: 1));
                      setState(() {
                        makeTheMapDisappear = true;
                      });
                      await Future.delayed(Duration(milliseconds: 100));

                      widget.page?.animateToPage(
                        0,
                        duration: Duration(milliseconds: 400),
                        curve: Curves.easeInOut,
                      );
                    }
                  } 
                  catch(e){
                    print("An error Occured");
                    Get.back();
                  }
               }),
              title:const Text(
                "Set Delivery Location",
                style: TextStyle(color: Colors.black),
              ),
            ),
            body: makeTheMapDisappear
                ? Container()
                : Stack(
                    children: [
                      Container(
                        height: Get.height,
                        width: Get.width,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
                          child: buildMap()
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          child: Icon(
                            Icons.location_pin,
                            size: 60,
                            color: Colours.primarygreen,
                          ),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 200,
                                height: 35,
                                child: disappear == false
                                    ? ElevatedButton(
                                        onPressed: () async {
                                          getLocation(
                                              markerPosition.latitude
                                                  .toDouble(),
                                              markerPosition.longitude
                                                  .toDouble());
                                        },
                                        child: Text("SET LOCATION"),
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all<Color>(
                                                  Colours.primarygreen),
                                        ),
                                      )
                                    : Container(),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 50,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            color: Colors.white,
                            child: Padding(
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
                          ),
                          Container(
                              color: Colors.white,
                              child: _buildSuggestionsList())
                        ],
                      ),
                      loading ? Container(child: CustomeLoader()) : Container()
                    ],
                  ),
          ),
        ],
      ),
    );
  }
  catch(e){
    return Container(child: Text("Error Occured"),);
  }
  }


  Widget buildMap(){
    try{
       return GoogleMap(
                            gestureRecognizers:
                                <Factory<OneSequenceGestureRecognizer>>[
                              new Factory<OneSequenceGestureRecognizer>(
                                () => new EagerGestureRecognizer(),
                              ),
                            ].toSet(),
                            myLocationEnabled: true,
                            myLocationButtonEnabled: true,
                            indoorViewEnabled: true,
                            mapType: MapType.normal,
                            onMapCreated: (controller) {
                              print("--------------------Map creating----------------");
                              setState(() {
                                loading = false;
                              });
                              mapController = controller;
                            },
                            onCameraMove: (cameraPosition) {
                              setState(() {
                                markerPosition = cameraPosition.target;
                                mapIsRendering = true;
                              });
                            },
                            onCameraIdle: () {
                              setState(() {
                                mapIsRendering = false;
                              });
                            },
                            initialCameraPosition:
                                CameraPosition(target: _center, zoom: 17),
                            onTap: (position) {},
                            markers: markers,
                          );
  
    }
    catch(e){
      print("some error occured");
      return Text("Error Occured");
    }
     
  }


  @override
  void dispose() {
    print("dispose");
    mapController!.dispose();
    super.dispose();
  }

  final places.GoogleMapsPlaces _places = places.GoogleMapsPlaces(
      apiKey: "AIzaSyBV7ECMpja47Pu0shoRXUMUAPYY2CSX8n0");
  List<places.Prediction> _suggestions = [];
  TextEditingController _searchController = TextEditingController();
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
        mapController?.animateCamera(
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

  bool disappear = false;
  void _onTextChanged(String value) async {
    final response = await _places.autocomplete(
      value,
      components: [Component(Component.country, "NP")],
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

  bool makeTheMapDisappear = false;
  bool mapIsRendering = false;
 
}
