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

class UserMap extends StatefulWidget {
  @override

  final destinationLat;
  final destinationLng;

  UserMap({

    this.destinationLat,
    this.destinationLng,

  });

  @override
  _UserMapState createState() => _UserMapState();
}

class _UserMapState extends State<UserMap> {
  late Database db;
  List docs = [];

  double destinationLat = 0.0;
  double destinationLng = 0.0;

  GoogleMapController? mapController; //contrller for Google map
  Set<Marker> markers = Set(); //markers for google map
  LatLng showLocation = LatLng(27.7089427, 85.3086209);

  final Completer<GoogleMapController> _controller = Completer();

  static LatLng sourceLocation = LatLng(6.9076384, 79.8949571);
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

    //munciple council
    // destination = LatLng(6.9076384,79.8949571);
    // destination = LatLng(widget.destinationLat,widget.destinationLng);
    destination = LatLng(widget.destinationLat, widget.destinationLng);


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
              icon:destinationIcon,
              position: destination,
            )
          },
          onMapCreated: (mapController) {
            _controller.complete(mapController);
          },
        ),
        Container(

        )
      ]),
    );
  }
}
