import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import '../../../api/complaintApi.dart';
import './detailComplaint.dart';
import '../../maps/calculateRoute.dart';
import '../adminNavigationDrawer.dart';


// import '../../api/complaintApi.dart';

class ViewComplaint extends StatefulWidget {
  const ViewComplaint({Key? key}) : super(key: key);
  @override
  _ViewComplaintState createState() => _ViewComplaintState();
}

class _ViewComplaintState extends State<ViewComplaint> {
  late Database db;
  List docs = [];

  initialise() {
    db = Database();
    db.initiliase();
    db.readComplaintDetails().then((value) => {
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

        title: const Text('Complaints'),
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
                        margin: EdgeInsets.all(10),
                        child: Column(
                          children: [
                            ListTile(
                              onTap: () {},
                              contentPadding:
                              EdgeInsets.only(right: 30, left: 36, top: 10),
                              title: Text('Lorry Number :' +
                                  docs[index]['LorryNumber']),
                              subtitle: Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Text(docs[index]['email']),
                              ),
                              // leading: Text(docs[index]['email']),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: FlatButton(
                                    child: const Text(
                                      'View',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    color: Colors.green.shade700,
                                    textColor: Colors.white,
                                    onPressed: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  DetailComplaint(description:docs[index]['description'])
                                                     ));
                                    },
                                  ),
                                ),
                              ],
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
                        ));
                  }),
            )
          ],
        ),
      ),
    );
  }
}
