// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings, use_build_context_synchronously, deprecated_member_use, non_constant_identifier_names, no_leading_underscores_for_local_identifiers, unused_local_variable

import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart' as M;
import 'package:demo_app/Login_Page.dart';
import 'package:demo_app/dbHelper/mongodb.dart';
import 'package:demo_app/dbHelper/mongodbDraft.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  var fnameController = TextEditingController();
  var lnameController = TextEditingController();
  var addressController = TextEditingController();
  var usernameController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPassController = TextEditingController();
  var contactNumController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: ListView(
        children: [
          Center(
            child: Container(
              height: 850,
              width: 400,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.green[900]!,
                    Colors.green[800]!,
                    Colors.green[400]!,
                  ],
                ),
                borderRadius: BorderRadius.circular(30),
              ),
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text(
                    'Sign Up',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    obscureText: false,
                    controller: fnameController,
                    decoration: InputDecoration(
                      hintText: 'First Name',
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20), // Add space between fields
                  TextField(
                    obscureText: false,
                    controller: lnameController,
                    decoration: InputDecoration(
                      hintText: 'Last Name',
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20), // Add space between fields
                  TextField(
                    obscureText: false,
                    controller: addressController,
                    decoration: InputDecoration(
                      hintText: 'Email',
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20), // Add space between fields
                  TextField(
                    obscureText: false,
                    controller: contactNumController,
                    decoration: InputDecoration(
                      hintText: 'Contact Number',
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20), // Add space between fields
                  TextField(
                    obscureText: false,
                    controller: usernameController,
                    decoration: InputDecoration(
                      hintText: 'Username',
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20), // Add space between fields
                  TextField(
                    obscureText: true,
                    controller: passwordController,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20), // Add space between fields
                  TextField(
                    obscureText: true,
                    controller: confirmPassController,
                    decoration: InputDecoration(
                      hintText: 'Confirm Password',
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  const SizedBox(height: 35), // Add space between fields
                  ElevatedButton(
                    onPressed: () {
                      if (_validateFields()) {
                        if (passwordController.text ==
                            confirmPassController.text) {
                          _insertData(
                            fnameController.text,
                            lnameController.text,
                            addressController.text,
                            usernameController.text,
                            passwordController.text,
                            contactNumController.text,
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Passwords do not match")),
                          );
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Please fill in all fields")),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    child: const Text(
                      'SIGN UP',
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    "Already have an account? ",
                    style: TextStyle(color: Colors.white),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginPage(),
                        ),
                      );
                    },
                    child: Text(
                      'Sign In',
                      style: TextStyle(
                        color: Colors.blue[400],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _insertData(
    String fName,
    String lName,
    String emailAdd,
    String userN,
    String pass, // Plain text password
    String contact_num,
  ) async {
    var _id = M.ObjectId();
    final plainPassword = pass; // Store the plain text password for hashing

    // Hash the password using the hashPassword function
    final hashedPassword = await hashPassword(plainPassword);

    final data = MongoDemo(
      id: _id,
      firstName: fName,
      lastName: lName,
      emailAddress: emailAdd,
      contactNum: contact_num,
      username: userN,
      password: hashedPassword, // Store the hashed password
    );
    var result = await MongoDatabase.insert(data);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Inserted ID " + _id.$oid)),
    );
    _clearAll();
    Navigator.pop(context);
  }

  void _clearAll() {
    fnameController.text = "";
    lnameController.text = "";
    addressController.text = "";
    contactNumController.text = "";
    usernameController.text = "";
    passwordController.text = "";
    confirmPassController.text = "";
  }

  bool _validateFields() {
    return fnameController.text.isNotEmpty &&
        lnameController.text.isNotEmpty &&
        addressController.text.isNotEmpty &&
        contactNumController.text.isNotEmpty &&
        usernameController.text.isNotEmpty &&
        passwordController.text.isNotEmpty &&
        confirmPassController.text.isNotEmpty;
  }
}
