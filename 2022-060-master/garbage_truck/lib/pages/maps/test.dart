import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:permission_handler/permission_handler.dart';
import '../../api/garbageBinApi.dart';
import '../../api/garbageBinApi.dart';
import '../../dialogs/custom_dialog_box.dart';
import '../homePage.dart';


class AddGarbagePlaces extends StatefulWidget {










  @override
  _AddGarbagePlacesState createState() => _AddGarbagePlacesState();
}

class _AddGarbagePlacesState extends State<AddGarbagePlaces> {
  late Database db;

  final _formKey = GlobalKey<FormState>();
  TextEditingController _placeTextController = TextEditingController();



  var placeFocus = FocusNode();



  initialise(){
    db=Database();
    db.initiliase();
  }

  @override
  void initState() {
    super.initState();
    initialise();

  }


  @override
  Widget build(BuildContext context) {
    double height =MediaQuery.of(context).size.height/3;

    return Scaffold(
      appBar:AppBar(
        foregroundColor: Colors.black,
        title: Text('Assign A bin Place '),
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
          ),
        ],
        backgroundColor: Colors.white,
      ),
      body:  SingleChildScrollView(

        child: Container(

          padding: EdgeInsets.fromLTRB(2.0, 10.0, 2.0, 10.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top:30),
                child: Container(
                  alignment: Alignment.topCenter,
                  child: Image.asset('assets/images/13.png',width: 150.0,height: 150.0,),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                  padding: const EdgeInsets.fromLTRB(14.0,8.0,14.0,8.0),
                  child: Material(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.grey.withOpacity(0.4),
                    elevation: 0.0,
                    child: Padding(
                      padding: const EdgeInsets.only(left:12.0),
                      child: TextFormField(
                        controller: _placeTextController,
                        focusNode: placeFocus,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Place ',
                          icon:Icon(Icons.account_tree),
                        ),

                      ),
                    ),
                  )
              ),

              SizedBox(
                height: 5,
              ),



            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        color: Colors.transparent,
        child: BottomAppBar(
          color: Colors.transparent,

          child: RaisedButton(

              color: Colors.green.shade700,
              onPressed: () {

                if (_placeTextController.text.isEmpty) {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return const CustomDialogBox(
                          title: "Place  !",
                          descriptions:
                          "Hii Please Enter the Place ",
                          text: "OK",
                        );
                      }).whenComplete(() =>
                      FocusScope.of(context).requestFocus(placeFocus));
                }

                else {
                  db.createGarbageBin(
                      _placeTextController.text );
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return const CustomDialogBox (
                          title: ("Place  Added !"),
                          descriptions: "Place  added successfully!",
                          text: "ok",
                        );
                      })
                      .whenComplete(() =>
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MyHomePage(title: 'Flower',))));
                }
              },


              child: const Text(
                " Add Place",
                style: TextStyle(color: Colors.white),
              )),
        ),
      ),
    );
  }
}
