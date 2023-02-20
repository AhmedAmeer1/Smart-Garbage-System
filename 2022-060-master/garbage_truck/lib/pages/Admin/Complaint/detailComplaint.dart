import 'dart:collection';
import 'dart:core';
import 'dart:ui';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:learn_flower/api/user_model.dart';
//
// import 'package:learn_flower/api/flowerApi.dart';
// import 'package:learn_flower/pages/Flower/flowersList.dart';
// import 'package:learn_flower/pages/Garden/gardens.dart';
// import 'package:learn_flower/pages/feedback/addfeedback.dart';
// import 'package:learn_flower/pages/FlowerRequest/requestFlower.dart';
//
//
// import 'package:carousel_pro/carousel_pro.dart';
//
//
// import '../FlowerRequest/userViewRequest.dart';
// import '../User/profile.dart';
// import '../User/signIn.dart';
// import 'detailFlower.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:garbage_truck/pages/map.dart';
import 'package:garbage_truck/pages/signIn.dart';
import 'package:garbage_truck/pages/signUp.dart';

import '../../../api/binApi.dart';
import '../../../api/user_model.dart';



class DetailComplaint extends StatefulWidget {


  final description;

  DetailComplaint({
    this.description,

  });
  @override
  _DetailComplaintState createState() => _DetailComplaintState();
}

class _DetailComplaintState extends State<DetailComplaint> {
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

      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,

        // title: Text('Flower App ',style: TextStyle(color: Colors.black),),
        title:  Text('Detail Complaint',
            style: TextStyle(
                fontSize: 18,
                color: Colors.black,
                fontWeight: FontWeight.bold)),
        actions: const [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
          ),
        ],
      ),
      body:
      Container(
        child: Column(
          children: [


            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Image.asset('assets/images/eco.jpeg'),
            ), // <-- SEE HERE

            Padding(
              padding: const EdgeInsets.only(top: 20.0,right: 25,left: 25),
              child: Text(
                widget.description,
                textAlign: TextAlign.center,style: TextStyle(height: 2),
              ),
            )
          ],
        ),
      ),





    );
  }
}
