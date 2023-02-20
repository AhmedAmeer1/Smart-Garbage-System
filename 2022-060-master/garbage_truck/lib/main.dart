import 'dart:collection';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:garbage_truck/pages/Admin/Bin/viewBin.dart';
import 'package:garbage_truck/pages/Admin/sendSMS.dart';
import 'package:garbage_truck/pages/Driver/viewFullRoute.dart';
import 'package:garbage_truck/pages/MenuList.dart';
import 'package:garbage_truck/pages/User/ahaash.dart';

import 'package:garbage_truck/pages/User/userHome.dart';
import 'package:garbage_truck/pages/commonHome.dart';
import 'package:garbage_truck/pages/signIn.dart';


import 'dart:math' show cos, sqrt, asin;

import 'package:garbage_truck/pages/signUp.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Garbage Truck',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.green,
          accentColor: Colors.green,
          primaryColor: Colors.green,
          focusColor: Colors.green,
          cursorColor: Colors.green),
      // home: DriverViewRoute(id: "",routeAssign: "",),
      //   home: CommonHomePage(title: '',),
      //   home:  MyHomePage(title: '',),
      // home:  MyHomePage11(),
      //   home:  SignUp(),
        // home:  CommonHomePage(title: '',),
        home:  ViewBin(),




    );
  }
}
