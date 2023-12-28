

// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:google_maps_webservice/places.dart' as places;

// class MapMap extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('Google Map with Search'),
//         ),
//         body: MapWithSearch(),
//       ),
//     );
//   }
// }

//   final String googleApiKey = 'YOUR_GOOGLE_MAPS_API_KEY';
// final places.GoogleMapsPlaces _places =
//     places.GoogleMapsPlaces(apiKey: "AIzaSyBV7ECMpja47Pu0shoRXUMUAPYY2CSX8n0");

// class MapWithSearch extends StatefulWidget {
//   @override
//   _MapWithSearchState createState() => _MapWithSearchState();
// }

// class _MapWithSearchState extends State<MapWithSearch> {
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   final TextEditingController _searchController = TextEditingController();
//   GoogleMapController? mapController;
//   LatLng _center = LatLng(37.4219999, -122.0840575); // Default center
//   Set<Marker> markers = {};
//   List<places.Prediction> _suggestions = [];

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Container(
//           height: 300,
//           child: GoogleMap(
//             onMapCreated: (controller) {
//               mapController = controller;
//             },
//             initialCameraPosition: CameraPosition(
//               target: _center,
//               zoom: 15,
//             ),
//             markers: markers,
//           ),
//         ),
//         Form(
//           key: _formKey,
//           child: TextFormField(
//             controller: _searchController,
//             decoration: InputDecoration(
//               hintText: 'Search...',
//               suffixIcon: IconButton(
//                 icon: Icon(Icons.search),
//                 onPressed: _search,
//               ),
//             ),
//             onChanged: _onTextChanged,
//           ),
//         ),
//         _buildSuggestionsList(),
//       ],
//     );
//   }

//   void _search() async {
//     final response = await _places.searchByText(_searchController.text);

//     if (response.isOkay) {
//       setState(() {
//         markers.clear();
//         for (final result in response.results) {
//           markers.add(
//             Marker(
//               markerId: MarkerId(result.placeId),
//               position: LatLng(
//                 result.geometry!.location.lat,
//                 result.geometry!.location.lng,
//               ),
//               infoWindow: InfoWindow(
//                 title: result.name,
//                 snippet: result.formattedAddress,
//               ),
//             ),
//           );
//         }
//       });

//       if (markers.isNotEmpty) {
//         mapController?.animateCamera(
//           CameraUpdate.newLatLng(markers.first.position),
//         );
//       }
//     }
//   }

//   void _onTextChanged(String value) async {
//     final response = await _places.autocomplete(value);

//     if (response.isOkay) {
//       setState(() {
//         _suggestions = response.predictions;
//       });
//     }
//   }

//   Widget _buildSuggestionsList() {
//     return Expanded(
//       child: ListView.builder(
//         itemCount: _suggestions.length,
//         itemBuilder: (context, index) {
//           return ListTile(
//             title: Text(_suggestions[index].description.toString()),
//             onTap: () {
//               _searchController.text = _suggestions[index].description.toString();
//               _search();
//             },
//           );
//         },
//       ),
//     );
//   }
// }
