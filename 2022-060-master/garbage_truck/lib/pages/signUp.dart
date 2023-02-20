import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:garbage_truck/pages/homePage.dart';
import 'package:garbage_truck/pages/signIn.dart';
import '../../api/userApi.dart';
import '../../dialogs/custom_dialog_box.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
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
        // appBar: AppBar(
        //   // foregroundColor: Colors.black
        //   backgroundColor: Colors.green.shade300,
        //   shadowColor: Colors.green,
        //   title: const Text('Sign Up '),
        //   actions: const [
        //     Padding(
        //       padding: EdgeInsets.symmetric(horizontal: 16),
        //     ),
        //   ],
        // ),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.green.shade200, Colors.green.shade900])),
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
                        boxShadow: [
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
                      children: [
                        Text(
                          'Let\'s',
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
                          ' Register',
                          style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.green.shade600,
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
                    controller: _numberTextController,
                    focusNode: numberFocus,
                    style: TextStyle(color: Colors.white, fontSize: 14.5),
                    decoration: InputDecoration(
                        prefixIconConstraints: BoxConstraints(minWidth: 45),
                        prefixIcon: Icon(
                          Icons.phone,
                          color: Colors.white70,
                          size: 22,
                        ),
                        border: InputBorder.none,
                        hintText: 'Telephone Number',
                        hintStyle:
                            TextStyle(color: Colors.white60, fontSize: 14.5),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30).copyWith(
                                bottomRight: Radius.circular(0),
                                topLeft: Radius.circular(0)),
                            borderSide: BorderSide(color: Colors.white38)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30).copyWith(
                                bottomRight: Radius.circular(0),
                                topLeft: Radius.circular(0)),
                            borderSide: BorderSide(color: Colors.white70))),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 30).copyWith(bottom: 10),
                  child: TextField(
                    controller: _muncipalAreaTextController,
                    focusNode: muncipleAreaFocus,
                    style: TextStyle(color: Colors.white, fontSize: 14.5),
                    decoration: InputDecoration(
                        prefixIconConstraints: BoxConstraints(minWidth: 45),
                        prefixIcon: Icon(
                          Icons.add_location,
                          color: Colors.white70,
                          size: 22,
                        ),
                        border: InputBorder.none,
                        hintText: 'Munciple Area',
                        hintStyle:
                            TextStyle(color: Colors.white60, fontSize: 14.5),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30).copyWith(
                                bottomRight: Radius.circular(0),
                                topLeft: Radius.circular(0)),
                            borderSide: BorderSide(color: Colors.white38)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30).copyWith(
                                bottomRight: Radius.circular(0),
                                topLeft: Radius.circular(0)),
                            borderSide: BorderSide(color: Colors.white70))),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 30).copyWith(bottom: 10),
                  child: TextField(
                    controller: _emailTextController,
                    focusNode: emailFocus,
                    style: TextStyle(color: Colors.white, fontSize: 14.5),
                    decoration: InputDecoration(
                        prefixIconConstraints: BoxConstraints(minWidth: 45),
                        prefixIcon: Icon(
                          Icons.email,
                          color: Colors.white70,
                          size: 22,
                        ),
                        border: InputBorder.none,
                        hintText: 'Enter Email',
                        hintStyle:
                            TextStyle(color: Colors.white60, fontSize: 14.5),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30).copyWith(
                                bottomRight: Radius.circular(0),
                                topLeft: Radius.circular(0)),
                            borderSide: BorderSide(color: Colors.white38)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30).copyWith(
                                bottomRight: Radius.circular(0),
                                topLeft: Radius.circular(0)),
                            borderSide: BorderSide(color: Colors.white70))),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 30).copyWith(bottom: 10),
                  child: TextField(
                    controller: _passwordTextController,
                    focusNode: passwordFocus,
                    style: TextStyle(color: Colors.white, fontSize: 14.5),
                    obscureText: isPasswordVisible ? false : true,
                    decoration: InputDecoration(
                        prefixIconConstraints: BoxConstraints(minWidth: 45),
                        prefixIcon: Icon(
                          Icons.lock,
                          color: Colors.white70,
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
                        hintStyle:
                            TextStyle(color: Colors.white60, fontSize: 14.5),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30).copyWith(
                                bottomRight: Radius.circular(0),
                                topLeft: Radius.circular(0)),
                            borderSide: BorderSide(color: Colors.white38)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30).copyWith(
                                bottomRight: Radius.circular(0),
                                topLeft: Radius.circular(0)),
                            borderSide: BorderSide(color: Colors.white70))),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                if (isImageUploading)
                  const SpinKitCircle(
                    color: Colors.white,
                    size: 50.0,
                  ),
                GestureDetector(
                  onTap: () {
                    if (_numberTextController.text.isEmpty) {
                      showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return const CustomDialogBox(
                                  title: "Number !",
                                  descriptions: "Hii Please Enter the Number ",
                                  text: "OK",
                                );
                              })
                          .whenComplete(() =>
                              FocusScope.of(context).requestFocus(numberFocus));
                    } else if (_muncipalAreaTextController.text.isEmpty) {
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
                    } else if (_emailTextController.text.isEmpty) {
                      showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return const CustomDialogBox(
                                  title: "Email !",
                                  descriptions: "Hi Please Enter the Email",
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
                          .signUp(
                              _numberTextController.text,
                              _muncipalAreaTextController.text,
                              _emailTextController.text,
                              _passwordTextController.text)
                          .then((value) => {
                                if (value == true)
                                  {
                                setState(() {
                              isImageUploading = false;
                            }),
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return const CustomDialogBox(
                                            title:
                                                ("Registration Successfull!"),
                                            descriptions:
                                                "Registration Successfully Done",
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
                                                    ("Registration UnSuccessful  !"),
                                                descriptions:
                                                    "This Email is already in use",
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
                        borderRadius: BorderRadius.circular(30).copyWith(
                            bottomRight: Radius.circular(0),
                            topLeft: Radius.circular(0)),
                        gradient: LinearGradient(colors: [
                          Colors.green.shade200,
                          Colors.green.shade900
                        ])),
                    child: Text('Register',
                        style: TextStyle(
                            color: Colors.white.withOpacity(.8),
                            fontSize: 15,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                InkWell(
                  onTap: () => Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => SignIn())),
                  child: Text('Already have an account SignIn',
                      style: TextStyle(color: Colors.white70, fontSize: 13)),
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