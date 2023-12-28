import 'package:flutter/material.dart';
import 'package:food_app/Driver/View/components/colors.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart' as places;
import 'package:google_maps_webservice/places.dart';

import 'Views/LocationMap.dart';

class FromLocation extends StatefulWidget {
  Function callback;
  String type;
  double latValue;
  double longValue;
  FromLocation({super.key,required this.callback,required this.type,
  required this.latValue,required this.longValue});

  @override
  State<FromLocation> createState() => _FromLocationState();
}

class _FromLocationState extends State<FromLocation> {
  TextEditingController _searchController = TextEditingController();
    GoogleMapController? _mapController;
    final places.GoogleMapsPlaces _places = places.GoogleMapsPlaces(
      apiKey: "AIzaSyBV7ECMpja47Pu0shoRXUMUAPYY2CSX8n0");
      List<places.Prediction> _suggestions = [];
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
      double? latitude;
      double? longitude;
      if (response.isOkay && response.results.isNotEmpty) {
        final place = response.results[0];
        latitude = place.geometry?.location.lat;
        longitude = place.geometry?.location.lng;
      }
        // _mapController?.animateCamera(
        //   CameraUpdate.newLatLng(LatLng(place.geometry?.location.lat ?? 0,
        //       place.geometry?.location.lng ?? 0)),
        // );
        FocusScope.of(context).requestFocus(FocusNode());
        widget.callback(input,latitude,longitude);
        Get.back();
      //}
    }
  }
  final FocusNode _firstTextFieldFocus = FocusNode();

  @override
  void initState() {
     Future.delayed(Duration.zero, () {
      FocusScope.of(context).requestFocus(_firstTextFieldFocus);
    });
    // TODO: implement initState
    super.initState();
  }

   @override
  void dispose() {
    // Dispose of the FocusNode to avoid memory leaks
    _firstTextFieldFocus.dispose();
    super.dispose();
  }
  String location = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: BackButton(color: Colors.black,
        onPressed: (){
           FocusManager.instance.primaryFocus?.unfocus();
           
          Get.back();
        },),
        title: Text(
          widget.type == 'from'? 'From Location':'To Location',style: TextStyle(color: Colors.black,fontSize: 16),),
      ),
      body: Column(
        children: [
          Padding(
                        padding: const EdgeInsets.fromLTRB(10, 20, 10, 5),
                        child: Container(
                                        width: 500,
                                        height: 40,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(5),
                                            border: Border.all(color: Colors.grey)),
                                        child: TextFormField(
                                          focusNode: _firstTextFieldFocus,
                                          style: TextStyle(fontSize: 16),
                                          controller: _searchController,
                                          decoration: InputDecoration(
                                            
                                            hintText: 'Pick up location .....',
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
        GestureDetector(
          onTap: (){
            Get.to(LocationMap(
              centerPoint: LatLng(widget.latValue != 0.0 ? widget.latValue : 28.2096,
              widget.longValue != 0.0 ? widget.longValue:83.9856),
              callback: widget.callback,
            ));
          },
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10,10,10,10),
            child: Row(
              children: [
                Icon(Icons.location_on_rounded,color: Colours.primarygreen,size: 30,),
                Text("  Choose on map",
                style: TextStyle(fontSize: 16,color: Colours.primarygreen),),
              ],
            ),
          ),
        ),
        // GestureDetector(
        //   onTap: (){
        //     Get.back();
        //     // Get.to(LocationMap(
        //     //   centerPoint: LatLng(28.2096,83.9856),
        //     //   callback: widget.callback,
        //     // ));
        //   },
        //   child: Padding(
        //     padding: const EdgeInsets.fromLTRB(10,10,10,10),
        //     child: Row(
        //       children: [
        //         Icon(Icons.pin_drop,color: Colors.blue,size: 30,),
        //         Text("  Choose your current location",
        //         style: TextStyle(fontSize: 16,color: Colors.blue),),
        //       ],
        //     ),
        //   ),
        // ),
        ListView.builder(
      shrinkWrap: true,
      itemCount: _suggestions.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(0,0,0,0),
          child: Column(
            children: [
              ListTile(
                tileColor: Colors.white,
                title: Text(_suggestions[index].description.toString()),
                
                onTap: () {
                  _searchController.text = _suggestions[index].description.toString();
                  _onSearchButtonPressed(_searchController.text);
                },
              ),
              Divider(
                height: 1,
                color: Colors.black,
              )
            ],
          ),
        );
      },
    )
        ],
      ),
    );
  }
}