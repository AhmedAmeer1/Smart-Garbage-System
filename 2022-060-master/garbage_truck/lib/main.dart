import 'dart:collection';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:garbage_truck/pages/signIn.dart';
import 'package:garbage_truck/secrets.dart'; // Stores the Google Maps API Key
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'dart:math' show cos, sqrt, asin;

import './pages/homePage.dart';
void main()  async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',

      debugShowCheckedModeBanner: false,

      theme: ThemeData(

          primarySwatch: Colors.green,

          accentColor: Colors.green,

          primaryColor: Colors.green,

          focusColor: Colors.green,

          cursorColor: Colors.green),


      home: SignIn(),
    );
  }
}
