// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously, unnecessary_null_comparison, use_key_in_widget_constructors, avoid_print, await_only_futures, file_names

import 'package:flutter/material.dart';
import 'package:demo_app/dashboard_screen.dart';
import 'package:demo_app/signUp_screen.dart';
import 'package:demo_app/dbHelper/mongodb.dart';
import 'package:bcrypt/bcrypt.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> _login(BuildContext context) async {
    final String username = usernameController.text;
    final String password = passwordController.text;

    try {
      final userDetails =
          await MongoDatabase.getUserDetailsByUsername(username);
      if (userDetails != null) {
        final String storedPasswordHash = userDetails['password'];

        // Validate the password using the validatePassword function
        if (await validatePassword(password, storedPasswordHash)) {
          // Passwords match, proceed with login
          print("Login successful");
          // Navigate to Dashboard or perform any other actions after successful login
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => SideBarLayout(
                title: "Dashboard",
                mainContent: DateTimeWidget(),
                userName: userDetails['firstName'] ?? '',
                userLastName: userDetails['lastName'] ?? '',
                userEmail: userDetails['email_Address'] ?? '',
              ),
            ),
          );
        } else {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Login Failed"),
                content: Text("Invalid password"),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("OK"),
                  ),
                ],
              );
            },
          );
        }
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Login Failed"),
              content: Text("Invalid username"),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("OK"),
                ),
              ],
            );
          },
        );
      }
    } catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Error"),
            content: Text("An error occurred during login. Please try again."),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("OK"),
              ),
            ],
          );
        },
      );
    }
  }

  Future<bool> validatePassword(
      String providedPassword, String storedPasswordHash) async {
    try {
      // Compare the provided password with the hashed password stored in the database
      return await BCrypt.checkpw(providedPassword, storedPasswordHash);
    } catch (e) {
      // Handle error
      print("Error validating password: $e");
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.green[900]!,
              Colors.green[800]!,
              Colors.green[400]!,
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 80),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Login",
                    style: TextStyle(color: Colors.white, fontSize: 40),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Welcome to Towi",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(60),
                    topRight: Radius.circular(60),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(30),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 60,
                      ),
                      Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromRGBO(63, 172, 48, 0.808),
                              blurRadius: 20,
                              offset: Offset(0, 10),
                            ),
                          ],
                        ),
                        child: Column(
                          children: <Widget>[
                            // Username Text Field with Title
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Username',
                                  style: TextStyle(
                                    color: Colors.green[900],
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color: Colors.grey[200]!,
                                      ),
                                    ),
                                  ),
                                  child: TextField(
                                    controller:
                                        usernameController, // Add controller
                                    decoration: InputDecoration(
                                      hintText: 'Enter your username',
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20), // Adjust spacing as needed
                            // Password Text Field with Title
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Password',
                                  style: TextStyle(
                                    color: Colors.green[900],
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color: Colors.grey[200]!,
                                      ),
                                    ),
                                  ),
                                  child: TextField(
                                    controller:
                                        passwordController, // Add controller
                                    obscureText: true, // To hide password
                                    decoration: InputDecoration(
                                      hintText: 'Enter your password',
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      GestureDetector(
                        onTap: () {
                          _login(context); // Call the login method
                        },
                        child: Container(
                          height: 50,
                          margin: EdgeInsets.symmetric(horizontal: 50),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.green[900],
                          ),
                          child: Center(
                            child: Text(
                              "Login",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          // Navigate to sign-up page
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignUp(),
                            ),
                          );
                        },
                        child: Text(
                          'Sign up',
                          style: TextStyle(
                            color: Colors.blueAccent[200],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
