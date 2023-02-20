import 'dart:collection';
import 'dart:core';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:garbage_truck/pages/User/userNavigationDrawer.dart';

import 'package:garbage_truck/pages/map.dart';
import 'package:garbage_truck/pages/signIn.dart';
import 'package:garbage_truck/pages/signUp.dart';

import '../../api/binApi.dart';
import '../../api/user_model.dart';

import '../commonHome.dart';
import 'Complaint/addComplaint.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({required this.title});

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //search key

  bool isSearching = false;
  late Database db;
  List docs = [];
  initialise() {
    db = Database();
    db.initiliase();
    // db.read("").then((value) => {
    //   setState(() {
    //     docs = value;
    //   })
    // });
  }

  User? user = FirebaseAuth.instance.currentUser;

  UserModel loggedInUser = UserModel();
  // late var uid ;
  // static const  email ;
  @override
  void initState() {
    super.initState();
    initialise();

    FirebaseFirestore.instance
        .collection("users")
        .doc(user?.uid)
        .get()
        .then((value) {
      this.loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      key: widget.scaffoldKey,
      drawer: UserNavigationDrawerWidget(),
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        // title: Text('Flower App ',style: TextStyle(color: Colors.black),),
        title: const Text(""),
        actions: const [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
          ),
        ],
      ),
      body: Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 80.0),
              child: Text(
                "Welcome To",
                style: TextStyle(fontSize: 30),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Image.asset('assets/images/eco.jpeg'),
            ), // <-- SEE HERE

            Padding(
              padding: const EdgeInsets.only(top: 8.0,right: 25,left: 25),
              child: Text(
                "Eco-friendly products promote green living that help to conserve energy and also prevent air, water and noise pollution. They prove to be boon for the environment and also prevent human health from deterioration.",
                textAlign: TextAlign.center,style: TextStyle(height: 2),
              ),
            )
          ],
        ),
      ),
    );
  }
}
