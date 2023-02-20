import 'package:flutter/material.dart';

import '../../dialogs/custom_dialog_box.dart';
import '../homePage.dart';
import '../maps/calculateRoute.dart';
import '../../api/complaintApi.dart';

class ViewComplaint extends StatefulWidget {
  const ViewComplaint({Key? key}) : super(key: key);
  @override
  _ViewComplaintState createState() => _ViewComplaintState();
}
class _ViewComplaintState extends State<ViewComplaint> {

  late Database db;
  List docs =[];

  initialise(){
    db=Database();
    db.initiliase();
    db.readComplaintDetails().then((value) =>{
      setState((){
        docs=value;
      })
    } );
  }

  @override
  void initState() {
    super.initState();
    initialise();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        shadowColor: Colors.green,
        title: const Text('Received Complaints '),
        actions: const [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
          ),
        ],
      ),
      body: Container(
        // decoration: BoxDecoration(
        //     gradient: LinearGradient(
        //         colors: [Colors.green.shade200, Colors.green.shade900])),
        child: Stack(

          children: [
            // Image.asset(
            //   'assets/images/5.webp',
            //   fit: BoxFit.cover,
            //   height: double.infinity,
            //   width: double.infinity,
            // ),
            // Container(
            //   color: Colors.white.withOpacity(0.8),
            //   width: double.infinity,
            //   height: double.infinity,
            // ),
            Container(
              child: ListView.builder(
                  itemCount: docs.length,
                  itemBuilder: (BuildContext context, int index){
                    return Card(
                        color: Colors.green.shade200,
                        margin: EdgeInsets.all(10),
                        child :Column(
                          children: [
                            ListTile(
                              onTap: (){},
                              contentPadding: EdgeInsets.only(right:30,left:36,top:10),
                              title: Text('Lorry Number :'+docs[index]['LorryNumber']),
                              subtitle: Padding(
                                padding: const  EdgeInsets.only(top:10),
                                child: Text(docs[index]['description']),
                              ),
                              // leading: Text(docs[index]['email']),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: const <Widget>[
                                Padding(
                                  padding: EdgeInsets.all(8.0),

                                ),
                              ],
                            ),
                          ],
                        )
                    );
                  }
              ),
            )
          ],
        ),
      ),
    );
  }
}
