import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:timeago/timeago.dart' as timeago;

class Database {
  late FirebaseFirestore firestore;
  initiliase() {
    firestore = FirebaseFirestore.instance;
  }



  Future<void> createGarbageBin(String name) async {
    try {
      await firestore.collection("GarbageBin").add({
        'place': name,

        'timestamp': FieldValue.serverTimestamp()
      });


    } catch (e) {
      print(e);
    }
  }


  Future<void> delete(String id) async {
    try {
      await firestore.collection("Request Flower").doc(id).delete();
    } catch (e) {
      print(e);
    }
  }

//view method
  Future<List> readFilledBins() async{
    QuerySnapshot querySnapshot;
    List docs = [];
    try {
      querySnapshot = await firestore
          .collection('GarbageBin')
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
              "place": doc['place'],

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


  Future<void> updateRequest(String id, String name, String description) async {
    try {
      await firestore
          .collection("Request Flower")
          .doc(id)
          .update({'FlowerName': name, 'description': description});
    } catch (e) {
      print(e);
    }
  }


  Future<List> readUserRequestDetails(String email) async{
    QuerySnapshot querySnapshot;
    List docs = [];
    try {
      querySnapshot = await firestore
          .collection('Request Flower')
          .orderBy('timestamp', descending: true)
          .get();
      //String searchQuery = "";

      if (querySnapshot.docs.isNotEmpty) {
        for (var doc in querySnapshot.docs.toList()) {
          {
            DateTime date = doc['timestamp'].toDate();
            final timesAgo = date.subtract(new Duration(minutes: 1));

            if(email==doc['email']){

              Map a = {
                "id":doc.id,
                "FlowerName": doc['FlowerName'],
                "description": doc["description"],
                "email": doc["email"],
                "cDate": timeago.format(timesAgo)
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












}
