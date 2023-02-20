import 'dart:collection';
import 'dart:core';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../api/binApi.dart';
import '../../api/user_model.dart';
import 'Admin/Routes/ViewRoutesByBin.dart';
import 'Driver/viewFullRoute.dart';
import 'User/userHome.dart';

class CommonHomePage extends StatefulWidget {
  CommonHomePage({required this.title});

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final String title;
  @override
  _CommonHomePageState createState() => _CommonHomePageState();
}

class _CommonHomePageState extends State<CommonHomePage> {
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
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        shadowColor: Colors.green,
        title: const Text("User Home"),
        actions: const [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
          ),
        ],
      ),
      drawer: Drawer(
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
                  .push(MaterialPageRoute(builder: (context) => AdminViewRoute())),
              child: const ListTile(
                title: Text('Admin'),
                leading: Icon(Icons.home),
              ),
            ),
            InkWell(
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => MyHomePage(
                        title: '',
                      ))),
              child: const ListTile(
                title: Text('User'),
                leading: Icon(Icons.request_page),
              ),
            ),
            InkWell(
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                      DriverViewRoute(id: "", routeAssign: "",email: user?.email,))),
              child: const ListTile(
                title: Text('Driver'),
                leading: Icon(Icons.request_page),
              ),
            ),
          ],
        ),
      ),
      body: Container(
    child: Column(
    children: [
    Padding(
    padding: const EdgeInsets.only(top: 80.0),
    child: Text(
    "Common file",
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
