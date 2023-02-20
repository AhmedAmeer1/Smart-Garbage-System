import 'package:flutter/material.dart';
import '../../api/garbageBinApi.dart';
import '../../dialogs/custom_dialog_box.dart';
import '../homePage.dart';
import '../maps/calculateRoute.dart';

class FilledBinsDetails extends StatefulWidget {
  const FilledBinsDetails({Key? key}) : super(key: key);
  @override
  _FilledBinsDetailsState createState() => _FilledBinsDetailsState();
}
class _FilledBinsDetailsState extends State<FilledBinsDetails> {

  late Database db;
  List docs =[];

  initialise(){
    db=Database();
    db.initiliase();
    db.readFilledBins().then((value) =>{
      setState((){
        docs=value;
      })
    } );
  }

  @override
  void initState() {
    super.initState();
    initialise();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // foregroundColor: Colors.black
        backgroundColor: Colors.green.shade300,
        shadowColor: Colors.green,
        title: const Text('Received Bins '),
        actions: const [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.green.shade200, Colors.green.shade900])),
        child: Stack(

          children: [
            // Image.asset(
            //   'assets/images/5.webp',
            //   fit: BoxFit.cover,
            //   height: double.infinity,
            //   width: double.infinity,
            // ),
            // Container(
            //   color: Colors.white.withOpacity(0.8),
            //   width: double.infinity,
            //   height: double.infinity,
            // ),
            Container(
              child: ListView.builder(
                  itemCount: docs.length,
                  itemBuilder: (BuildContext context, int index){
                    return Card(
                        color: Colors.green.shade200,
                        margin: EdgeInsets.all(10),
                        child :Column(
                          children: [
                            ListTile(
                              onTap: (){},
                              contentPadding: EdgeInsets.only(right:30,left:36,top:10),
                              title: Text('place :'+docs[index]['place']),
                              subtitle: Padding(
                                padding: const  EdgeInsets.only(top:10),
                                child: Text(docs[index]['cDate']),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: FlatButton(
                                    child: const Text('Assign Route',style: TextStyle(color: Colors.white),),
                                    color: Colors.green.shade700,
                                    textColor: Colors.white,
                                    onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute( builder: (context) =>   CalculateRouteMap(start:'rajagiriya',destination:docs[index]['place'])
                                      ));
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )
                    );
                  }
              ),
            )
          ],
        ),
      ),
    );
  }
}
