import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



import '../../../api/routeApi.dart';
import '../../maps/calculateRoute.dart';
import '../adminNavigationDrawer.dart';
import 'addRoute.dart';




// import '../../api/complaintApi.dart';

class ViewRoute extends StatefulWidget {

  @override
  _ViewRouteState createState() => _ViewRouteState();
}

class _ViewRouteState extends State<ViewRoute> {
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
        title: const Text('Available Route '),
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


                            ],
                          ));
                    }),
              ),

            )
          ],

        ),

      ),
      floatingActionButton: FloatingActionButton(

        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddRoute()));

        },


        // onPressed: void AddVehicle(),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
