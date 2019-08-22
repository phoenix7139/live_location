import 'package:flutter/material.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:latlong/latlong.dart' as ll;

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

  var corlat = 23.547771;
  var corlong = 87.289857;

  var ovallat = 23.549896;
  var ovallong = 87.291763;

  var meter1, meter2;

  @override
  void initState() {
    super.initState();
    //LocationAccuracy.HIGH;
    {
      location.changeSettings(accuracy: LocationAccuracy.HIGH);
      location.onLocationChanged().listen((LocationData currentLocation) {
        setState(() {
          lat = currentLocation.latitude;
          long = currentLocation.longitude;
          ll.Distance distance = new ll.Distance();
          meter1 = distance(
              new ll.LatLng(lat, long), new ll.LatLng(corlat, corlong));
          meter2 = distance(
              new ll.LatLng(lat, long), new ll.LatLng(ovallat, ovallong));
          accuracy = currentLocation.accuracy;
          // print(lat);
          // print(long);
        });
      });
    }
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
              children: <Widget>[
                Text("LATITUDE: $lat"),
                Text("LONGITUDE: $long"),
                Text("ACCURACY: $accuracy")
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 140,
          left: 20,
          right: 20,
          top: 405,
          child: Container(
            margin: EdgeInsets.all(20),
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: meter1 < accuracy && meter1 < 30
                  ? Colors.green[400]
                  : Colors.red[400],
              borderRadius: BorderRadius.circular(13),
            ),
            child: Text("room: $meter1"),
          ),
        ),
        Positioned(
          bottom: 200,
          left: 20,
          right: 20,
          top: 345,
          child: Container(
            margin: EdgeInsets.all(20),
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: meter2 < accuracy && meter2 < 30
                  ? Colors.green[400]
                  : Colors.red[400],
              borderRadius: BorderRadius.circular(13),
            ),
            child: Text("ovals: $meter2"),
          ),
        )
      ],
    );
  }

  _onMapCreated(GoogleMapController controller) {
    setState(() {
      mapController = controller;
    });
  }
}
