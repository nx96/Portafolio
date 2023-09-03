import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      title: 'Flutter Google Maps Demo',
      home: MapSample(),
    );
  }
}

class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();

}

class MapSampleState extends State<MapSample> {
  Completer<GoogleMapController> _controller = Completer();

  


  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(-3.255659, -79.959828),
    zoom: 0.0,
  );

  static final CameraPosition _kLake = CameraPosition(
      target: LatLng(-3.258906, -79.959493),
      zoom: 18.0);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("Mapa de un solo punto"),
      ),
      body: GoogleMap(
        trafficEnabled: false,
        mapType: MapType.normal,
        tiltGesturesEnabled: false,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToTheLake,
        label: Text('Go to Machala'),
        icon: Icon(Icons.map),
      ),
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}