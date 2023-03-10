import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:garbage_truck/api/user_model.dart';

import 'package:garbage_truck/pages/map.dart';
import 'package:garbage_truck/pages/signUp.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../dialogs/custom_dialog_box.dart';
import '../../api/userApi.dart';
import 'Admin/Routes/ViewRoutesByBin.dart';

import 'Driver/viewFullRoute.dart';
import 'User/userHome.dart';
import 'User/viewTruck.dart';

class SignIn extends StatefulWidget {
  SignIn({Key? key}) : super(key: key);
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  late Database db;

  final _auth = FirebaseAuth.instance;

  initialise() {
    db = Database();
    db.initiliase();
  }

  @override
  void initState() {
    super.initState();
    initialise();
  }

  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();

  var emailFocus = FocusNode();
  var passwordFocus = FocusNode();
  bool isImageUploading = false;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height / 3;

    bool isPasswordVisible = false;

    return SafeArea(
      child: Scaffold(
        body: Container(
          height: double.infinity,
          width: double.infinity,
          alignment: Alignment.center,
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
                      boxShadow: [
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
                          'Let\'s Login',
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
                      EdgeInsets.symmetric(horizontal: 30).copyWith(bottom: 40),
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
                        hintText: 'Enter Email',
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
                    controller: _passwordTextController,
                    focusNode: passwordFocus,
                    style: TextStyle(color: Colors.grey, fontSize: 14.5),
                    obscureText: isPasswordVisible ? false : true,
                    decoration: InputDecoration(
                        prefixIconConstraints: BoxConstraints(minWidth: 45),
                        prefixIcon: const Icon(
                          Icons.lock,
                          color: Colors.grey,
                          size: 22,
                        ),
                        suffixIconConstraints:
                            BoxConstraints(minWidth: 45, maxWidth: 46),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              isPasswordVisible = !isPasswordVisible;
                            });
                          },
                          child: Icon(
                            isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.white70,
                            size: 22,
                          ),
                        ),
                        border: InputBorder.none,
                        hintText: 'Enter Password',
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 12),
                        enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black))),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                if (isImageUploading)
                  const SpinKitCircle(
                    color: Colors.grey,
                    size: 50.0,
                  ),
                const SizedBox(
                  height: 40,
                ),
                GestureDetector(
                  onTap: () {
                    bool emailValid = RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(_emailTextController.text);

                    if (_emailTextController.text.isEmpty) {
                      showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return const CustomDialogBox(
                                  title: "Email ",
                                  descriptions: "Hii Please Enter the Email",
                                  text: "OK",
                                );
                              })
                          .whenComplete(() =>
                              FocusScope.of(context).requestFocus(emailFocus));
                    } else if (emailValid == false) {
                      showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return const CustomDialogBox(
                                  title: "Email !",
                                  descriptions:
                                      " Please Enter the valid  Email",
                                  text: "OK",
                                );
                              })
                          .whenComplete(() =>
                              FocusScope.of(context).requestFocus(emailFocus));
                    } else if (_passwordTextController.text.isEmpty) {
                      showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return const CustomDialogBox(
                                  title: "Password !",
                                  descriptions:
                                      "Hii Please Enter the Password ",
                                  text: "OK",
                                );
                              })
                          .whenComplete(() => FocusScope.of(context)
                              .requestFocus(passwordFocus));
                    } else {
                      setState(() {
                        isImageUploading = true;
                      });

                      db
                          .signIn(_emailTextController.text,
                              _passwordTextController.text)
                          .then((value) => {
                                setState(() {
                                  isImageUploading = false;
                                }),
                                print(value),
                                if (value == true)
                                  {
                                    print(value),
                                    if (_emailTextController.text ==
                                        'admin@gmail.com')
                                      {
                                        showDialog(
                                                context: context,
                                                builder: (BuildContext context) {
                                                  return const CustomDialogBox(
                                                    title:
                                                        ("Login successful !"),
                                                    descriptions:
                                                        "Your Login is successful!",
                                                    text: "ok",
                                                  );
                                                })
                                            .whenComplete(() => Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        AdminViewRoute())))
                                      }
                                    else  if(_emailTextController.text ==
                                        'driver@gmail.com')
                                      {
                                        showDialog(
                                                context: context,
                                                builder: (BuildContext context) {
                                                  return const CustomDialogBox(
                                                    title:
                                                        ("Login successful !"),
                                                    descriptions:
                                                        "Your Login is successful!",
                                                    text: "ok",
                                                  );
                                                })
                                            .whenComplete(() => Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        DriverViewRoute(
                                                          id: '',routeAssign: '',
                                                        ))))
                                      }
                    else
                    {
                    showDialog(
                    context: context,
                    builder: (BuildContext context) {
                    return const CustomDialogBox(
                    title:
                    ("Login successful !"),
                    descriptions:
                    "Your Login is successful!",
                    text: "ok",
                    );
                    })
                        .whenComplete(() => Navigator.push(
                    context,
                    MaterialPageRoute(
                    builder: (context) =>
                    MyHomePage(
                    title: '',
                    ))))
                    }
                                  }
                                else if (value == null)
                                  {
                                    print(value),
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return const CustomDialogBox(
                                            title: ("Login UnSuccessful  !"),
                                            descriptions:
                                                "Your Email or Password is inCorrect",
                                            text: "ok",
                                          );
                                        }).whenComplete(() => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => MyHomePage(
                                                  title: '',
                                                ))))
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
                        borderRadius: BorderRadius.circular(0).copyWith(
                            bottomRight: Radius.circular(0),
                            topLeft: Radius.circular(0)),
                        gradient: LinearGradient(colors: [
                          Colors.green.shade200,
                          Colors.green.shade900
                        ])),
                    child: Text('Login',
                        style: TextStyle(
                            color: Colors.white.withOpacity(.8),
                            fontSize: 15,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Don\'t have an account?',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      ),
                      InkWell(
                        onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => SignUp())),
                        child: Text(' SignUp',
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                                shadows: [
                                  Shadow(
                                      color: Colors.green,
                                      offset: Offset(1, 1),
                                      blurRadius: 5)
                                ])),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const SizedBox(
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
