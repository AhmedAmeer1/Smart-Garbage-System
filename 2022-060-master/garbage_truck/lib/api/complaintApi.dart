import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:timeago/timeago.dart' as timeago;

class Database {
  late FirebaseFirestore firestore;
  initiliase() {
    firestore = FirebaseFirestore.instance;
  }



  Future<void> createComplaint(String name,String email, String description) async {
    try {
      await firestore.collection("Complaints").add({
        'LorryNumber': name,
        'email': email,
        'description': description,
        'timestamp': FieldValue.serverTimestamp()
      });
      print("debug : New Flower Added");

    } catch (e) {
      print(e);
    }
  }




//view method
  Future<List> readComplaintDetails() async{
    QuerySnapshot querySnapshot;
    List docs = [];
    try {
      querySnapshot = await firestore
          .collection('Complaints')
          .orderBy('timestamp', descending: true)
          .get();
      //String searchQuery = "";

      if (querySnapshot.docs.isNotEmpty) {
        for (var doc in querySnapshot.docs.toList()) {
          {
            DateTime date = doc['timestamp'].toDate();
            final timesAgo = date.subtract(new Duration(minutes: 1));





            Map a = {
              "id":doc.id,
              "LorryNumber": doc['LorryNumber'],
              "email": doc["email"],
              "description": doc["description"],
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
















}
