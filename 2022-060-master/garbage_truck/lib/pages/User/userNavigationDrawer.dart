import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:garbage_truck/pages/User/userProfile.dart';
import 'package:garbage_truck/pages/User/viewTruck.dart';
import '../../api/user_model.dart';
import '../../api/userApi.dart';
import '../../main.dart';

import '../commonHome.dart';
import '../map.dart';
import '../signIn.dart';
import 'Complaint/addComplaint.dart';
import 'ahaash.dart';


class  UserNavigationDrawerWidget extends StatefulWidget {

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  _UserNavigationDrawerWidgetState createState() => _UserNavigationDrawerWidgetState();
}



// class NavigationDrawerWidget extends StatelessWidget {

  class _UserNavigationDrawerWidgetState extends State<UserNavigationDrawerWidget> {

  final padding = EdgeInsets.symmetric(horizontal: 20);

  set loggedInUser(UserModel loggedInUser) {}
  @override
  Widget build(BuildContext context) {
    bool isSearching = false;
    late Database db;
    List docs = [];

    String? userEmail="";
    User? user = FirebaseAuth.instance.currentUser;

    UserModel loggedInUser = UserModel();


    initialise() {
      db = Database();
      db.initiliase();

      db.isRouteAssign("user1@gmail.com").then((value) => {
        setState(() {
          print("inside frontend-------");
          print( value[0]["isrouteAssign"]);

          // isRouteAssign = value[0]["isrouteAssign"];
          // destinationAddressController.text = value[0]["routeName"];
          // startAddressController.text = value[0]["municipalCouncil"];

          // print("inside frontend route : " + isRouteAssign);
        })
      });


      // db.read("").then((value) => {
      //   setState(() {
      //     docs = value;
      //   })
      // });
    }

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
        this.loggedInUser = UserModel.fromMap(value.data()

        );

        setState(() {
           userEmail=user?.email;
        });
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
                .push(MaterialPageRoute(builder: (context) => ViewTruck(email:user?.email ))),
            child: const ListTile(
              title: Text('View Truck'),
              leading: Icon(Icons.home),
            ),
          ),


          InkWell(
            onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => AddComplaint())),
            child: const ListTile(
              title: Text('Add Complaint'),
              leading: Icon(Icons.request_page),
            ),
          ),
          InkWell(
            onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => UserProfile(email: user?.email,))),
            child: const ListTile(
              title: Text('Profile'),
              leading: Icon(Icons.settings),
            ),
          ),
          InkWell(
            onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => MyHomePage11())),
            child: const ListTile(
              title: Text('Find waste collector'),
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
