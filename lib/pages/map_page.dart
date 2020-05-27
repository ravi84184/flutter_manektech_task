import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatefulWidget {
  String latitude;
  String longitude;

  MapPage(this.latitude, this.longitude);

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  GoogleMapController controller;

  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  MarkerId selectedMarker;

  void _onMapCreated(GoogleMapController controller) {
    this.controller = controller;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: LatLng(double.parse(widget.latitude), double.parse(widget.latitude)),
          zoom: 11.0,
        ),
        markers: Set<Marker>.of(markers.values),
      ),
    );
  }
}
