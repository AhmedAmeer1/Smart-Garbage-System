import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../api/binApi.dart';

class ViewBinByRouteName extends StatefulWidget {
  final routeName;

  ViewBinByRouteName({
    this.routeName,
  });

  @override
  _ViewBinByRouteNameState createState() => _ViewBinByRouteNameState();
}

class _ViewBinByRouteNameState extends State<ViewBinByRouteName> {
  late Database db;
  List docs = [];

  initialise() {
    db = Database();
    db.initiliase();
    db.ViewBinByRouteName(widget.routeName).then((value) => {
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
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        title: Text(widget.routeName),
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
              child: ListView.builder(
                  itemCount: docs.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                        color: Colors.grey.shade200,
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
                                  docs[index]['binName'],
                                  style: const TextStyle(
                                      fontSize: 18,
                                      color:
                                          CupertinoColors.darkBackgroundGray),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 10, right: 180, bottom: 20),
                              child: Text(
                                  "quantity  : " +
                                      docs[index]['quantity'].toString() +
                                      "%",
                                  style: TextStyle(
                                      color: Colors.black.withOpacity(0.6))),
                            ),
                          ],
                        ));
                  }),
            )
          ],
        ),
      ),
    );
  }
}
