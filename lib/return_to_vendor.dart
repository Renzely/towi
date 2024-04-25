// ignore_for_file: non_constant_identifier_names, unused_import, depend_on_referenced_packages, prefer_const_constructors, use_key_in_widget_constructors, camel_case_types
import 'dart:math';
import 'package:demo_app/Dashboard_Page.dart';
import 'package:demo_app/dbHelper/constant.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;
import 'package:mongo_dart/mongo_dart.dart' show ObjectId;

class ReturnVendor extends StatefulWidget {
  final String userName;
  final String userLastName;
  final String userEmail;

  ReturnVendor({
    required this.userName,
    required this.userLastName,
    required this.userEmail,
  });

  @override
  _ReturnVendorState createState() => _ReturnVendorState();
}

class _ReturnVendorState extends State<ReturnVendor> {
  late String selectedOutlet = ''; // Initialize with an empty string
  late String selectedItem = ''; // Initialize with an empty string
  late DateTime selectedDate = DateTime.now(); // Initialize with current date
  String merchandiserName = '';
  String driverName = '';
  String plateNumber = '';
  String pullOutReason = '';
  String selectedCategory = '';

  List<String> itemOptions = [];

  Map<String, List<String>> _categoryToSkuDescriptions = {
    'v1': [
      'KOPIKO COFFEE CANDY 24X175G',
      // Add more SKU descriptions...
    ],
    'v2': [
      'KOPIKO BLACK 3 IN ONE HANGER 24 X 10 X 30G',
      // Add more SKU descriptions...
    ],
    'v3': [
      'LE MINERALE 24x330ML',
      // Add more SKU descriptions...
    ],
  };
  List<String> outletOptions = [
    'PUREGOLD PRICE CLUB(JR.)- OLD CENTRO',
    'PUROGOLD PRICE CLUB(JR.)- PAM PLAZA',
    'PUREGOD PRICE CLUB - BAGUIO',
  ];
  @override
  void initState() {
    super.initState();
    selectedOutlet = outletOptions.isNotEmpty ? outletOptions.first : '';
    if (_categoryToSkuDescriptions.isNotEmpty) {
      selectedCategory = _categoryToSkuDescriptions.keys.first;
    }
    updateItemOptions(selectedCategory);
  }

