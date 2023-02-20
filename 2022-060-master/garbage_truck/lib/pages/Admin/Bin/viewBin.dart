import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:garbage_truck/pages/Admin/Bin/updateBin.dart';
import '../../../api/binApi.dart';
import '../adminNavigationDrawer.dart';
import 'addBin.dart';



class ViewBin extends StatefulWidget {
  const ViewBin({Key? key}) : super(key: key);
  @override
  _ViewBinState createState() => _ViewBinState();
}

class _ViewBinState extends State<ViewBin> {
  late Database db;
  List docs = [];

  initialise() {
    db = Database();
    db.initiliase();
    db.readBinDetails().then((value) => {
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
        title: const Text('Available Bin '),
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
                                  top: 10, right: 150, bottom: 20),
                              child: Text(
                                  "Bin Name  : " +
                                      docs[index]['binName'].toString(),
                                  style: TextStyle(
                                      color: Colors.black.withOpacity(0.6))),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: 10, right: 120, bottom: 20),
                              child: Text(
                                  "Total Bin Filled  : " +
                                      docs[index]['quantity'].toString() +
                                      "%",
                                  style: TextStyle(
                                      color: Colors.black.withOpacity(0.6))),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: FlatButton(
                                    child: const Text(
                                      'Update',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    color: Colors.green.shade700,
                                    textColor: Colors.white,
                                    onPressed: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) => UpdateBin(
                                                  binId: docs[index]['id'],
                                                  routeName: docs[index]
                                                      ['routeName'],
                                                  quantity: docs[index]
                                                      ['quantity'])));
                                    },
                                  ),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddBin()));
        },

        // onPressed: void AddVehicle(),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
