import 'dart:ffi';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:./garbage_truck/secrets.dart'; // Stores the Google Maps API Key
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:garbage_truck/pages/Driver/viewFullRoute.dart';
import 'package:garbage_truck/pages/Driver/DriverMap.dart';
import 'package:garbage_truck/pages/User/userMap.dart';
import 'package:garbage_truck/pages/signIn.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../api/routeApi.dart';
import '../signUp.dart';

class RouteCheck extends StatefulWidget {
  final email;

  RouteCheck({
    this.email,
  });

  @override
  _RouteCheckState createState() => _RouteCheckState();
}

class _RouteCheckState extends State<RouteCheck> {
  CameraPosition _initialLocation = CameraPosition(target: LatLng(0.0, 0.0));
  late GoogleMapController mapController;

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  late Database db;

  String id = "";
  String routeName = "";
  String municipalCouncil = "";
  String driver = "";

  double destinationLat = 0.0;
  double destinationLng = 0.0;

  initialise() {
    db = Database();
    db.initiliase();

    db.initiliase();
    db.isRoutePicked(widget.email).then((value) => {
          setState(() {
            if (value.isNotEmpty) {
              municipalCouncil = value[0]["id"];
              routeName = value[0]["routeName"];
              destinationLat = value[0]["destinationLat"];
              destinationLng = value[0]["destinationLng"];
              id = value[0]["id"];
            } else {
              driver = "null";
            }
            print("inside destinationLng 111111111111111");
            print(destinationLat);
            print(driver);
            print("inside frontend 111111111111111");
            // print(municipalCouncil);

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

            body: driver == "null"
                ? Container(
                    child: DriverViewRoute(
                    id: "",
                    routeAssign: "",
                      email:widget.email ,
                  ))
                : Container(

                    // child:  Text(" EQUAL  pickedUpByDriver")
                    child: WorkingMap(
                    id: id,
                    sourceLat: 6.9076384,
                    sourceLng: 79.8949571,
                    destinationLat:destinationLat,
                    destinationLng: destinationLng,
                  )
            )
        )
    );

    // child: UserMap(
    //   destinationLat: destinationLat,
    //   destinationLng: destinationLng,
    // )
  }
}




