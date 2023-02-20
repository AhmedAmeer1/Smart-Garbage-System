import 'package:flutter_sms/flutter_sms.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:garbage_truck/pages/Admin/Notice/viewRouteNotice.dart';
import '../../../api/userApi.dart';
import '../../../dialogs/custom_dialog_box.dart';
import '../../maps/calculateRoute.dart';
import '../adminNavigationDrawer.dart';


class SendNotice extends StatefulWidget {
  final routeName;
  final routeId;


  SendNotice({
    this.routeName,
    this.routeId,
  });

  @override
  _SendNoticeState createState() => _SendNoticeState();
}

class _SendNoticeState extends State<SendNotice> {
  late TextEditingController _controllerPeople, _controllerMessage;
  String? _message, body;
  String _canSendSMSMessage = 'Check is not run.';
  // List<String> people = [];
  // List<> people = [];
  List<String> people = [];
  List testpeople = [];
  bool sendDirect = false;

  late Database db;
  List docs = [];
  List docs1 = [];

  @override
  void initState() {
    super.initState();
    initPlatformState();

    // _controllerMessage = "truck is on its way " as TextEditingController;

    db = Database();
    db.initiliase();
    db.ViewNumberByRouteName(widget.routeId, widget.routeName).then((value) => {
          setState(() {
            docs = value;
            for (int i = 0; i < docs.length; i++) {
              people.add(docs[i]);
            }
          })
        });
  }

  Future<void> initPlatformState() async {
    _controllerPeople = TextEditingController();
    _controllerMessage = TextEditingController();
  }

  Future<void> _sendSMS(List<String> recipients) async {
    try {
      String _result = await sendSMS(
        message: _controllerMessage.text,
        recipients: recipients,
        // sendDirect: sendDirect,
      );
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return const CustomDialogBox(
              title: "SMS !",
              descriptions: "SMS sent successfully  ",
              text: "OK",
            );
          }).whenComplete(() => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ViewRouteToNotice(

                  ))));
      // setState(() => _message = _result);
    } catch (error) {
      setState(() => _message = error.toString());
    }
  }

  Future<bool> _canSendSMS() async {
    bool _result = await canSendSMS();
    setState(() => _canSendSMSMessage =
        _result ? 'This unit can send SMS' : 'This unit cannot send SMS');
    return _result;
  }

  Widget _phoneTile(String name) {
    return Padding(
      padding: const EdgeInsets.all(3),
      child: Container(
          decoration: BoxDecoration(
              border: Border(
            bottom: BorderSide(color: Colors.grey.shade300),
            top: BorderSide(color: Colors.grey.shade300),
            left: BorderSide(color: Colors.grey.shade300),
            right: BorderSide(color: Colors.grey.shade300),
          )),
          child: Padding(
            padding: const EdgeInsets.all(4),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => setState(() => people.remove(name)),
                ),
                Padding(
                  padding: const EdgeInsets.all(0),
                  child: Text(
                    name,
                    textScaleFactor: 1,
                    style: const TextStyle(fontSize: 12),
                  ),
                )
              ],
            ),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        drawer: NavigationDrawerWidget(),
        appBar: AppBar(
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
          shadowColor: Colors.green,
          title: Text(widget.routeName),
          actions: const [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
            ),
          ],
        ),
        body: ListView(
          children: <Widget>[
            Container(
                child: Padding(
              padding: const EdgeInsets.only(top: 28.0),
              child: Icon(Icons.message, size: 250, color: Colors.black),
            )),
            SizedBox(height: 80),
            if (people.isEmpty)
              const SizedBox(height: 0)
            else
              SizedBox(
                height: 90,
                child: Padding(
                  padding: const EdgeInsets.all(3),
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: List<Widget>.generate(people.length, (int index) {
                      return _phoneTile(people[index]);
                    }),
                  ),
                ),
              ),
            SizedBox(height: 10),
            const Divider(),
            ListTile(
              title: TextField(
                maxLines: 6,
                controller: _controllerMessage,
                style: TextStyle(color: Colors.grey, fontSize: 14.5),
                decoration: InputDecoration(
                    prefixIconConstraints: BoxConstraints(minWidth: 45),
                    border: InputBorder.none,
                    hintText: 'Add Message',
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 12),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black))),
                onChanged: (String value) => setState(() {}),
              ),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith(
                      (states) => Theme.of(context).colorScheme.secondary),
                  padding: MaterialStateProperty.resolveWith(
                      (states) => const EdgeInsets.symmetric(vertical: 12)),
                ),
                onPressed: () {
                  _send();
                },
                child: Text('SEND SMS', style: TextStyle(fontSize: 20)),
              ),
            ),
            Visibility(
              visible: _message != null,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Text(
                        _message ?? 'No Data',
                        maxLines: null,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _send() {
    if (people.isEmpty) {
      setState(() => _message = 'At Least 1 Person or Message Required');
    } else {
      _sendSMS(people);
    }
  }
}
