// // ignore_for_file: prefer_const_constructors


// import 'package:demo_app/Login_Page.dart';
// import 'package:demo_app/dbHelper/mongodb.dart';
// import 'package:demo_app/dbHelper/mongodbDraft.dart';
// import 'package:flutter/material.dart';

// class SignUp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) => Scaffold(
//         body: ListView(
//           children: [
//             Center(
//               child: Container(
//                 height: 850,
//                 width: 350,
//                 decoration: BoxDecoration(
//                   color: Colors.green,
//                   borderRadius: BorderRadius.circular(30),
//                 ),
//                 padding: EdgeInsets.all(20),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Sign Up',
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 24,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     SizedBox(height: 20),
//                     TextField(
//                       obscureText: false,
//                       decoration: InputDecoration(
//                         hintText: 'First Name',
//                         fillColor: Colors.white,
//                         filled: true,
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(20),
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 20), // Add space between fields
//                     TextField(
//                       obscureText: false,
//                       decoration: InputDecoration(
//                         hintText: 'Last Name',
//                         fillColor: Colors.white,
//                         filled: true,
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(20),
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 20), // Add space between fields
//                     TextField(
//                       obscureText: false,
//                       decoration: InputDecoration(
//                         hintText: 'Email',
//                         fillColor: Colors.white,
//                         filled: true,
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(20),
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 20), // Add space between fields
//                     TextField(
//                       obscureText: false,
//                       decoration: InputDecoration(
//                         hintText: 'Contact Number',
//                         fillColor: Colors.white,
//                         filled: true,
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(20),
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 20), // Add space between fields
//                     TextField(
//                       obscureText: false,
//                       decoration: InputDecoration(
//                         hintText: 'Username',
//                         fillColor: Colors.white,
//                         filled: true,
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(20),
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 20), // Add space between fields
//                     TextField(
//                       obscureText: true,
//                       decoration: InputDecoration(
//                         hintText: 'Password',
//                         fillColor: Colors.white,
//                         filled: true,
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(20),
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 20), // Add space between fields
//                     TextField(
//                       obscureText: true,
//                       decoration: InputDecoration(
//                         hintText: 'Confirm Password',
//                         fillColor: Colors.white,
//                         filled: true,
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(20),
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 35), // Add space between fields
//                     ElevatedButton(
//                       onPressed: () {
//                         //  _insertData(fnameController.text, lnameController.text,
//                         //     addressController.text, passwordController.text);
//                       },
//                       style: ElevatedButton.styleFrom(
//                         padding: EdgeInsets.symmetric(vertical: 15),
//                         minimumSize: Size(double.infinity, 50),
//                       ),
//                       child: Text(
//                         'SIGN UP',
//                         style: TextStyle(
//                             color: Colors.black, fontWeight: FontWeight.bold),
//                       ),
//                     ),
//                     SizedBox(height: 15),
//                     Text(
//                       "Don't have an account? ",
//                       style: TextStyle(color: Colors.white),
//                     ),
//                     GestureDetector(
//                       onTap: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) =>
//                                   LoginPage()), // Navigate to SignUp screen
//                         );
//                       },
//                       child: Text(
//                         'Sign In',
//                         style: TextStyle(
//                             color: Colors.blueAccent[700],
//                             fontWeight: FontWeight.bold),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       );
// }

// // Future<void> _insertData(
// //       String fName, String lName, String emailAdd, String pass) async {
// //     var _id = M.ObjectId(); //THIS WILL USE FOR UNIQUE ID
// //     final data = MongoDemo(
// //       id: _id,
// //       firstName: fName,
// //       lastName: lName,
// //       emailAddress: emailAdd,
// //       password: pass,
// //     ); // Changed from address to emailAddress
// //     var result = await MongoDatabase.insert(data);
// //     ScaffoldMessenger.of(context)
// //         .showSnackBar(SnackBar(content: Text("Inserted ID " + _id.$oid)));
// //     _clearAll();
// //   }

// //   void _clearAll() {
// //     fnameController.text = "";
// //     lnameController.text = "";
// //     addressController.text = "";
// //     passwordController.text = "";
// //   }


