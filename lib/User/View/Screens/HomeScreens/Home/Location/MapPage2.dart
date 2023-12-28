import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage2 extends StatefulWidget {
  @override
  _MapPage2State createState() => _MapPage2State();
}

class _MapPage2State extends State<MapPage2> {
  GoogleMapController? _mapController;

  @override
  void dispose() {
    _mapController?.dispose(); // Dispose of the map controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        _mapController?.dispose(); 
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Map Page'),
        ),
        body: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return GoogleMap(
              onMapCreated: (controller) {
                _mapController = controller;
              },
              initialCameraPosition: CameraPosition(
                target: LatLng( 28.2669, 83.9685), 
                zoom: 18,
              ),
              markers: _createMarkers(),
            );
          },
        ),
      ),
    );
  }

  Set<Marker> _createMarkers() {
    return {
      Marker(
        markerId: MarkerId('marker_1'),
        position: LatLng(37.7749, -122.4194), // Marker position
        infoWindow: InfoWindow(title: 'Marker 1'),
      ),
    };
  }
}
