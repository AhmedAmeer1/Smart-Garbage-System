// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:garbage_truck/pages/SuperAdmin/bin/updateBin.dart';
//
//
// import '../../../api/binApi.dart';
// import '../../maps/calculateRoute.dart';
// import '../superAdminNavigationDrawer.dart';
// import 'addBin.dart';
//
//
//
// // import '../../api/complaintApi.dart';
//
// class ViewBin extends StatefulWidget {
//   const ViewBin({Key? key}) : super(key: key);
//   @override
//   _ViewBinState createState() => _ViewBinState();
// }
//
// class _ViewBinState extends State<ViewBin> {
//   late Database db;
//   List docs = [];
//
//   initialise() {
//     db = Database();
//     db.initiliase();
//     db.readBinDetails().then((value) => {
//       setState(() {
//         docs = value;
//       })
//     });
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     initialise();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       drawer: SuperAdminNavigationDrawerWidget(),
//       appBar: AppBar(
//         foregroundColor: Colors.black,
//         backgroundColor: Colors.white,
//         shadowColor: Colors.green,
//         title: const Text('Available Bin '),
//         actions: const [
//           Padding(
//             padding: EdgeInsets.symmetric(horizontal: 16),
//           ),
//         ],
//       ),
//       body: Container(
//         // decoration: BoxDecoration(
//         //     gradient: LinearGradient(
//         //         colors: [Colors.green.shade200, Colors.green.shade900])),
//         child: Stack(
//           children: [
//
//             Container(
//               child: ListView.builder(
//                   itemCount: docs.length,
//                   itemBuilder: (BuildContext context, int index) {
//                     return Card(
//                         color: Colors.grey.shade200,
//                         shadowColor: Colors.black,
//                         clipBehavior: Clip.antiAlias,
//                         margin: EdgeInsets.all(20),
//                         child: Column(
//                           children: [
//                             ListTile(
//                               onTap: () {},
//                               contentPadding:
//                               EdgeInsets.only(right: 30, left: 36, top: 10),
//                               title: Padding(
//                                 padding: const EdgeInsets.only(bottom: 12.0),
//                                 child: Text('binName : ' +
//                                     docs[index]['routeName'],style: TextStyle(fontSize: 18,color: CupertinoColors.darkBackgroundGray),),
//                               ),
//
//                               subtitle: Padding(
//                                 padding: const EdgeInsets.only(top: 10),
//                                 child: Text('quantity : '+docs[index]['quantity'].toString(),style: TextStyle(fontSize: 18,color: CupertinoColors.darkBackgroundGray),),
//                               ),
//
//                               // leading: Text('vehicle type'+docs[index]['vehicleNumber']),
//                             ),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.end,
//                               children: <Widget>[
//                                 Padding(
//                                   padding: const EdgeInsets.all(8.0),
//                                   child: FlatButton(
//                                     child: const Text('Update',style: TextStyle(color: Colors.white),),
//                                     color: Colors.green.shade700,
//                                     textColor: Colors.white,
//                                     onPressed: () {
//                                       Navigator.of(context).push(MaterialPageRoute( builder: (context) =>   UpdateBin(binId:docs[index]['id'],routeName:docs[index]['routeName'],quantity:docs[index]['quantity'])
//                                       ));
//                                     },
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.end,
//                               children: const <Widget>[
//                                 Padding(
//                                   padding: EdgeInsets.all(8.0),
//                                 ),
//                               ],
//                             ),
//
//                           ],
//                         ));
//                   }),
//
//             )
//           ],
//
//         ),
//
//       ),
//       floatingActionButton: FloatingActionButton(
//
//         onPressed: () {
//           Navigator.push(
//               context, MaterialPageRoute(builder: (context) => AddBin()));
//
//         },
//
//
//         // onPressed: void AddVehicle(),
//         tooltip: 'Increment',
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }
