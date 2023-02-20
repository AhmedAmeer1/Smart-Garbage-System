import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:timeago/timeago.dart' as timeago;

class Database {
  late FirebaseFirestore firestore;
  initiliase() {
    firestore = FirebaseFirestore.instance;
  }

  Future<void> createBin(
    String binName,
    String routeName,
    double binLang,
    double binLong,
  ) async {
    try {
      await firestore.collection("Bin").add({
        'binName': binName,
        'binLang': binLang,
        'binLong': binLong,
        'quantity': 0,
        'routeName': routeName,
        'timestamp': FieldValue.serverTimestamp()
      });
      print("debug : New Bin Added");
    } catch (e) {
      print(e);
    }
  }

  Future<List> readBinDetails() async {
    QuerySnapshot querySnapshot;
    List docs = [];

    int testTotal = 10;
    int quantity = 0;
    testTotal = testTotal + 50;

    try {
      querySnapshot = await firestore
          .collection('Bin')
          .orderBy('timestamp', descending: true)
          .get();
      //String searchQuery = "";

      if (querySnapshot.docs.isNotEmpty) {
        for (var doc in querySnapshot.docs.toList()) {
          {
            DateTime date = doc['timestamp'].toDate();
            final timesAgo = date.subtract(new Duration(minutes: 1));

            Map a = {
              "id": doc.id,
              "binName": doc['binName'],
              "quantity": doc['quantity'],
              "routeName": doc['routeName'],
              "cDate": timeago.format(timesAgo)
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

  Future<List> ViewBinByRouteName(String routeName) async {
    QuerySnapshot querySnapshot;
    List docs = [];

    try {
      querySnapshot = await firestore
          .collection('Bin')
          .orderBy('timestamp', descending: true)
          .get();
      //String searchQuery = "";

      if (querySnapshot.docs.isNotEmpty) {
        for (var doc in querySnapshot.docs.toList()) {
          {
            if (doc['routeName'] == routeName) {
              Map a = {
                "id": doc.id,
                "binName": doc['binName'],
                "quantity": doc['quantity'],
                "routeName": doc['routeName'],
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

// ------------------------------------------------------------------------------------------------------------------

  Future<void> updateBin(String id, String quantity, String routeName) async {
    try {
      QuerySnapshot binQuerySnapshot;
      QuerySnapshot routesQuerySnapshot;
      double? tot_bin_filled = 0;
      int? tot_bin = 0;
      int? binGreater50 = 0;
      String routeid = 'null';

      //retreiving route details
      routesQuerySnapshot = await firestore
          .collection('Routes')
          .orderBy('timestamp', descending: true)
          .get();

      if (routesQuerySnapshot.docs.isNotEmpty) {
        for (var doc in routesQuerySnapshot.docs.toList()) {
          {
            if (doc['routeName'] == routeName) {
              routeid = doc.id;
            }
          }
        }
      }

      await firestore.collection("Bin").doc(id).update({'quantity': quantity});

      binQuerySnapshot = await firestore
          .collection('Bin')
          .orderBy('timestamp', descending: true)
          .get();

      if (binQuerySnapshot.docs.isNotEmpty) {
        for (var doc in binQuerySnapshot.docs.toList()) {
          {
            if (doc['routeName'] == routeName) {
              tot_bin = (tot_bin! + 1)!;

              if (int.parse(doc['quantity']) > 50) {
                binGreater50 = (binGreater50! + 1)!;
              }
            }
          }
        }
      }

      if (tot_bin! % 2 != 0) {
        tot_bin = (tot_bin! + 1)!;
      }

      if (tot_bin / 2 <= binGreater50!) {
        print("can be collected ---------------------------------------");
      }

      tot_bin_filled = binGreater50 * (100 / tot_bin);

      // tot_bin_filled = tot_bin_filled*100;
      tot_bin_filled = double.parse((tot_bin_filled).toStringAsFixed(2));

      print(tot_bin_filled);

      await firestore
          .collection("Routes")
          .doc(routeid)
          .update({'total_quantity': tot_bin_filled});
    } catch (e) {
      print(e);
    }
  }

  // -----------------------------------------------------------------------------------------------

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
}

class Intger {} //last  bracket
