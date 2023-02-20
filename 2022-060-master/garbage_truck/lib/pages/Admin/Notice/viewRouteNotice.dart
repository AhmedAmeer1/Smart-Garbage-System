import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:garbage_truck/pages/Admin/Notice/sendNotice.dart';



import '../../../api/routeApi.dart';


import '../Bin/updateBin.dart';
import '../adminNavigationDrawer.dart';
import '../sendSMS.dart';





// import '../../api/complaintApi.dart';

class ViewRouteToNotice extends StatefulWidget {

  @override
  _ViewRouteToNoticeState createState() => _ViewRouteToNoticeState();
}

class _ViewRouteToNoticeState extends State<ViewRouteToNotice> {
  late Database db;
  List docs = [];

  initialise() {
    db = Database();
    db.initiliase();
    db.AdminReadRouteDetails().then((value) => {
      setState(() {
        docs = value;

      })
    });
  }

  @override
  void initState() {
    super.initState();
    initialise();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawerWidget(),
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        shadowColor: Colors.green,
        title: const Text('Notice '),
        actions: const [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
          ),
        ],
      ),

      body: Container(


        child: Stack(
          children: [

            Container(

              child: Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: ListView.builder(
                    itemCount: docs.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                          color: Colors.grey.shade200,
                          margin: EdgeInsets.all(10),
                          child: Column(
                            children: [
                              ListTile(
                                onTap: () {},
                                contentPadding:
                                EdgeInsets.only(right: 30, left: 36, top: 10),
                                title: Padding(
                                  padding: const EdgeInsets.only(bottom: 12.0),
                                  child: Text(
                                      docs[index]['routeName'],style: TextStyle(fontSize: 18,color: CupertinoColors.darkBackgroundGray),),
                                ),


                                // leading: Text('vehicle type'+docs[index]['vehicleNumber']),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: FlatButton(
                                      child: const Text('Send Notice',style: TextStyle(color: Colors.white),),
                                      color: Colors.green.shade700,
                                      textColor: Colors.white,
                                      onPressed: () {
                                        Navigator.of(context).push(MaterialPageRoute( builder: (context) =>  SendNotice(
                                            routeId: docs[index]['id'],
                                            routeName: docs[index]
                                            ['routeName'])
                                        ));
                                      },
                                    ),
                                  ),
                                ],
                              ),


                            ],
                          ));
                    }),
              ),

            )
          ],

        ),

      ),

    );
  }
}
