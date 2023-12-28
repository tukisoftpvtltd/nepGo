import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  Completer<GoogleMapController> _mapControllerCompleter = Completer();
  bool _isMapReady = false;

  void _onMapCreated(GoogleMapController controller) {
    _mapControllerCompleter.complete(controller);
    setState(() {
      _isMapReady = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Google Map Example'),
      ),
      body: _isMapReady
          ? _buildMap()
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }

  Widget _buildMap() {
    return GoogleMap(
      onMapCreated: _onMapCreated,
      initialCameraPosition: CameraPosition(
        target: LatLng(37.7749, -122.4194),
        zoom: 12,
      ),
    );
  }
}

