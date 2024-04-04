import 'package:demo_app/dbHelper/constant.dart';
import 'package:flutter/material.dart';
import 'package:demo_app/Login_Page.dart'; // Import your LoginPage
import 'package:demo_app/dbHelper/mongodb.dart'; // Import MongoDatabase

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //final mongoDatabase = MongoDatabase(MONGO_CONN_URL);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        home: LoginPage(), // Set LoginPage as the initial route
        debugShowCheckedModeBanner: false,
      );
}
