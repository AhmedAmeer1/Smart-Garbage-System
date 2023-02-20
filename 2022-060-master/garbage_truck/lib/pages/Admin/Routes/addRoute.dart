import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:garbage_truck/pages/Admin/Routes/viewRoute.dart';


import '../../../api/routeApi.dart';
import '../../../dialogs/custom_dialog_box.dart';
import '../adminNavigationDrawer.dart';

class AddRoute extends StatefulWidget {
  @override
  _AddRoutepageState createState() => _AddRoutepageState();
}

class _AddRoutepageState extends State<AddRoute> {
  late Database db;

  final _formKey = GlobalKey<FormState>();
  TextEditingController _routeNameTextController = TextEditingController();
  TextEditingController _destinationTextController = TextEditingController();


  var routeNameFocus = FocusNode();
  var destinationFocus = FocusNode();

  initialise() {
    db = Database();
    db.initiliase();
  }

  @override
  void initState() {
    super.initState();
    initialise();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height / 3;

    bool isPasswordVisible = false;

    return SafeArea(
      child: Scaffold(
        drawer: NavigationDrawerWidget(),
        appBar: AppBar(
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,

          title: const Text(' '),
          actions: const [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
            ),
          ],
        ),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          alignment: Alignment.center,

          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 150,
                  width: 230,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                        Colors.green.shade200,
                        Colors.green.shade900
                      ]),
                      boxShadow: const [
                        BoxShadow(
                            blurRadius: 4,
                            spreadRadius: 3,
                            color: Colors.black12)
                      ],
                      borderRadius: BorderRadius.circular(200).copyWith(
                          bottomRight: Radius.circular(0),
                          topLeft: Radius.circular(0))),
                  child: Container(
                    margin: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [
                          Colors.green.shade200,
                          Colors.green.shade900
                        ]),
                        boxShadow: const [
                          BoxShadow(
                              blurRadius: 4,
                              spreadRadius: 3,
                              color: Colors.black12)
                        ],
                        borderRadius: BorderRadius.circular(200).copyWith(
                            bottomRight: Radius.circular(0),
                            topLeft: Radius.circular(0))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          'Add',
                          style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              shadows: [
                                Shadow(
                                    color: Colors.black45,
                                    offset: Offset(1, 1),
                                    blurRadius: 5)
                              ]),
                        ),
                        Text(
                          ' Route',
                          style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              shadows: [
                                Shadow(
                                    color: Colors.black45,
                                    offset: Offset(1, 1),
                                    blurRadius: 5)
                              ]),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(
                  height: 100,
                ),
                Padding(
                  padding:
                  EdgeInsets.symmetric(horizontal: 30).copyWith(bottom: 10),
                  child: TextField(
                    controller: _routeNameTextController,
                    focusNode: routeNameFocus,
                    style: TextStyle(color: Colors.grey, fontSize: 14.5),
                    decoration: InputDecoration(
                        prefixIconConstraints: BoxConstraints(minWidth: 45),
                        prefixIcon: Icon(
                          Icons.add_outlined,
                          color: Colors.grey,
                          size: 22,
                        ),
                        border: InputBorder.none,
                        hintText: 'Route Name',
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 12),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black))),
                  ),
                ),

                SizedBox(
                  height: 80,
                ),

                GestureDetector(
                  onTap: () {
                    if (_routeNameTextController.text.isEmpty) {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return const CustomDialogBox(
                              title: " Route Name !",
                              descriptions: "Hii Please Enter the Route Name",
                              text: "OK",
                            );
                          })
                          .whenComplete(() => FocusScope.of(context)
                          .requestFocus(routeNameFocus));
                    }  else {
                      db.createRoute(
                        _routeNameTextController.text,


                      );
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return const CustomDialogBox(
                              title: ("Route !"),
                              descriptions: "Route Added Successfully!",
                              text: "ok",
                            );
                          })
                          .whenComplete(() => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>  ViewRoute())));
                    }
                  },
                  child: Container(
                    height: 53,
                    width: double.infinity,
                    margin: EdgeInsets.symmetric(horizontal: 30),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 4,
                              color: Colors.black12.withOpacity(.2),
                              offset: Offset(2, 2))
                        ],
                        borderRadius:
                        BorderRadius.circular(0).copyWith(
                            bottomRight: Radius.circular(0),
                            topLeft: Radius.circular(0)),
                        gradient: LinearGradient(colors: [
                          Colors.green.shade200,
                          Colors.green.shade900
                        ])),
                    child: Text('Save',
                        style: TextStyle(
                            color: Colors.white.withOpacity(.8),
                            fontSize: 15,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
