

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:garbage_truck/pages/Admin/Bin/viewBin.dart';

import '../adminNavigationDrawer.dart';
import '../../../api/binApi.dart';
import '../../../dialogs/custom_dialog_box.dart';


class UpdateBin extends StatefulWidget {
  @override


  final binId;
  final routeName;
  final quantity;

  const UpdateBin({
    this.binId,
    this.routeName,
    this.quantity,

  });


  _UpdateBinpageState createState() => _UpdateBinpageState();
}

class _UpdateBinpageState extends State<UpdateBin> {
  late Database db;

  final _formKey = GlobalKey<FormState>();
  TextEditingController _binNameTextController = TextEditingController();
  TextEditingController _quantityTextController = TextEditingController();
  TextEditingController _routeIdTextController = TextEditingController();
  TextEditingController _locationTextController = TextEditingController();


  //NumberInputElement _quantityTextController = NumberInputElement();

  var binNameFocus = FocusNode();
  var quantityFocus = FocusNode();
  var routeIdFocus = FocusNode();
  var locationFocus = FocusNode();

  initialise() {



    db = Database();
    db.initiliase();
  }

  @override
  void initState() {
    _quantityTextController.text=widget.quantity.toString();
    _routeIdTextController.text=widget.routeName;
    _locationTextController.text=widget.binId;


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
                          'Update ',
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
                          ' Bin',
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
                  height: 50,
                ),

                Padding(
                  padding:
                  EdgeInsets.symmetric(horizontal: 30).copyWith(bottom: 10),
                  child: TextField(
                    controller: _quantityTextController,
                    focusNode: quantityFocus,
                    style: TextStyle(color: Colors.grey, fontSize: 14.5),
                    decoration: InputDecoration(
                        prefixIconConstraints: BoxConstraints(minWidth: 45),
                        prefixIcon: Icon(
                          Icons.confirmation_number_rounded,
                          color: Colors.grey,
                          size: 22,
                        ),
                        border: InputBorder.none,
                        hintText: 'Quantity',
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 12),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black))),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),

                GestureDetector(
                  onTap: () {
              if (_quantityTextController.text.isEmpty) {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return const CustomDialogBox(
                              title: "RouteID",
                              descriptions: "Hii Please Enter the RouteID ",
                              text: "OK",
                            );
                          })
                          .whenComplete(() => FocusScope.of(context)
                          .requestFocus(quantityFocus));
                    } else if (_routeIdTextController.text.isEmpty) {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return const CustomDialogBox(
                              title: "vehicle type !",
                              descriptions:
                              "Hii Please Enter the vehicle type ",
                              text: "OK",
                            );
                          })
                          .whenComplete(() => FocusScope.of(context)
                          .requestFocus(routeIdFocus));
                    } else if (_locationTextController.text.isEmpty) {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return const CustomDialogBox(
                              title: "Location !",
                              descriptions:
                              "Hii Please Enter the Location ",
                              text: "OK",
                            );
                          })
                          .whenComplete(() => FocusScope.of(context)
                          .requestFocus(locationFocus));
                    } else {
                      db.updateBin(
                        widget.binId,
                        _quantityTextController.text,
                        _routeIdTextController.text,


                      );
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return const CustomDialogBox(
                              title: ("Bin !"),
                              descriptions: "Bin updated Successfully!",
                              text: "ok",
                            );
                          })
                          .whenComplete(() => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ViewBin())));
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