  void updateItemOptions(String category) {
    setState(() {
      switch (category) {
        case 'v1':
          itemOptions = [
            'KOPIKO COFFEE CANDY 24X175G',
            'KOPIKO COFFEE CANDY JAR 6X560G',
            'KOPIKO CAPPUCCINO CANDY 24X175G',
            'FRES BARLEY MINT 24X50X3G',
            'FRES MINT BARLEY JAR 12X2003G',
            'FRES MINT BARLEY CANDY BIGPACK 6X1350G',
            'FRES CHERRY CANDY, 24 X 50 X 3G',
            'FRES CHERRY JAR, 12X 200 X 3G',
            'FRES MINT CHERRY CANDY BIGPACK 6X1350G',
            'FRES CANDY CANDY BIGPACK 24 X 50 X 3G',
            'FRES GRAPE JAR, 12 X 200 X 3G',
            'FRES APPLE PEACH 24 X 50 X 3G',
            'FRES APPLEPEACH CANDY BIGPACK 6X1350G',
            'FRES MIXED CANDY JAR 12 X 600G',
            'BENG BENG CHOCOLATE 12 X 10 X 26.5G',
            'BENG BENG SHARE IT 16 X 95G',
            'CAL CHEESE 10X20X8.5G',
            'CAL CHEESE 60X35G',
            'CAL CHEESE 60X53.5G',
            'CAL CHEESE CHEESE CHOCO 60X53.5G',
            'CAL CHEESE CHEESE CHOCO 60X35G',
            'MALKIST CHOCOLATE 30X10X24G',
            'ROMA CREAM CRACKERS',
            'WAFELLO CHOCOLATE WAFER 60X53.5G',
            'WAFELLO CHOCOLATE WAFER 60X35G',
            'WAFELLO BUTTER CARAMEL 60X35G',
            'WAFELLO COCO CREME 60X35G',
            'WAFELLO CREAMY VANILLA 20X10X20.5G PH',
            'VALMER CHOCOLATE 12X10X54G',
            'SUPERSTAR TRIPLE CHOCOLATE 12 X10 X 18G',
            'DANISA BUTTER COOKIES 12X454G',
          ];
          break;
        case 'v2':
          itemOptions = [
            'KOPIKO BLACK 3 IN ONE HANGER 24 X 10 X 30G',
            'KOPIKO BLACK 3 IN ONE POUCH 24 X 10 X 30G',
            'KOPIKO BLACK 3 IN ONE BAG 8 X 30 X 30G',
            'KOPIKO BLACK 3 IN ONE PROMO TWIN 12 X 10 X 2 X 30G',
            'KOPIKO BROWN COFFEE HG 27.5G 24 X 10 X 27.5G',
            'KOPIKO BROWN COFFEE POUCH 24 X 10 X 27.GG',
            'KOPIKO BROWN COFFEE BAG 8 X 30 X 27.5G',
            'KOPIKO BROWN PROMO TWIN 12 X 10 X 53G',
            'KOPIKO CAPPUCCINO HANGER 24 X 10 X 25G',
            'KOPIKO CAPPUCCINO POUCH 24 X 10 X 25G',
            'KOPIKO CAPPUCCINO BAG 8 X 30 X 25G',
            'KOPIKO L.A. COFFEE HANGER 24 X 10 X 25G',
            'KOPIKO L.A. COFFEE POUCH 24 X 10 X 25G',
            'KOPIKO BLANCA HANGER 24 X 10 X 25G',
            'KOPIKO BLANCA POUCH 24 X 10 X 30G',
            'KOPIKO BLANCA BAG 8 X 30 X 30G',
            'KOPIKO BLANCA TWINPACK 12 X 10 X 2 X 26G',
            'TORACAFE WHITE AND CREAMY 12 X (10 X 2) X 25G',
            'KOPIKO CREAMY CARAMELO 12 X (10 X 2) X 25G',
            'ENERGEN CHOCOLATE HANGER 24 X 10 X 40G',
            'ENERGEN CHOCOLATE POUCH 24 X 10 X 40G',
            'ENERGEN CHOCOLATE BAG 8 X 30 X 40G',
            'ENERGEN CHOCOLATE VANILLA HANGER 24 X 10 X 40G',
            'ENERGEN CHOCOLATE VANILLA POUCH 24 X 10 X 40G',
            'ENERGEN CHOCOLATE VANILLA BAG 8 X 30 X 40G',
            'ENERGEN CHAMPION NBA HANGER 24 X 10 X 35G',
            'ENERGEN PADESAL MATE 24 X 10 X 30G',
            'ENERGEN CHAMPION 12 X 10 X 2 X 35G PH',
            'KOPIKO CAFE MOCHA TP 12 X 10 X (2 X 25.5G) PH',
            'ENERGEN CHAMPION NBA TP 15 X 8 X 2 X 30G PH',
            'BLACK 420011 KOPIKO BLACK 3IN1 TWINPACK 12 X 10 X 2 X 28G',
          ];
          break;
        case 'v3':
          itemOptions = [
            'LE MINERALE 24x330ML',
            'LE MINERALE 24x600ML',
            'LE MINERALE 12x1500ML',
            'LE MINERALE 4 X 5000ML',
            'KOPIKO LUCKY DAY 24BTL X 180ML',
          ];
          break;
        default:
          itemOptions = [];
      }
      selectedItem = itemOptions.isNotEmpty ? itemOptions.first : '';
    });
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
                  'Date',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                SizedBox(height: 8),
                Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.black,
                        width: 1.0,
                      ),
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          decoration: InputDecoration(
                            enabled: false,
                            hintText:
                                DateFormat('yyyy-MM-dd').format(selectedDate),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'Merchandiser',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                TextFormField(
                  enabled: false,
                  initialValue: '${widget.userName} ${widget.userLastName}',
                  decoration: InputDecoration(
                    labelText: '',
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'Outlet',
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
                ),
                SizedBox(height: 16),
                Text(
                  'Category',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children:
                      _categoryToSkuDescriptions.keys.map((String category) {
                    return OutlinedButton(
                      onPressed: () => _toggleDropdown(category),
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(
                          width: 2.0,
                          color: selectedCategory == category
                              ? Colors.green
                              : Colors
                                  .transparent, // Highlight selected category
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      child: Text(category),
                    );
                  }).toList(),
                ),
                SizedBox(height: 16),
                Text(
                  'Item',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                SizedBox(height: 10),
                DropdownButtonFormField<String>(
                  value: selectedItem,
                  items: itemOptions.map((String item) {
                    return DropdownMenuItem<String>(
                      value: item,
                      child: SizedBox(
                        width: 350, // Adjust the width to fit your UI
                        child: Tooltip(
                          message:
                              item, // Display the full item name as tooltip
                          child: Text(
                            item,
                            overflow: TextOverflow
                                .ellipsis, // Truncate long item names
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      setState(() {
                        selectedItem = newValue;
                      });
                    }
                  },
                ),
                SizedBox(height: 16),
                Text(
                  'Driver\'s Name',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Input Driver\'s Name',
                  ),
                  onChanged: (value) {
                    setState(() {
                      driverName = value;
                    });
                  },
                ),
                SizedBox(height: 16),
                Text(
                  'Plate Number',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Input Plate Number',
                  ),
                  onChanged: (value) {
                    setState(() {
                      plateNumber = value;
                    });
                  },
                ),
                SizedBox(height: 16),
                Text(
                  'Pull Out Reason',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Input Pull Out Reason',
                  ),
                  onChanged: (value) {
                    setState(() {
                      pullOutReason = value;
                    });
                  },
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        bool confirmed = await showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Save Confirmation'),
                              content: Text(
                                  'Do you want to save this Return to Vendor?'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(
                                        false); // Return false if cancelled
                                  },
                                  child: Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pop(true); // Return true if confirmed
                                  },
                                  child: Text('Confirm'),
                                ),
                              ],
                            );
                          },
                        );

