// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:demo_app/login_screen.dart'; // Import your LoginPage
// Import MongoDatabase

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
