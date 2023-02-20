
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';



class MyHomePage11 extends StatefulWidget {


  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  // final String title;

  @override
  State<MyHomePage11> createState() => _MyHomePage11State();
}

class _MyHomePage11State extends State<MyHomePage11> {
  File? selectedImage;
  String? message;
  bool showSpinner = false;

  final myController = TextEditingController();

  uploadImage() async {
    setState(() {
      showSpinner = true;
      message="processing";
    });
    final request = http.MultipartRequest(
        "POST",
        Uri.parse(
            'https://8e56-2402-d000-a500-3525-4c4-19b5-fbea-eb61.ap.ngrok.io/upload'));
    final headers = {"Content-type": "multipart/form-data"};
    request.files.add(http.MultipartFile("image",
        selectedImage!.readAsBytes().asStream(), selectedImage!.lengthSync(),
        filename: selectedImage!.path.split("/").last));
    request.fields['userId'] = 'value';
    request.headers.addAll(headers);
    final response = await request.send();

    http.Response res = await http.Response.fromStream(response);
    print("reached");

    final resJson = jsonDecode(res.body);

    message = resJson['message'];
    print(message);
    setState(() {
      showSpinner = false;
    });
  }

  Future getImage() async {
    final pickedImage =
    await ImagePicker().pickImage(source: ImageSource.gallery);
    selectedImage = File(pickedImage!.path);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(""),
      ),
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            selectedImage == null
                ? Text("please pick a image to upload")
                : Image.file(selectedImage!),
            TextButton.icon(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        Color.fromARGB(255, 62, 187, 0))),
                onPressed: uploadImage,
                icon: Icon(Icons.upload_file_rounded, color: Colors.black38),
                label: Text("Upload waste sample Image",
                    style: TextStyle(color: Colors.black))),
            TextField(
              controller: myController,
              decoration: InputDecoration(
                  border: InputBorder.none, hintText: 'Please enter zipcode '),
            ),
            message == "processing" ? Text("processing") : Text(""),
            message != null ? Text(message.toString()) : Text("")
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: getImage,
        child: Icon(Icons.add_a_photo),
      ),
    );
  }
}
