import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:garbage_truck/api/user_model.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../dialogs/custom_dialog_box.dart';

class Database {
  late FirebaseFirestore firestore;
  final _auth = FirebaseAuth.instance;
  initiliase() {
    firestore = FirebaseFirestore.instance;
  }

  //login function
  Future<bool> signIn(String email, String password) async {
    bool loginSuccess = false;
    await _auth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((uid) => {
              loginSuccess = true,
            })
        .catchError((e) {
      loginSuccess = false;
    });
    return loginSuccess;
  }

  Future<bool> signUp(
      String number, String routeName, String email, String password) async {

    print("insideeeeeeeeeee");

    print(routeName);

    QuerySnapshot querySnapshot;

    // String routeName = "";

    querySnapshot = await firestore.collection('users').get();
    if (querySnapshot.docs.isNotEmpty) {
      for (var doc in querySnapshot.docs.toList()) {
        {
          if (doc["email"] == email) {
            return false;
          }
        }
      }
    }

    bool loginSuccess = false;
    await _auth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) => {
              createUser(number, routeName, password),
              loginSuccess = true,
            })
        .catchError((e) {
      loginSuccess = false;
    });
    return loginSuccess;
  }

  //creating a new user
  createUser(String number, String routeName, String password) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;
    UserModel userModel = UserModel();
    userModel.email = user!.email;
    userModel.uid = user.uid;




    userModel.phoneNumber = number.toString();
    userModel.routeName = routeName.toString();
    userModel.password = password.toString();

    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(userModel.toMap());
  }

//view user details
  Future<List> readUserDetails() async {
    QuerySnapshot querySnapshot;
    List docs = [];
    try {
      querySnapshot = await firestore.collection('users').get();
      //String searchQuery = "";
      if (querySnapshot.docs.isNotEmpty) {
        for (var doc in querySnapshot.docs.toList()) {
          {
            Map a = {
              "id": doc.id,
              "email": doc['email'],
              "firstName": doc["firstName"],
              "phoneNumber": doc["phoneNumber"],
            };
            docs.add(a);
          }
        }
        return docs;
      }
    } catch (e) {
      print(e);
    }

    return docs;
  }

  // update user details
  Future<void> update(String id, String firstName, String phoneNumber) async {
    try {
      await firestore
          .collection("users")
          .doc(id)
          .update({'firstName': firstName, 'phoneNumber': phoneNumber});
    } catch (e) {
      print(e);
    }
  }

  Future<void> delete(String id) async {
    try {
      await firestore.collection("users").doc(id).delete();
    } catch (e) {
      print(e);
    }
  }

  Future<bool> UpdateRouteAssign(String routeId, String routeAssign) async {
    QuerySnapshot querySnapshot;

    try {
      await firestore
          .collection("Routes")
          .doc(routeId)
          .update({'routeAssign': routeAssign});
    } catch (e) {
      print(e);
    }
    return true;
  }

  Future<List> ViewNumberByRouteName(String routeId, String routeName) async {
    QuerySnapshot querySnapshot;
    List people = [];
    try {
      await firestore
          .collection("Routes")
          .doc(routeId)
          .update({'routeAssign': 'AssigntoDriver'});

      querySnapshot = await firestore.collection('users').get();
      if (querySnapshot.docs.isNotEmpty) {
        for (var doc in querySnapshot.docs.toList()) {
          {
            if (doc['routeName'] == routeName) {
              people.add(doc['phoneNumber']);
            }
          }
        }
        return people;
      }
    } catch (e) {
      print(e);
    }
    return people;
  }

  Future<List> ViewRouteName() async {
    QuerySnapshot querySnapshot;
    List routesName = [];
    try {
      querySnapshot = await firestore.collection('Routes').get();
      if (querySnapshot.docs.isNotEmpty) {
        for (var doc in querySnapshot.docs.toList()) {
          {
            routesName.add(doc['routeName']);
          }
        }
        return routesName;
      }
    } catch (e) {
      print(e);
    }
    return routesName;
  }

  //view user details
  Future<List> ViewProileData(String email) async {

    QuerySnapshot querySnapshot;
    List docs = [];
    try {
      querySnapshot = await firestore.collection('users').get();
      //String searchQuery = "";
      if (querySnapshot.docs.isNotEmpty) {
        for (var doc in querySnapshot.docs.toList()) {
          {
            if (doc['email'] == email) {


              Map a = {
                "id": doc.id,
                "email": doc['email'],
                "password": doc["password"],
                "phoneNumber": doc["phoneNumber"],
                "routeName": doc["routeName"],

              };
              docs.add(a);
            }
          }
        }
        return docs;
      }
    } catch (e) {
      print(e);
    }

    return docs;
  }

  Future<bool> UpdateProileData(String id, String phoneNumber) async {
    print("inside-----------------");
    print(phoneNumber);
    print(id);
    await firestore
        .collection("users")
        .doc(id)
        .update({'phoneNumber': phoneNumber});

    return true;
  }

  Future<List> isRouteAssign(String email) async {

    print(email);
    QuerySnapshot querySnapshot;
    List RouteDetails = [];
    String routeName = "";
    String isrouteAssign = "";
    print("isRouteAssign inside ");
    try {
      //filtering the route Name based on the email
      querySnapshot = await firestore.collection('users').get();
      if (querySnapshot.docs.isNotEmpty) {
        for (var doc in querySnapshot.docs.toList()) {
          {
            if (doc["email"] == email) {
              routeName = doc['routeName'];
            }
          }
        }
      }



      querySnapshot = await firestore.collection('Routes').get();
      if (querySnapshot.docs.isNotEmpty) {
        for (var doc in querySnapshot.docs.toList()) {
          {
            if (doc["routeName"] == routeName) {
              print("isRouteAssign inside  22222222222222222");
              Map a = {



                "id": doc.id,
                "municipalCouncil": doc['municipalCouncil'],
                "routeName": doc["routeName"],
                "isrouteAssign": doc["routeAssign"],
                "destinationLat": doc['destinationLat'],
                "destinationLng": doc['destinationLng'],
              };
              RouteDetails.add(a);
            }
          }
        }
      }
    } catch (e) {
      print(e);
    }
    return RouteDetails;
  }
}
