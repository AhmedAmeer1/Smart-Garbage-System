import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
// import 'package:location/location.dart';


import 'package:flutter/material.dart';
import 'package:./garbage_truck/secrets.dart'; // Stores the Google Maps API Key
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
class TestMap extends StatefulWidget {
  @override
  final startAddress;
  final endAddress;

  TestMap({
    this.startAddress,
    this.endAddress,

  });

  _TestMapState createState() => _TestMapState();



}

class _TestMapState extends State<TestMap> {
  GoogleMapController? mapController; //contrller for Google map
  Set<Marker> markers = Set(); //markers for google map
  LatLng showLocation = LatLng(27.7089427, 85.3086209);
  //location to show in map

  final Completer<GoogleMapController> _controller = Completer();

  // static LatLng sourceLocation = LatLng(6.900490, 79.905610);
  // static LatLng destination = LatLng(6.894860, 79.919090);
  static LatLng borella = LatLng(6.913080, 79.880400);




  static LatLng sourceLocation = LatLng(0, 0);
  static LatLng destination = LatLng(0,0);
  List<LatLng> polylineCoordinates = [];

  late double startLatitude  ;
  late double startLongitude=0 ;
  late double destinationLatitude ;
  late double destinationLongitude ;


  BitmapDescriptor sourceIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor destinationIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor currentLocationIcon  = BitmapDescriptor.defaultMarker;



  Future<void> getPolyPoints() async {

    List<Location> startPlacemark = await locationFromAddress(widget.startAddress);
    List<Location> destinationPlacemark = await locationFromAddress(widget.endAddress);


     startLatitude = startPlacemark[0].latitude;
     startLongitude = startPlacemark[0].longitude;

     destinationLatitude = destinationPlacemark[0].latitude;
     destinationLongitude = destinationPlacemark[0].longitude;

     sourceLocation = LatLng(startLatitude, startLongitude);
destination = LatLng(destinationLatitude, destinationLongitude);
    PolylinePoints polylinePoints = PolylinePoints();

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      Secrets.API_KEY,
      PointLatLng(startLatitude, startLongitude),
      PointLatLng(destinationLatitude, destinationLongitude),
      // PointLatLng(destination.latitude, destination.longitude),

      // PointLatLng(currentLocation.latitude, currentLocation.longitude),

      // position: LatLng(currentLocation!.latitude!,
      //     currentLocation!.longitude!),


    );





    if (result.points.isNotEmpty) {
      result.points.forEach(
            (PointLatLng point) => polylineCoordinates.add(
          LatLng(point.latitude, point.longitude),
        ),
      );
      setState(() {});
    }
  }

  void setCustomMarkerIcon(){

    BitmapDescriptor.fromAssetImage(ImageConfiguration.empty, "assets/images/truck.png").then((icon){
      currentLocationIcon=icon;
    } );

    BitmapDescriptor.fromAssetImage(ImageConfiguration.empty, "assets/images/bins.png").then((icon){
      sourceIcon=icon;
    } );

    BitmapDescriptor.fromAssetImage(ImageConfiguration.empty, "assets/images/bins.png").then((icon){
      destinationIcon=icon;
    } );




  }


  void initState() {
    setCustomMarkerIcon();
    // getCurrentLocation();
    getPolyPoints();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Google Mapin dsdFlutter"),
          backgroundColor: Colors.deepPurpleAccent,
        ),
        body:

             GoogleMap(
          initialCameraPosition: CameraPosition(
            // target: sourceLocation,
            target: LatLng(startLatitude,startLongitude),
            zoom: 14.5,
          ),
          polylines: {
            Polyline(
              polylineId: PolylineId("route"),
              points: polylineCoordinates,
              color: Colors.cyan,
              width: 6,
            ),
          },
          markers: {
            // Marker(
            //   markerId: MarkerId("currentLocation"),
            //   // icon:currentLocationIcon,
            //   position: LatLng(currentLocation!.latitude!,
            //       currentLocation!.longitude!),
            // ),
            Marker(
              markerId: MarkerId("source"),
              // icon:currentLocationIcon,

              position: sourceLocation,
            ),
            // Marker(
            //   markerId: MarkerId("borella"),
            //   // icon:currentLocationIcon,
            //   position: borella,
            // ),
            Marker(
              markerId: MarkerId("destination"),
              // icon:destinationIcon,
              position: destination,
            )
          },
          onMapCreated: (mapController){
            _controller.complete(mapController);
          },
        ));
  }
}

