// // ignore_for_file: prefer_const_constructors

// import 'package:demo_app/Deleted.dart';
// import 'package:demo_app/SignUp_Page.dart';
// //import 'package:demo_app/DemoSignUp.dart';
// import 'package:demo_app/dbHelper/insert.dart';
// import 'package:demo_app/dbHelper/mongodb.dart';
// import 'package:demo_app/dbHelper/mongodbDraft.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';

// class MongodbDisplay extends StatefulWidget {
//   const MongodbDisplay({Key? key}) : super(key: key);

//   @override
//   State<MongodbDisplay> createState() => _MongodbDisplayState();
// }

// class _MongodbDisplayState extends State<MongodbDisplay> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(10.0),
//           child: FutureBuilder(
//             future: MongoDatabase.getData(),
//             builder: (context, AsyncSnapshot snapshot) {
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return Center(
//                   child: CircularProgressIndicator(),
//                 );
//               } else {
//                 if (snapshot.hasData) {
//                   var totalData = snapshot.data.length;
//                   print("Total Data" + totalData.toString());
//                   return ListView.builder(
//                     itemCount: snapshot.data.length,
//                     itemBuilder: (context, index) {
//                       return displayCard(
//                         MongoDemo.fromJson(snapshot.data[index]),
//                       );
//                     },
//                   );
//                 } else {
//                   return Center(
//                     child: Text("No Data Available"),
//                   );
//                 }
//               }
//             },
//           ),
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) => DataInsert()),
//           );
//         },
//         child: Icon(Icons.add),
//       ),
//     );
//   }

//   Widget displayCard(MongoDemo data) {
//     return Card(
//       child: Padding(
//         padding: const EdgeInsets.all(15.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             TextField(
//               enabled: false,
//               decoration: InputDecoration(labelText: "ID"),
//               controller: TextEditingController(text: data.id.$oid),
//             ),
//             SizedBox(height: 5),
//             TextField(
//               enabled: false,
//               decoration: InputDecoration(labelText: "First Name"),
//               controller: TextEditingController(text: data.firstName),
//             ),
//             SizedBox(height: 5),
//             TextField(
//               enabled: false,
//               decoration: InputDecoration(labelText: "Last Name"),
//               controller: TextEditingController(text: data.lastName),
//             ),
//             SizedBox(height: 5),
//             TextField(
//               enabled: true,
//               decoration: InputDecoration(labelText: "Email Address"),
//               controller: TextEditingController(text: data.emailAddress),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