                        if (confirmed ?? false) {
                          _saveReturnToVendor();
                          // Navigate back to ReturnToVendor screen
                          Navigator.of(context).pop();
                        }
                      },
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                          const EdgeInsets.symmetric(vertical: 15),
                        ),
                        minimumSize: MaterialStateProperty.all<Size>(
                          const Size(150, 50),
                        ),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.green),
                      ),
                      child: const Text(
                        'Save',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
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
      updateItemOptions(selectedCategory);
    });
  }

  void _saveReturnToVendor() async {
    try {
      // Connect to the MongoDB database
      final db = await mongo.Db.create(INVENTORY_CONN_URL);
      await db.open();

      // Get the collection for return to vendor data
      final collection = db.collection(USER_RTV);

      // Generate a new ObjectId
      final objectId = ObjectId();

      // Construct the document to be inserted
      final document = {
        '_id': objectId,
        'userEmail': widget.userEmail,
        'date': DateFormat('yyyy-MM-dd').format(selectedDate),
        'merchandiserName': '${widget.userName} ${widget.userLastName}',
        'outlet': selectedOutlet,
        'category': selectedCategory,
        'item': selectedItem,
        'driverName': driverName.toString(),
        'plateNumber': plateNumber.toString(),
        'pullOutReason': pullOutReason.toString(),
      };

      // Insert the document into the collection
      await collection.insert(document);

      // Close the database connection
      await db.close();

      print('Return to Vendor data saved successfully!');
    } catch (e) {
      print('Error saving Return to Vendor data: $e');
      // Handle errors here
    }
  }
}
