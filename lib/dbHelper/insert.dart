// // ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, deprecated_member_use, prefer_interpolation_to_compose_strings, unused_local_variable

// import 'package:demo_app/dbHelper/display.dart';
// import 'package:demo_app/dbHelper/mongodb.dart';
// import 'package:demo_app/dbHelper/mongodbDraft.dart';
// import 'package:flutter/material.dart';
// import 'package:mongo_dart/mongo_dart.dart' as M;

// class DataInsert extends StatefulWidget {
//   DataInsert({Key? key}) : super(key: key);

//   @override
//   State<DataInsert> createState() => _DataInsertState();
// }

// class _DataInsertState extends State<DataInsert> {
//   var fnameController = new TextEditingController();
//   var lnameController = new TextEditingController();
//   var addressController = new TextEditingController();
//   var passwordController = new TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//           child: Padding(
//         padding: const EdgeInsets.all(15.0),
//         child: Column(
//           children: [
//             Text(
//               "Insert Data",
//               style: TextStyle(fontSize: 30),
//             ),
//             SizedBox(
//               height: 50,
//             ),
//             TextField(
//               controller: fnameController,
//               decoration: InputDecoration(labelText: "First Name"),
//             ),
//             TextField(
//               controller: lnameController,
//               decoration: InputDecoration(labelText: "Last Name"),
//             ),
//             TextField(
//               controller: addressController,
//               decoration: InputDecoration(labelText: "Email Address"),
//             ),
//             TextField(
//               controller: passwordController,
//               obscureText: true, // This hides the entered text
//               decoration: InputDecoration(labelText: "Password"),
//             ),
//             SizedBox(
//               height: 50,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 ElevatedButton(
//                     onPressed: () {
//                       _insertData(fnameController.text, lnameController.text,
//                           addressController.text, passwordController.text);
//                     },
//                     child: Text("Insert Data")),
//                 ElevatedButton(
//                     onPressed: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => MongodbDisplay()),
//                       );
//                     },
//                     child: Text("Display"))
//               ],
//             )
//           ],
//         ),
//       )),
//     );
//   }

//   Future<void> _insertData(
//       String fName, String lName, String emailAdd, String pass) async {
//     var _id = M.ObjectId(); //THIS WILL USE FOR UNIQUE ID
//     final data = MongoDemo(
//       id: _id,
//       firstName: fName,
//       lastName: lName,
//       emailAddress: emailAdd,
//       password: pass,
//     ); // Changed from address to emailAddress
//     var result = await MongoDatabase.insert(data);
//     ScaffoldMessenger.of(context)
//         .showSnackBar(SnackBar(content: Text("Inserted ID " + _id.$oid)));
//     _clearAll();
//   }

//   void _clearAll() {
//     fnameController.text = "";
//     lnameController.text = "";
//     addressController.text = "";
//     passwordController.text = "";
//   }
// }
