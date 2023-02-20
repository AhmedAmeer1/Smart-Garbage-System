import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:timeago/timeago.dart' as timeago;

class Database {
  late FirebaseFirestore firestore;
  initiliase() {
    firestore = FirebaseFirestore.instance;
  }

  Future<void> createRoute(String routeName) async {
    try {
      await firestore.collection("Routes").add({
        'routeName': routeName,
        'routeAssign': 'no',
        'driver': 'No Driver',
        'municipalCouncil': "rajagiriya",
        'total_quantity': 0,
        "destinationLat": "6.942428199999999",
        "destinationLng": "79.9045771",
        'timestamp': FieldValue.serverTimestamp()
      });
      print("debug : New Bin Added");
    } catch (e) {
      print(e);
    }
  }

  Future<List> AdminReadRouteDetails() async {
    QuerySnapshot querySnapshot;
    List docs = [];
    try {
      querySnapshot = await firestore
          .collection('Routes')
          .orderBy('timestamp', descending: true)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        for (var doc in querySnapshot.docs.toList()) {
          {
            Map a = {
              "id": doc.id,
              "routeName": doc['routeName'],
              "municipalCouncil": doc['municipalCouncil'],
              "total_quantity": doc['total_quantity'],
            };
            print(a);
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

  Future<List> readRouteDetails() async {
    print("1111111111111111111111111111");

    QuerySnapshot querySnapshot;
    List docs = [];
    try {
      querySnapshot = await firestore
          .collection('Routes')
          .orderBy('timestamp', descending: true)
          .get();
      print("2222222222222222222222");
      if (querySnapshot.docs.isNotEmpty) {
        print("2333333333333333333333333");
        for (var doc in querySnapshot.docs.toList()) {
          {
            print("4444444444");


            if (doc['routeAssign'] == 'no') {
              print("5555555555555555");
              Map a = {
                "id": doc.id,
                "routeName": doc['routeName'],
                "municipalCouncil": doc['municipalCouncil'],
                "total_quantity": doc['total_quantity'],
                "destinationLat": doc['destinationLat'],
                "destinationLng": doc['destinationLng'],
              };
              print("6666666666666");
              print(a);
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

  Future<List> readRouteDetailsByDriver(String id, String routeAssign ) async {
    if (routeAssign == "no") {
      await firestore
          .collection("Routes")
          .doc(id)
          .update({'routeAssign': routeAssign,'driver':"no driver"});
    }

    QuerySnapshot querySnapshot;
    List docs = [];
    try {
      querySnapshot = await firestore
          .collection('Routes')
          .orderBy('timestamp', descending: true)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        for (var doc in querySnapshot.docs.toList()) {
          {
            DateTime date = doc['timestamp'].toDate();
            final timesAgo = date.subtract(new Duration(minutes: 1));

            if (doc['routeAssign'] == 'AssigntoDriver'  || (doc['routeAssign'] == 'pickedUpByDriver'))  {
              Map a = {
                "id": doc.id,
                "routeName": doc['routeName'],
                "municipalCouncil": doc['municipalCouncil'],
                "total_quantity": doc['total_quantity'],
                "destinationLat": doc['destinationLat'],
                "destinationLng": doc['destinationLng'],
                "routeAssign": doc['routeAssign'],
              };

              print(a);
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

  Future<bool> UpdateRouteAssign(String routeId, String routeAssign,String email) async {
    QuerySnapshot querySnapshot;
    print("11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111");
    print("wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww");
    print(email);
    print("11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111");
    try {
      await firestore
          .collection("Routes")
          .doc(routeId)
          .update({'routeAssign': routeAssign,'driver':email});
    } catch (e) {
      print(e);
    }
    return true;
  }

  //view user details
  Future<List> DriverViewRoute(String RouteName) async {
    print(RouteName);
    QuerySnapshot querySnapshot;
    List docs = [];
    try {
      querySnapshot = await firestore.collection('Routes').get();

      if (querySnapshot.docs.isNotEmpty) {
        for (var doc in querySnapshot.docs.toList()) {
          {
            if (doc['routeName'] == RouteName) {
              Map a = {
                "id": doc.id,
                "destinationLat": doc['destinationLat'],
                "destinationLng": doc["destinationLng"],
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

  Future<int> calculateTotalQuantityOfBin() async {
    QuerySnapshot querySnapshot;
    int quantity = 0;

    try {
      querySnapshot = await firestore
          .collection('Bin')
          .orderBy('timestamp', descending: true)
          .get();
      //String searchQuery = "";

      if (querySnapshot.docs.isNotEmpty) {
        for (var doc in querySnapshot.docs.toList()) {
          {
            quantity = quantity + int.parse(doc['quantity']);
          }
        }

        return quantity;
      }
    } catch (e) {
      print(e);
    }
    return quantity;
  }




  //------------------------- DRIVER PART-----------------------------------

  Future<List>  isRoutePicked(String email) async {
    List docs = [];
    print(email);
    QuerySnapshot querySnapshot;
    String isDriverAvailable = "no";

    print("isRouteAssign inside ");
    try {

      querySnapshot = await firestore.collection('Routes').get();
      if (querySnapshot.docs.isNotEmpty) {
        for (var doc in querySnapshot.docs.toList()) {
          {
            if (doc["driver"] == email) {

              Map a = {
                "id": doc.id,
                "routeName": doc['routeName'],
                "municipalCouncil": doc['municipalCouncil'],
                "total_quantity": doc['total_quantity'],
                "destinationLat": doc['destinationLat'],
                "destinationLng": doc['destinationLng'],
                "driver": doc['driver'],


              };

              print(a);
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














} //last  bracket
