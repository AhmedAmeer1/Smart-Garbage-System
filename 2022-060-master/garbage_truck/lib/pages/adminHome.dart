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

import '../api/complaintApi.dart';
import '../api/user_model.dart';
import 'Complaint/addComplaint.dart';
import 'Complaint/viewComplaint.dart';
import 'GarbageBins/addPlaces.dart';
import 'GarbageBins/filledBins.dart';
import 'homePage.dart';
import 'maps/calculateRoute.dart';

class AdminHome extends StatefulWidget {


  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  _AdminHomeState createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
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

  UserModel loggedInUser =UserModel();
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
      this.loggedInUser =UserModel.fromMap(value.data());
      setState(() {

      });

    } );
  }

  @override
  Widget build(BuildContext context) {




    return Scaffold(
      backgroundColor:Colors.white,
      key: widget.scaffoldKey,
      appBar:AppBar(
        foregroundColor: Colors.black,
        // title: Text('Flower App ',style: TextStyle(color: Colors.black),),
        title: const Text('Lilly Shades',style: TextStyle(fontSize: 18,color: Colors.black,fontWeight: FontWeight.bold)),
        actions: const [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
          ),
        ],
        backgroundColor: Colors.white,
      ),
      drawer:  Drawer(

        child:  ListView(
          children: [
            Center(
              //user Drawer Navigation bar
              child: UserAccountsDrawerHeader(

                accountName: Text(
                  "",
                  style: TextStyle(
                      color: Theme
                          .of(context)
                          .colorScheme
                          .onPrimary),
                ),
                accountEmail: Text(
                  user?.email ?? "user Email",
                  style: TextStyle(
                      color: Theme
                          .of(context)
                          .colorScheme
                          .onPrimary),
                ),
                currentAccountPicture: GestureDetector(
                  child: const CircleAvatar(
                    backgroundColor: Colors.grey,
                    child: Icon(Icons.person,color: Colors.white,),
                  ),
                ),
                decoration: const BoxDecoration(
                    color: Colors.green
                ),
              ),
            ),

            InkWell(
              onTap: ()=>Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>  MapView()
              )),
              child: const ListTile(
                title: Text('Add Route '),
                leading: Icon(Icons.home),
              ),
            ),

            InkWell(
              onTap: ()=>Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>  AddGarbagePlaces()
              )),
              child: const ListTile(
                title: Text('Add Bin place'),
                leading: Icon(Icons.settings),
              ),
            ),
            InkWell(
              onTap: ()=>Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>  FilledBinsDetails()
              )),
              child: const ListTile(
                title: Text('Filled Bins'),
                leading: Icon(Icons.settings),
              ),
            ),






            InkWell(

              onTap: ()=>Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>   CalculateRouteMap(start:'rajagiriya',destination:'colombo')
              )),
              child: const ListTile(
                title: Text('Calculate Route'),
                leading: Icon(Icons.request_page),
              ),
            ),



            InkWell(

              onTap: ()=>Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>   ViewComplaint()
              )),
              child: const ListTile(
                title: Text('View Complaint'),
                leading: Icon(Icons.request_page),
              ),
            ),
            InkWell(

              onTap: ()=>Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>   MyHomePage(title: '',)
              )),
              child: const ListTile(
                title: Text('User'),
                leading: Icon(Icons.request_page),
              ),
            ),







            InkWell(
              onTap: (){},
              // onTap: ()=>Navigator.of(context).push(MaterialPageRoute(
              //     builder: (context) =>  SignIn()
              // )),
              child: const ListTile(
                title: Text('Logout'),
                leading: Icon(Icons.logout),
              ),
            ),

          ],
        ),
      ),




      body: ListView(
          children:[

            const Padding(padding: EdgeInsets.all(20.0),
              child: Text('ADMIN HOME',style: TextStyle(fontSize: 16,fontWeight:FontWeight.w400),),
            ),
            Container(
              height: 720.0,
              // child: GridView.builder(
              //     itemCount: docs.length,
              //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              //         crossAxisCount: 2),
              //     itemBuilder: (BuildContext context, int index){
              //       // return Single_prod(
              //       //   prod_name:docs[index]['name'],
              //       //   prod_picture:docs[index]['imageURL'],
              //       //   prod_description:docs[index]['description'],
              //       //   prod_price:docs[index]['cDate'],
              //       // );
              //     }),
            ),
          ]
      ),
    );
  }
}

