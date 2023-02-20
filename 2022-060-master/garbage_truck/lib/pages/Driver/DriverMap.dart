import 'dart:async';

import 'dart:async';
import 'dart:typed_data';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:garbage_truck/pages/Driver/viewFullRoute.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:location/location.dart';
import 'package:location/location.dart';

import 'package:flutter/services.dart';
import '../../api/routeApi.dart';
import '../../dialogs/custom_dialog_box.dart';

class WorkingMap extends StatefulWidget {
  @override
  final id;

  // final binLat;
  // final binLng;

  final sourceLat;
  final sourceLng;

  final destinationLat;
  final destinationLng;

  WorkingMap({
    this.id,
    this.sourceLat,
    this.sourceLng,
    this.destinationLat,
    this.destinationLng,
    // this.binLat,
    // this.binLng,
  });

  @override
  _WorkingMapState createState() => _WorkingMapState();
}

class _WorkingMapState extends State<WorkingMap> {
  late Database db;
  List docs = [];

  double destinationLat = 0.0;
  double destinationLng = 0.0;

  GoogleMapController? mapController; //contrller for Google map
  Set<Marker> markers = Set(); //markers for google map
  LatLng showLocation = LatLng(27.7089427, 85.3086209);

  final Completer<GoogleMapController> _controller = Completer();

  static LatLng sourceLocation = LatLng(0, 0);
  static LatLng destination = LatLng(0, 0);
  static LatLng borella = LatLng(6.9177852, 79.89129199999999);

  static LatLng prudentialShipping = LatLng(6.9107964, 79.8904033);
  static LatLng parakumburaVidyalaya = LatLng(6.913779, 79.89019979999999);

  List<LatLng> polylineCoordinates = [];

  BitmapDescriptor sourceIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor destinationIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor currentLocationIcon = BitmapDescriptor.defaultMarker;

  BitmapDescriptor prudentialShippingIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor parakumburaVidyalayaIcon = BitmapDescriptor.defaultMarker;

  LocationData? currentLocation;

  void getCurrentLocation() async {
    Location location = Location();

    location.getLocation().then(
      (location) {
        currentLocation = location;
      },
    );

    GoogleMapController googleMapController = await _controller.future;

    location.onLocationChanged.listen((newLoc) {
      currentLocation = newLoc;

      googleMapController.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
            zoom: 13.5,
            target: LatLng(
              newLoc.latitude!,
              newLoc.longitude!,
            )),
      ));

      setState(() {});
    });
  }

  Future<void> getPolyPoints() async {
    PolylinePoints polylinePoints = PolylinePoints();

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      "AIzaSyAudaowoQDYgmgu8b6hG2_XbQusBm3LLHY",
      PointLatLng(sourceLocation.latitude, sourceLocation.longitude),
      // PointLatLng(borella.latitude, borella.longitude),
      PointLatLng(destination.latitude, destination.longitude),
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

  void setCustomMarkerIcon() {
    BitmapDescriptor.fromAssetImage(
            ImageConfiguration.empty, "assets/images/bin.png")
        .then((icon) {
      currentLocationIcon = icon;
    });

    BitmapDescriptor.fromAssetImage(
            ImageConfiguration.empty, "assets/images/bin.png")
        .then((icon) {
      prudentialShippingIcon = icon;
    });

    BitmapDescriptor.fromAssetImage(
            ImageConfiguration.empty, "assets/images/bin.png")
        .then((icon) {
      parakumburaVidyalayaIcon = icon;
    });

    BitmapDescriptor.fromAssetImage(
            ImageConfiguration.empty, "assets/images/truck.png")
        .then((icon) {
      sourceIcon = icon;
    });

    BitmapDescriptor.fromAssetImage(
            ImageConfiguration.empty, "assets/images/bin.png")
        .then((icon) {
      destinationIcon = icon;
    });
  }

  void initState() {
    db = Database();
    db.initiliase();

    destination = LatLng(widget.destinationLat, widget.destinationLng);
    sourceLocation = LatLng(widget.sourceLat, widget.sourceLng);

    setCustomMarkerIcon();
    getCurrentLocation();
    getPolyPoints();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Google Mapin dsdFlutter"),
      //
      // ),
      body: Stack(children: <Widget>[
        GoogleMap(
          initialCameraPosition: CameraPosition(
            target: sourceLocation,
            // target: LatLng(currentLocation!.latitude!,currentLocation!.longitude!),
            zoom: 14.5,
          ),
          polylines: {
            Polyline(
              polylineId: PolylineId("route"),
              points: polylineCoordinates,
              color: Colors.blue,
              width: 6,
            ),
          },
          markers: {
            Marker(
              markerId: MarkerId("prudentialShipping"),
              icon: prudentialShippingIcon,
              position: prudentialShipping,
            ),
            Marker(
              markerId: MarkerId("parakumburaVidyalaya"),
              icon: parakumburaVidyalayaIcon,
              position: parakumburaVidyalaya,
            ),
            Marker(
              markerId: MarkerId("source"),
              icon: sourceIcon,
              position: sourceLocation,
            ),
            Marker(
              markerId: MarkerId("borella"),
              // icon:Icons.add,
              icon: currentLocationIcon,
              position: borella,
            ),
            Marker(
              markerId: MarkerId("destination"),
              icon: destinationIcon,
              position: destination,
            )
          },
          onMapCreated: (mapController) {
            _controller.complete(mapController);
          },
        ),
        Container(
          child: GestureDetector(
            onTap: () {
              // db.UpdateRouteAssign( widget.id,"pickedUpByDriver");

              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return const CustomDialogBox(
                      title: ("Route !"),
                      descriptions: "Route Finished",
                      text: "ok",
                    );
                  }).whenComplete(() => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DriverViewRoute(
                            id: widget.id,
                            routeAssign: "no",
                            email: "",
                          ))));
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 750.0),
              child: Container(
                height: 53,
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 30),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 4,
                          color: Colors.black12.withOpacity(.2),
                          offset: Offset(2, 2))
                    ],
                    borderRadius: BorderRadius.circular(0).copyWith(
                        bottomRight: Radius.circular(0),
                        topLeft: Radius.circular(0)),
                    gradient: LinearGradient(colors: [
                      Colors.green.shade200,
                      Colors.green.shade900
                    ])),
                child: Text('Finished Trip ',
                    style: TextStyle(
                        color: Colors.white.withOpacity(.8),
                        fontSize: 15,
                        fontWeight: FontWeight.bold)),
              ),
            ),
          ),
        )
      ]),
    );
  }
}
