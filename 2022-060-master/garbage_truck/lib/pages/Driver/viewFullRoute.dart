import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:garbage_truck/pages/Driver/DriverMap.dart';

import '../../../api/routeApi.dart';
import 'driverNavigationDrawer.dart';
import 'map.dart';

// import '../../api/complaintApi.dart';

class DriverViewRoute extends StatefulWidget {
  final id;
  final routeAssign;
  final email;

  DriverViewRoute({
    this.id,
    this.routeAssign,
    this.email,
  });

  @override
  _DriverViewRouteState createState() => _DriverViewRouteState();
}

class _DriverViewRouteState extends State<DriverViewRoute> {
  late Database db;
  List docs = [];
  int quantity = 0;

  bool isDriverPicked = false;

  initialise() {
    db = Database();
    db.initiliase();
    db.readRouteDetailsByDriver(widget.id, widget.routeAssign).then((value) => {
          setState(() {
            docs = value;
            for (int i = 0; i < docs.length; i++) {
              if (docs[i]["routeAssign"] == "pickedUpByDriver") {
                isDriverPicked = true;
              }
            }
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
      drawer: DriverNavigationDrawer(),
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        shadowColor: Colors.green,
        title: const Text("Routes"),
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
            Container(
              child: docs.length == 0
                  ? Center(
                      child: Text(
                        "NO ROUTE AVAILABLE",
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                    )
                  : isDriverPicked == true
                      ? ListView.builder(
                          itemCount: docs.length,
                          itemBuilder: (BuildContext context, int index) {
                            return docs[index]['routeAssign'] ==
                                    "pickedUpByDriver"
                                ? Card(
                                    color: Colors.grey.shade200,
                                    shadowColor: Colors.black,
                                    clipBehavior: Clip.antiAlias,
                                    margin: EdgeInsets.all(20),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(20.0),
                                          child: ListTile(
                                            shape: const Border(
                                              bottom: BorderSide(
                                                  width: 2, color: Colors.grey),
                                            ),
                                            onTap: () {},
                                            leading: Text(
                                              docs[index]['routeName'],
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: CupertinoColors
                                                      .darkBackgroundGray),
                                            ),
                                          ),
                                        ),
                                        ButtonBar(
                                          alignment: MainAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 18),
                                              child: FlatButton(
                                                shape: RoundedRectangleBorder(
                                                    side: BorderSide(
                                                        color: Colors
                                                            .green.shade700,
                                                        width: 1,
                                                        style:
                                                            BorderStyle.solid),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                onPressed: () {
                                                  db.UpdateRouteAssign(
                                                      docs[index]['id'],
                                                      "pickedUpByDriver",
                                                      widget.email);

                                                  Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              WorkingMap(
                                                                id: docs[index]
                                                                    ['id'],
                                                                sourceLat:
                                                                    6.9076384,
                                                                sourceLng:
                                                                    79.8949571,
                                                                destinationLat:
                                                                    docs[index][
                                                                        'destinationLat'],
                                                                destinationLng:
                                                                    docs[index][
                                                                        'destinationLng'],
                                                              )));
                                                },
                                                child: Text("View Route"),
                                                // color: Colors.green.shade700,
                                                //   textColor: Colors.green,
                                                // color: Colors.green.shade700,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ))
                                : Card();
                          })
                      : ListView.builder(
                          itemCount: docs.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Card(
                                color: Colors.grey.shade200,
                                shadowColor: Colors.black,
                                clipBehavior: Clip.antiAlias,
                                margin: EdgeInsets.all(20),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: ListTile(
                                        shape: const Border(
                                          bottom: BorderSide(
                                              width: 2, color: Colors.grey),
                                        ),
                                        onTap: () {},
                                        leading: Text(
                                          docs[index]['routeName'],
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: CupertinoColors
                                                  .darkBackgroundGray),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: 10, right: 120, bottom: 20),
                                      child: Text(
                                          "Total Bin Filled  : " +
                                              docs[index]['total_quantity']
                                                  .toString() +
                                              "%",
                                          style: TextStyle(
                                              color: Colors.black
                                                  .withOpacity(0.6))),
                                    ),
                                    ButtonBar(
                                      alignment: MainAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 18),
                                          child: FlatButton(
                                            shape: RoundedRectangleBorder(
                                                side: BorderSide(
                                                    color:
                                                        Colors.green.shade700,
                                                    width: 1,
                                                    style: BorderStyle.solid),
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            onPressed: () {
                                              db.UpdateRouteAssign(
                                                  docs[index]['id'],
                                                  "pickedUpByDriver",
                                                  widget.email);

                                              Navigator.of(context)
                                                  .push(MaterialPageRoute(
                                                      builder:
                                                          (context) =>
                                                              WorkingMap(
                                                                id: docs[index]
                                                                    ['id'],
                                                                sourceLat:
                                                                    6.9076384,
                                                                sourceLng:
                                                                    79.8949571,
                                                                destinationLat:
                                                                    docs[index][
                                                                        'destinationLat'],
                                                                destinationLng:
                                                                    docs[index][
                                                                        'destinationLng'],
                                                              )));
                                            },
                                            child: Text("Pick Route"),
                                            // color: Colors.green.shade700,
                                            //   textColor: Colors.green,
                                            // color: Colors.green.shade700,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ));
                          }),
            ),
          ],
        ),
      ),
    );
  }
}
