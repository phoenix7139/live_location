import 'package:flutter/material.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: FireMap(),
      ),
    );
  }
}

class FireMap extends StatefulWidget {
  @override
  _FireMapState createState() => _FireMapState();
}

class _FireMapState extends State<FireMap> {
  GoogleMapController mapController;
  var currentLocation = LocationData;
  var location = new Location();
  var lat, long, accuracy;

  @override
  void initState() {
    super.initState();
    //LocationAccuracy.HIGH;
    location.onLocationChanged().listen((LocationData currentLocation) {
      setState(() {
        lat = currentLocation.latitude;
        long = currentLocation.longitude;
        accuracy = currentLocation.accuracy;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        GoogleMap(
          myLocationButtonEnabled: true,
          initialCameraPosition: CameraPosition(
            target: LatLng(23.554079, 87.278687),
            zoom: 13,
          ),
          onMapCreated: _onMapCreated,
          myLocationEnabled: true,
          //mapType: MapType.hybrid,
          compassEnabled: true,
        ),
        Positioned(
          bottom: 20,
          left: 20,
          right: 20,
          top: 480,
          child: Container(
            margin: EdgeInsets.all(20),
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(13),
            ),
            child: Column(
              children: <Widget>[Text("LATITUDE: $lat"), Text("LONGITUDE: $long"), Text("ACCURACY: $accuracy")],
            ),
          ),
        ),
      ],
    );
  }

  _onMapCreated(GoogleMapController controller) {
    setState(() {
      mapController = controller;
    });
  }
}
