import 'dart:ffi';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:./garbage_truck/secrets.dart'; // Stores the Google Maps API Key
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:garbage_truck/pages/User/userMap.dart';
import 'package:garbage_truck/pages/signIn.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../api/userApi.dart';
import '../signUp.dart';

class ViewTruck extends StatefulWidget {
  final email;

  ViewTruck({
    this.email,
  });

  @override
  _ViewTruckState createState() => _ViewTruckState();
}

class _ViewTruckState extends State<ViewTruck> {
  CameraPosition _initialLocation = CameraPosition(target: LatLng(0.0, 0.0));
  late GoogleMapController mapController;

  final startAddressController = TextEditingController();
  final destinationAddressController = TextEditingController();

  final startAddressFocusNode = FocusNode();
  final desrinationAddressFocusNode = FocusNode();

  Set<Marker> markers = {};

  late PolylinePoints polylinePoints;
  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  late Database db;
  String isRouteAssign = "";
  double destinationLat = 0.0;
  double destinationLng = 0.0;



  initialise() {
    db = Database();
    db.initiliase();

    db.initiliase();
    db.isRouteAssign(widget.email).then((value) => {
          setState(() {
            isRouteAssign = value[0]["isrouteAssign"];
            destinationLat = value[0]["destinationLat"];
            destinationLng = value[0]["destinationLng"];

            // print("inside frontend route : " + isRouteAssign);
          })
        });
  }

  @override
  void initState() {
    super.initState();
    initialise();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            foregroundColor: Colors.black,
            backgroundColor: Colors.white,
            title: const Text('Truck Map '),
          ),
            body: isRouteAssign != "pickedUpByDriver"
                ? Container(
                child:
                Center(child: Text("NO TRUCK IS AVAILABLE ")))
                : Container(

                    // child:  Text(" EQUAL  pickedUpByDriver")
                    child: UserMap(
                    destinationLat: destinationLat,
                    destinationLng: destinationLng,
                  ))));
  }
}
