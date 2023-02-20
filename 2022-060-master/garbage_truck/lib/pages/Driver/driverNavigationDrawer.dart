import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:garbage_truck/pages/Driver/viewFullRoute.dart';
import 'package:garbage_truck/pages/Driver/DriverMap.dart';
import 'package:garbage_truck/pages/User/viewTruck.dart';
import '../../api/user_model.dart';
import '../../api/userApi.dart';

import '../commonHome.dart';
import '../map.dart';
import '../signIn.dart';
import 'Routecheck.dart';
import 'currentLocation.dart';
import 'driverProfile.dart';



class  DriverNavigationDrawer extends StatefulWidget {

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  _DriverNavigationDrawerState createState() => _DriverNavigationDrawerState();
}





  class _DriverNavigationDrawerState extends State<DriverNavigationDrawer> {

  final padding = EdgeInsets.symmetric(horizontal: 20);

  set loggedInUser(UserModel loggedInUser) {}
  @override
  Widget build(BuildContext context) {
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



    return Drawer(
      child: ListView(
        children: [
          Center(
            //user Drawer Navigation bar
            child: UserAccountsDrawerHeader(
              accountName: Text(
                "",
                style:
                TextStyle(color: Theme.of(context).colorScheme.onPrimary),
              ),
              accountEmail: Text(
                user?.email ?? "user Email",
                style:
                TextStyle(color: Theme.of(context).colorScheme.onPrimary),
              ),
              currentAccountPicture: GestureDetector(
                child: const CircleAvatar(
                  backgroundImage: AssetImage("assets/images/profile.jpg",),
                  // backgroundImage: NetworkImage(userAvatarUrl),
                  backgroundColor: Colors.white,

                  // backgroundColor: Colors.grey,
                  // child: Image.asset('assets/images/eco.jpeg');
                ),
              ),
              decoration: const BoxDecoration(color: Colors.teal),
            ),
          ),
          InkWell(
            onTap: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => CommonHomePage(title: '',))),
            child: const ListTile(
              title: Text('Main Menu '),
              leading: Icon(Icons.home),
            ),
          ),
          InkWell(
            onTap: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => DriverViewRoute(id: "",routeAssign: "",email: user?.email,))),
            child: const ListTile(
              title: Text('Route'),
              leading: Icon(Icons.home),
            ),
          ),

          // InkWell(
          //   onTap: () => Navigator.of(context)
          //       .push(MaterialPageRoute(builder: (context) => CurrentLocation())),
          //   child: const ListTile(
          //     title: Text('current location '),
          //     leading: Icon(Icons.home),
          //   ),
          // ),
          // InkWell(
          //   onTap: () => Navigator.of(context)
          //       .push(MaterialPageRoute(builder: (context) => WorkingMap(sourceLat:6.900490 ,sourceLng:79.905610 ,destinationLat:6.894860 ,destinationLng:79.919090 ,))),
          //   child: const ListTile(
          //     title: Text('WorkingMap '),
          //     leading: Icon(Icons.home),
          //   ),
          // ),
          InkWell(
            onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => DriverProfile(email: user?.email,))),
            child: const ListTile(
              title: Text('Profile'),
              leading: Icon(Icons.settings),
            ),
          ),
          InkWell(
            onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => RouteCheck(email: user?.email,))),
            child: const ListTile(
              title: Text('route check'),
              leading: Icon(Icons.settings),
            ),
          ),


          InkWell(
            onTap: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => SignIn())),
            child: const ListTile(
              title: Text('Logout'),
              leading: Icon(Icons.logout),
            ),
          ),
        ],
      ),
    );
  }



}
