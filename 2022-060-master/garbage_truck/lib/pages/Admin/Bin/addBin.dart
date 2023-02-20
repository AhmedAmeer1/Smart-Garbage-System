import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:garbage_truck/pages/Admin/Bin/viewBin.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import '../../../api/binApi.dart';
import '../../../dialogs/custom_dialog_box.dart';
import '../adminNavigationDrawer.dart';

class AddBin extends StatefulWidget {
  @override
  _AddBinpageState createState() => _AddBinpageState();
}

class _AddBinpageState extends State<AddBin> {
  late Database db;

  Position? _currentPosition;
  // String ? _currentAddress;
  String _currentAddress = " Current location loading ......";

  double _binLatitude = 0.0;
  double _binLongitude = 0.0;

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

  List<String> availableRoutes = ['Select Route Name'];
  String dropdownValue = 'Select Route Name';
  List docs = [];

  initialise() {
    db = Database();
    db.initiliase();
    _getCurrentLocation();

    // _locationTextController=_currentAddress as TextEditingController;

    db.ViewRouteName().then((value) => {
          setState(() {
            docs = value;
            for (int i = 0; i < docs.length; i++) {
              availableRoutes.add(docs[i]);
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
                  height: 40,
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 30).copyWith(bottom: 10),
                  child: TextField(
                    controller: _binNameTextController,
                    focusNode: binNameFocus,
                    style: TextStyle(color: Colors.grey, fontSize: 14.5),
                    decoration: const InputDecoration(
                        prefixIconConstraints: BoxConstraints(minWidth: 45),
                        prefixIcon: Icon(
                          Icons.add_outlined,
                          color: Colors.grey,
                          size: 22,
                        ),
                        border: InputBorder.none,
                        hintText: 'Bin Name',
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 12),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black))),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 30).copyWith(bottom: 10),
                  child: DropdownButtonFormField(
                    // controller: _numberTextController,
                    value: dropdownValue,

                    style: TextStyle(color: Colors.white, fontSize: 12),
                    decoration: const InputDecoration(
                        prefixIconConstraints: BoxConstraints(minWidth: 45),
                        border: InputBorder.none,
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 12),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black))),

                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownValue = newValue!;
                      });
                    },
                    items: availableRoutes
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14.5,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                GestureDetector(
                  onTap: () {
                    if (_binNameTextController.text.isEmpty) {
                      showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return const CustomDialogBox(
                                  title: "Quantity !",
                                  descriptions: "Hii Please Enter the Quantity",
                                  text: "OK",
                                );
                              })
                          .whenComplete(() => FocusScope.of(context)
                              .requestFocus(binNameFocus));
                    } else if (_binLatitude == 0.0) {
                      showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return const CustomDialogBox(
                                  title: "Location",
                                  descriptions:
                                      "Just wait for a while location is loading",
                                  text: "OK",
                                );
                              })
                          .whenComplete(() => FocusScope.of(context)
                              .requestFocus(binNameFocus));
                    } else {
                      db.createBin(_binNameTextController.text, dropdownValue,
                          _binLatitude, _binLongitude);
                      showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return const CustomDialogBox(
                                  title: ("Bin !"),
                                  descriptions: "Bin Added Successfully!",
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
                        borderRadius: BorderRadius.circular(0).copyWith(
                            bottomRight: Radius.circular(0),
                            topLeft: Radius.circular(0)),
                        gradient: LinearGradient(colors: [
                          Colors.green.shade200,
                          Colors.green.shade900
                        ])),
                    child: Text('Save',
                        style: TextStyle(
                            color: Colors.white.withOpacity(.8),
                            fontSize: 17,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
                Container(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Text(_currentAddress.toString(),
                        style: TextStyle(fontSize: 12)),
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

  _getCurrentLocation() {
    Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.best,
            forceAndroidLocationManager: true)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
        _getAddressFromLatLng();
      });
    }).catchError((e) {
      print(e);
    });
  }

  _getAddressFromLatLng() async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          _currentPosition!.latitude, _currentPosition!.longitude);

      Placemark place = placemarks[0];

      setState(() {
        _binLatitude = _currentPosition!.latitude;
        _binLongitude = _currentPosition!.longitude;
        _currentAddress =
            "${place.locality}, ${place.postalCode}, ${place.country}";
      });
    } catch (e) {
      print(e);
    }
  }
}
