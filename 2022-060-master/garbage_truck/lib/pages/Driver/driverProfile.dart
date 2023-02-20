import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:garbage_truck/pages/User/userHome.dart';
import 'package:garbage_truck/pages/User/userNavigationDrawer.dart';

import 'package:garbage_truck/pages/signIn.dart';
import '../../api/userApi.dart';
import '../../dialogs/custom_dialog_box.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../signUp.dart';



class DriverProfile extends StatefulWidget {
  final email;

  DriverProfile({
    this.email
  });




  @override
  _DriverProfileState createState() => _DriverProfileState();
}

class _DriverProfileState extends State<DriverProfile> {
  late Database db;
  List docs = [];
  final _auth = FirebaseAuth.instance;

  List<String> availableRoutes = ['Select Route Name'];
  String dropdownValue = 'Select Route Name';

  initialise() {
    db = Database();
    db.initiliase();

    db.ViewProileData(widget.email).then((value) => {
      setState(() {
        docs = value;
        print(docs);
        _numberTextController.text=docs[0]["phoneNumber"] ;

        _emailTextController.text=docs[0]["email"] ;


      })
    });
  }

  @override
  void initState() {
    super.initState();
    initialise();
    // dropdownValue=docs[0]["routeName"] ;
  }

  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameTextController = TextEditingController();
  TextEditingController _numberTextController = TextEditingController();
  TextEditingController _muncipalAreaTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();

  var emailFocus = FocusNode();
  var passwordFocus = FocusNode();
  var nameFocus = FocusNode();
  var numberFocus = FocusNode();
  var muncipleAreaFocus = FocusNode();

  bool isImageUploading = false;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height / 3;

    bool isPasswordVisible = false;

    return SafeArea(
      child: Scaffold(
        drawer: UserNavigationDrawerWidget(),
        appBar: AppBar(
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,

          title:  Text(""),
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
          // decoration: BoxDecoration(
          //     gradient: LinearGradient(
          //         colors: [Colors.green.shade200, Colors.green.shade900])
          //
          // ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                ),
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
                          ' Profile',
                          style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              shadows: const [
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
                    controller: _numberTextController,
                    focusNode: numberFocus,
                    style: TextStyle(color: Colors.black, fontSize: 14.5),
                    decoration: InputDecoration(
                        prefixIconConstraints: BoxConstraints(minWidth: 45),
                        prefixIcon: Icon(
                          Icons.add_location,
                          color: Colors.grey,
                          size: 22,
                        ),
                        border: InputBorder.none,
                        hintText: 'Telephone Number',
                        hintStyle:
                        TextStyle(color: Colors.grey, fontSize: 12),
                        enabledBorder: OutlineInputBorder(

                            borderSide: BorderSide(color: Colors.grey)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black))),
                  ),
                ),
                Padding(
                  padding:
                  EdgeInsets.symmetric(horizontal: 30).copyWith(bottom: 10),
                  child: TextField(

                    controller: _emailTextController,
                    focusNode: emailFocus,
                    style: TextStyle(color: Colors.black, fontSize: 15),
                    decoration: const InputDecoration(

                        prefixIconConstraints: BoxConstraints(minWidth: 45,minHeight: 20),
                        prefixIcon: Icon(
                          Icons.email,
                          color: Colors.grey,
                          size: 22,
                        ),
                        border: InputBorder.none,
                        hintText: 'Enter Email',
                        hintStyle:
                        TextStyle(color: Colors.grey, fontSize: 12),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black))),
                  ),
                ),

                SizedBox(
                  height: 10,
                ),
                if (isImageUploading)
                  const SpinKitCircle(
                    color: Colors.grey,
                    size: 50.0,
                  ),
                GestureDetector(
                  onTap: () {
                    if (_numberTextController.text.isEmpty) {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return const CustomDialogBox(
                              title: "Munciple Area !",
                              descriptions:
                              "Hii Please Enter the Munciple Area  ",
                              text: "OK",
                            );
                          })
                          .whenComplete(() => FocusScope.of(context)
                          .requestFocus(muncipleAreaFocus));
                    }else if (dropdownValue=="'Select Route Name") {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return const CustomDialogBox(
                              title: "Email !",
                              descriptions: "Hi Select the Route Name",
                              text: "OK",
                            );
                          })
                          .whenComplete(() =>
                          FocusScope.of(context).requestFocus(emailFocus));
                    }
                    else {
                      setState(() {
                        isImageUploading = true;
                      });
                      db
                          .UpdateProileData(
                        docs[0]["id"],
                        _numberTextController.text,

                      )
                          .then((value) => {
                        if (value == true)
                          {

                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return const CustomDialogBox(
                                    title:
                                    ("Profile!"),
                                    descriptions:
                                    "Profile Successfully Done",
                                    text: "ok",
                                  );
                                }).whenComplete(() => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MyHomePage(
                                      title: '',
                                    ))))
                          }
                        else
                          {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return const CustomDialogBox(
                                    title:
                                    ("Profile   !"),
                                    descriptions:
                                    "Profile Unsuccessfull",
                                    text: "ok",
                                  );
                                })
                                .whenComplete(() => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        SignUp())))
                          }
                      });
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
                  height: 30,
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
