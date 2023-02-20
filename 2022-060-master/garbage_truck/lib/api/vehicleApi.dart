import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:timeago/timeago.dart' as timeago;

class Database {
  late FirebaseFirestore firestore;
  initiliase() {
    firestore = FirebaseFirestore.instance;
  }

  Future<void> createVehicle(
      String vehicleNumber, String name, String type) async {
    try {
      await firestore.collection("Vehicle").add({
        'vehicleNumber': vehicleNumber,
        'vehicleName': name,
        'vehicleType': type,
        'timestamp': FieldValue.serverTimestamp()
      });
      print("debug : New Vehicle Added");
    } catch (e) {
      print(e);
    }
  }



  Future<List> readVehicleDetails() async {
    QuerySnapshot querySnapshot;
    List docs = [];
    try {
      querySnapshot = await firestore
          .collection('Vehicle')
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
              "vehicleNumber": doc['vehicleNumber'],
              "vehicleName": doc['vehicleName'],
              "vehicleType": doc['vehicleType'],
              "cDate": timeago.format(timesAgo)
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








}//last  bracket
