import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:garbage_truck/pages/Admin/sendSMS.dart';

import '../../api/user_model.dart';
import '../../api/userApi.dart';
import '../commonHome.dart';
import '../map.dart';

import '../maps/testmapcalculated.dart';
import '../signIn.dart';
import 'Bin/viewBin.dart';
import 'Complaint/detailComplaint.dart';
import 'Complaint/viewComplaint.dart';

import 'Notice/viewRouteNotice.dart';
import 'Routes/ViewRoutesByBin.dart';
import 'Routes/viewRoute.dart';


class  NavigationDrawerWidget extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  _NavigationDrawerWidgetState createState() => _NavigationDrawerWidgetState();
}



// class NavigationDrawerWidget extends StatelessWidget {

  class _NavigationDrawerWidgetState extends State<NavigationDrawerWidget> {

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
                .push(MaterialPageRoute(builder: (context) => AdminViewRoute())),
            child: const ListTile(
              title: Text('Home'),
              leading: Icon(Icons.home),
            ),
          ),

          InkWell(
            onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const ViewBin())),
            child: const ListTile(
              title: Text('Bin'),
              leading: Icon(Icons.business_center_rounded),
            ),
          ),

          InkWell(
            onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => ViewRoute())),
            child: const ListTile(
              title: Text('Routes'),
              leading: Icon(Icons.add_road),
            ),
          ),

          InkWell(
            onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => ViewComplaint())),
            child: const ListTile(
              title: Text('Complaint'),
              leading: Icon(Icons.comment),
            ),
          ),


          InkWell(
            onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => ViewRouteToNotice())),
            child: const ListTile(
              title: Text('Notice'),
              leading: Icon(Icons.notifications_active),
            ),
          ),


          // InkWell(
          //   onTap: () => Navigator.of(context).push(
          //       MaterialPageRoute(builder: (context) => TestMap(startAddress: "matale",endAddress: "colombo",))),
          //   child: const ListTile(
          //     title: Text('TestMap'),
          //     leading: Icon(Icons.notifications_active),
          //   ),
          // ),




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
