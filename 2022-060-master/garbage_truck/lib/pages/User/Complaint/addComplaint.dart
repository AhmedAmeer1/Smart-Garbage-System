import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../api/complaintApi.dart';
import '../../../dialogs/custom_dialog_box.dart';

import '../../testfile.dart';
import '../userHome.dart';
import '../userNavigationDrawer.dart';

class AddComplaint extends StatefulWidget {
  @override
  _AddComplaintpageState createState() => _AddComplaintpageState();
}

class _AddComplaintpageState extends State<AddComplaint> {
  late Database db;

  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _lorryNumberTextController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  var lorryNumberFocus = FocusNode();
  var emailFocus = FocusNode();
  var descriptionFocus = FocusNode();

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
        drawer: UserNavigationDrawerWidget(),
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
                const SizedBox(
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
                          ' Complaint',
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
                const SizedBox(
                  height: 40,
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 30).copyWith(bottom: 10),
                  child: TextField(
                    controller: _lorryNumberTextController,
                    focusNode: lorryNumberFocus,
                    style: TextStyle(color: Colors.grey, fontSize: 14.5),
                    decoration: const InputDecoration(
                        prefixIconConstraints: BoxConstraints(minWidth: 45),
                        prefixIcon: Icon(
                          Icons.add_outlined,
                          color: Colors.grey,
                          size: 22,
                        ),
                        border: InputBorder.none,
                        hintText: 'Lorry Number',
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
                  child: TextField(
                    controller: _emailTextController,
                    focusNode: emailFocus,
                    style: TextStyle(color: Colors.grey, fontSize: 14.5),
                    decoration: const InputDecoration(
                        prefixIconConstraints: BoxConstraints(minWidth: 45),
                        prefixIcon: Icon(
                          Icons.email,
                          color: Colors.grey,
                          size: 22,
                        ),
                        border: InputBorder.none,
                        hintText: 'Email',
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
                  child: TextField(
                    controller: _descriptionController,
                    focusNode: descriptionFocus,
                    maxLines: 6,
                    style: TextStyle(color: Colors.grey, fontSize: 14.5),
                    decoration: const InputDecoration(
                        prefixIconConstraints: BoxConstraints(minWidth: 45),
                        border: InputBorder.none,
                        hintText: 'Description',
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 12),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black))),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    if (_lorryNumberTextController.text.isEmpty) {
                      showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return const CustomDialogBox(
                                  title: "Lorry Number !",
                                  descriptions:
                                      "Hii Please Enter the Lorry Number",
                                  text: "OK",
                                );
                              })
                          .whenComplete(() => FocusScope.of(context)
                              .requestFocus(lorryNumberFocus));
                    } else if (_emailTextController.text.isEmpty) {
                      showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return const CustomDialogBox(
                                  title: "email  !",
                                  descriptions: "Hii Please Enter the email",
                                  text: "OK",
                                );
                              })
                          .whenComplete(() =>
                              FocusScope.of(context).requestFocus(emailFocus));
                    } else if (_descriptionController.text.isEmpty) {
                      showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return const CustomDialogBox(
                                  title: "Description !",
                                  descriptions:
                                      "Hii Please Enter the Description r",
                                  text: "OK",
                                );
                              })
                          .whenComplete(() => FocusScope.of(context)
                              .requestFocus(descriptionFocus));
                    } else {
                      db.createComplaint(
                          _lorryNumberTextController.text,
                          _emailTextController.text,
                          _descriptionController.text);
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return const CustomDialogBox(
                              title: ("Complaint !"),
                              descriptions: "Complaint Sent Successfully!",
                              text: "ok",
                            );
                          }).whenComplete(() => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MyHomePage(
                                    title: 'Flower',
                                  ))));
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
                    child: Text('Submit',
                        style: TextStyle(
                            color: Colors.white.withOpacity(.8),
                            fontSize: 18,
                            fontWeight: FontWeight.bold)),
                  ),
                ),

                const SizedBox(
                  height:50,
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
