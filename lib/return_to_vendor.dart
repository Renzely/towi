// ignore_for_file: non_constant_identifier_names, unused_import, depend_on_referenced_packages, prefer_const_constructors, use_key_in_widget_constructors, camel_case_types
import 'dart:math';
import 'package:demo_app/dbHelper/constant.dart';
import 'package:demo_app/dbHelper/mongodbDraft.dart';
import 'package:flutter/services.dart';
import 'package:demo_app/Dashboard_Page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:bson/bson.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;

class returnVendor extends StatefulWidget {
  final String userName;
  final String userLastName;
  final String userEmail;

  returnVendor(
      {required this.userName,
      required this.userLastName,
      required this.userEmail});

  @override
  _returnVendorState createState() => _returnVendorState();
}

class _returnVendorState extends State<returnVendor> {
  late String selectedOutlet = ''; // Initialize with an empty string
  late String selectedItem = ''; // Initialize with an empty string
  late DateTime selectedDate = DateTime.now(); // Initialize with current date
  String merchandiserName =
      ''; // Example value, replace with actual value if available
  String driversName = '';
  String plateNumber = '';
  String pullOutReason = '';
  String selectedCategory = '';

  List<String> outletOptions = ['Outlet 1', 'Outlet 2', 'Outlet 3'];
  List<String> itemOptions = ['Item 1', 'Item 2', 'Item 3'];

  @override
  void initState() {
    super.initState();
    selectedOutlet = outletOptions.isNotEmpty ? outletOptions.first : '';
    selectedItem = itemOptions.isNotEmpty ? itemOptions.first : '';
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green[600],
          elevation: 0,
          title: Text(
            'Return to Vendor',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => RTV(
                    userName: widget.userName,
                    userLastName: widget.userLastName,
                    userEmail: widget.userEmail,
                  ),
                ),
              );
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'DATE',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                SizedBox(height: 10),
                InkWell(
                  onTap: () {
                    showDatePicker(
                      context: context,
                      initialDate: selectedDate,
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                    ).then((value) {
                      if (value != null) {
                        setState(() {
                          selectedDate = value;
                        });
                      }
                    });
                  },
                  child: InputDecorator(
                    decoration: InputDecoration(
                      labelText: '',
                    ),
                    child: Text(
                      DateFormat('yyyy-MM-dd').format(selectedDate),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'MERCHANDISER',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                TextFormField(
                  initialValue: '${widget.userName} ${widget.userLastName}',
                  decoration: InputDecoration(
                    labelText: '',
                  ),
                  enabled: false, // Make it uneditable
                ),
                SizedBox(height: 16),
                Text(
                  'OUTLET',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                SizedBox(height: 10),
                DropdownButtonFormField(
                  value: selectedOutlet,
                  items: outletOptions.map((String outlet) {
                    return DropdownMenuItem(
                      value: outlet,
                      child: Text(outlet),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      setState(() {
                        selectedOutlet = newValue;
                      });
                    }
                  },
                  decoration: InputDecoration(
                    labelText: 'Outlet',
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'CATEGORY',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    OutlinedButton(
                      onPressed: () => _toggleDropdown('v1'),
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(width: 2.0, color: Colors.green),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      child: Text('v1'),
                    ),
                    OutlinedButton(
                      onPressed: () => _toggleDropdown('v2'),
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(width: 2.0, color: Colors.green),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      child: Text('v2'),
                    ),
                    OutlinedButton(
                      onPressed: () => _toggleDropdown('v3'),
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(width: 2.0, color: Colors.green),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      child: Text('v3'),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Text(
                  'ITEM',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                SizedBox(height: 10),
                DropdownButtonFormField(
                  value: selectedItem,
                  items: itemOptions.map((String item) {
                    return DropdownMenuItem(
                      value: item,
                      child: Text(item),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      setState(() {
                        selectedItem = newValue;
                      });
                    }
                  },
                  decoration: InputDecoration(
                    labelText: 'Item',
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'DRIVER\'S NAME',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Driver\'s Plate',
                  ),
                  onChanged: (value) {
                    setState(() {
                      plateNumber = value;
                    });
                  },
                ),
                SizedBox(height: 16),
                Text(
                  'PLATE NUMBER',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Plate Number',
                  ),
                  onChanged: (value) {
                    setState(() {
                      plateNumber = value;
                    });
                  },
                ),
                SizedBox(height: 16),
                Text(
                  'PULL OUT REASON',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Pull Out Reason',
                  ),
                  onChanged: (value) {
                    setState(() {
                      pullOutReason = value;
                    });
                  },
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    // Add functionality to save the data
                  },
                  child: Text('SAVE'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _toggleDropdown(String value) {
    setState(() {
      selectedCategory = value;
    });
  }
}
