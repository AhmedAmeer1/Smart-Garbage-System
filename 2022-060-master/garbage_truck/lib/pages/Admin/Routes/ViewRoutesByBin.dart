import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../api/routeApi.dart';
import '../../maps/calculateRoute.dart';
import '../Bin/viewBinByRoute.dart';
import '../adminNavigationDrawer.dart';
import '../sendSMS.dart';

// import '../../api/complaintApi.dart';

class AdminViewRoute extends StatefulWidget {
  @override
  _AdminViewRouteState createState() => _AdminViewRouteState();
}

class _AdminViewRouteState extends State<AdminViewRoute> {
  late Database db;
  List docs = [];
  int quantity = 0;

  double paddingLeft = 0;

  initialise() {
    db = Database();
    db.initiliase();
    db.readRouteDetails().then((value) => {
          setState(() {
            docs = value;
          })
        });

    // db.calculateTotalQuantityOfBin().then((value) => {
    //   setState(() {
    //     quantity = value;
    //   })
    // });
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
              child: ListView.builder(
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
                                  bottom:
                                      BorderSide(width: 2, color: Colors.grey),
                                ),
                                onTap: () {},
                                leading: Text(
                                  docs[index]['routeName'],



                                  style: TextStyle(
                                      fontSize: 18,
                                      color:
                                          CupertinoColors.darkBackgroundGray),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: 10, right: 120, bottom: 20),
                              child: Text(
                                  "Total Bin Filled  : " +
                                      docs[index]['total_quantity'].toString() +
                                      "%",
                                  style: TextStyle(
                                      color: Colors.black.withOpacity(0.6))),
                            ),
                            ButtonBar(
                              alignment: MainAxisAlignment.start,
                              children: [
                                docs[index]['total_quantity'] >= 50
                                    ? Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
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
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          SendSMS(
                                                              routeId:
                                                                  docs[index]
                                                                      ['id'],
                                                              routeName: docs[
                                                                      index][
                                                                  'routeName'],destinationLat:docs[
                                                          index][
                                                          'destinationLat'] ,destinationLng:docs[
                                                          index][
                                                          'destinationLng'])));
                                            },
                                            child: Text("Assign Route"),
                                            // color: Colors.green.shade700,
                                            textColor: Colors.green
                                            // color: Colors.green.shade700,
                                            ),
                                      )
                                    : Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                      ),
                                docs[index]['total_quantity'] >= 50
                                    ? Padding(
                                        padding:
                                            const EdgeInsets.only(left: 90),
                                        child: FlatButton(
                                          shape: RoundedRectangleBorder(
                                              side: BorderSide(
                                                  color: Colors.green.shade700,
                                                  width: 1,
                                                  style: BorderStyle.solid),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          onPressed: () {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ViewBinByRouteName(
                                                            routeName: docs[
                                                                    index][
                                                                'routeName'])));
                                          },
                                          child: Text("View Bins"),
                                          // color: Colors.green.shade700,
                                          //   textColor: Colors.green,
                                          // color: Colors.green.shade700,
                                        ),
                                      )
                                    : Padding(
                                        padding:
                                            const EdgeInsets.only(left: 215),
                                        child: FlatButton(
                                          shape: RoundedRectangleBorder(
                                              side: BorderSide(
                                                  color: Colors.green.shade700,
                                                  width: 1,
                                                  style: BorderStyle.solid),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          onPressed: () {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ViewBinByRouteName(
                                                            routeName: docs[
                                                                    index][
                                                                'routeName'])));
                                          },
                                          child: Text("View Bins"),
                                          // color: Colors.green.shade700,
                                          //   textColor: Colors.green,
                                          // color: Colors.green.shade700,
                                        ),
                                      )
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
