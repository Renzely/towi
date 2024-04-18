// ignore_for_file: prefer_final_fields, avoid_print, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, library_private_types_in_public_api, prefer_const_constructors, sort_child_properties_last, prefer_const_literals_to_create_immutables, depend_on_referenced_packages

import 'dart:math';
import 'package:demo_app/dbHelper/constant.dart';
import 'package:demo_app/dbHelper/mongodbDraft.dart';
import 'package:flutter/services.dart';
import 'package:demo_app/Dashboard_Page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:bson/bson.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;

class AddInventory extends StatefulWidget {
  final String userName;
  final String userLastName;
  final String userEmail;

  AddInventory({
    required this.userName,
    required this.userLastName,
    required this.userEmail,
  });

  @override
  _AddInventoryState createState() => _AddInventoryState();
}

class _AddInventoryState extends State<AddInventory> {
  late TextEditingController _dateController;
  late DateTime _selectedDate;
  String? _selectedAccount;
  String? _selectedPeriod;
  late GlobalKey<FormState> _formKey;
  bool _isSaveEnabled = false;
  bool _showAdditionalInfo = false;
  TextEditingController _monthController = TextEditingController();
  TextEditingController _weekController = TextEditingController();
  String _selectedWeek = '';
  String _selectedMonth = '';

  Map<String, String> accountNameMap = {
    '1': 'PUREGOLD PRICE CLUB(JR.)- OLD CENTRO',
    '2': 'PUROGOLD PRICE CLUB(JR.)- PAM PLAZA',
    '3': 'PUREGOD PRICE CLUB - BAGUIO',
  };

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    _selectedDate =
        DateTime.now(); // Initialize _selectedDate to the current date
    _dateController = TextEditingController(
      text: DateFormat('yyyy-MM-dd')
          .format(_selectedDate), // Set initial text of controller
    );
    _weekController.addListener(() {
      setState(() {
        _selectedWeek = _weekController.text;
      });
    });
    _monthController.addListener(() {
      setState(() {
        _selectedMonth = _monthController.text;
      });
    });
  }

  @override
  void dispose() {
    _dateController.dispose();
    _monthController.dispose();
    _weekController.dispose();
    super.dispose();
  }

  String generateInputID() {
    var timestamp = DateTime.now().millisecondsSinceEpoch;
    var random = Random().nextInt(9999);
    return 'TOWI$timestamp$random';
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
            'Inventory Form',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => Inventory(
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
          child: Center(
            child: Container(
              padding: EdgeInsets.all(20.0),
              width: MediaQuery.of(context).size.width * 1.0,
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Date',
                      style: TextStyle(fontWeight: FontWeight.bold),
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
                              controller: _dateController,
                              readOnly: true,
                              decoration: InputDecoration(
                                enabled: false,
                                hintText: 'Select Date',
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.calendar_today),
                            onPressed: () {
                              _selectDate(context);
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Input ID',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    TextFormField(
                      initialValue: generateInputID(),
                      enabled: false,
                      decoration: InputDecoration(
                        hintText: 'Auto-generated Input ID',
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Name',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    TextFormField(
                      initialValue: '${widget.userName} ${widget.userLastName}',
                      enabled: false,
                      decoration: InputDecoration(),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Account Name Branch Manning',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
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
                            child: Stack(
                              alignment: Alignment.centerRight,
                              children: [
                                DropdownButtonFormField<String>(
                                  value: _selectedAccount,
                                  items: [
                                    DropdownMenuItem(
                                      child: Text(
                                          'PUREGOLD PRICE CLUB(JR.)- OLD CENTRO'),
                                      value: '1',
                                    ),
                                    DropdownMenuItem(
                                      child: Text(
                                          'PUROGOLD PRICE CLUB(JR.)- PAM PLAZA'),
                                      value: '2',
                                    ),
                                    DropdownMenuItem(
                                      child:
                                          Text('PUREGOD PRICE CLUB - BAGUIO'),
                                      value: '3',
                                    ),
                                  ],
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedAccount = value;
                                      _isSaveEnabled =
                                          _selectedAccount != null &&
                                              _selectedPeriod != null;
                                    });
                                  },
                                  decoration: InputDecoration(
                                    hintText: 'Select',
                                    border: InputBorder.none,
                                  ),
                                ),
                                if (_selectedAccount != null)
                                  Positioned(
                                    right: 8.0,
                                    child: IconButton(
                                      icon: Icon(Icons.clear),
                                      onPressed: () {
                                        setState(() {
                                          _selectedAccount = null;
                                          _selectedPeriod = null;
                                          _showAdditionalInfo = false;
                                          _isSaveEnabled = false;
                                        });
                                      },
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (_selectedAccount != null) ...[
                      SizedBox(height: 16),
                      Text(
                        'Additional Information',
                      ),
                      SizedBox(height: 8),
                      Text(
                        'PERIOD',
                        style: TextStyle(fontWeight: FontWeight.bold),
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
                              child: Stack(
                                alignment: Alignment.centerRight,
                                children: [
                                  DropdownButtonFormField<String>(
                                    value: _selectedPeriod,
                                    items: [
                                      DropdownMenuItem(
                                        child: Text('Dec23-Dec29'),
                                        value: '1',
                                      ),
                                      DropdownMenuItem(
                                        child: Text('Dec30-Jan05'),
                                        value: '2',
                                      ),
                                      DropdownMenuItem(
                                        child: Text('Jan06-Jan12'),
                                        value: '3',
                                      ),
                                      DropdownMenuItem(
                                        child: Text('Jan13-Jan19'),
                                        value: '4',
                                      ),
                                      DropdownMenuItem(
                                        child: Text('Jan20-Jan26'),
                                        value: '5',
                                      ),
                                      DropdownMenuItem(
                                        child: Text('Jan27-Feb02'),
                                        value: '6',
                                      ),
                                      DropdownMenuItem(
                                        child: Text('Feb03-Feb09'),
                                        value: '7',
                                      ),
                                      DropdownMenuItem(
                                        child: Text('Feb10-Feb09'),
                                        value: '8',
                                      ),
                                      DropdownMenuItem(
                                        child: Text('Feb17-Feb23'),
                                        value: '9',
                                      ),
                                      DropdownMenuItem(
                                        child: Text('Feb24-Mar01'),
                                        value: '10',
                                      ),
                                    ],
                                    onChanged: (value) {
                                      setState(() {
                                        _selectedPeriod = value;
                                        _isSaveEnabled =
                                            _selectedAccount != null &&
                                                _selectedPeriod != null;
                                        switch (value) {
                                          case '1':
                                            _monthController.text = 'December';
                                            _weekController.text = 'Week 52';
                                            _showAdditionalInfo = true;
                                            break;
                                          case '2':
                                            _monthController.text = 'January';
                                            _weekController.text = 'Week 1';
                                            _showAdditionalInfo = true;
                                            break;
                                          case '3':
                                            _monthController.text = 'January';
                                            _weekController.text = 'Week 2';
                                            _showAdditionalInfo = true;
                                            break;
                                          case '4':
                                            _monthController.text = 'January';
                                            _weekController.text = 'Week 3';
                                            _showAdditionalInfo = true;
                                            break;
                                          case '5':
                                            _monthController.text = 'January';
                                            _weekController.text = 'Week 4';
                                            _showAdditionalInfo = true;
                                            break;
                                          case '6':
                                            _monthController.text = 'February';
                                            _weekController.text = 'Week 5';
                                            _showAdditionalInfo = true;
                                            break;
                                          case '7':
                                            _monthController.text = 'February';
                                            _weekController.text = 'Week 6';
                                            _showAdditionalInfo = true;
                                            break;
                                          case '8':
                                            _monthController.text = 'February';
                                            _weekController.text = 'Week 7';
                                            _showAdditionalInfo = true;
                                            break;
                                          case '9':
                                            _monthController.text = 'February';
                                            _weekController.text = 'Week 8';
                                            _showAdditionalInfo = true;
                                            break;
                                          case '10':
                                            _monthController.text = 'March';
                                            _weekController.text = 'Week 9';
                                            _showAdditionalInfo = true;
                                            break;
                                          default:
                                            _monthController.clear();
                                            _weekController.clear();
                                            _showAdditionalInfo = false;
                                            break;
                                        }
                                      });
                                    },
                                    decoration: InputDecoration(
                                      hintText: 'Select Period',
                                      border: InputBorder.none,
                                    ),
                                  ),
                                  if (_selectedPeriod != null)
                                    Positioned(
                                      right: 8.0,
                                      child: IconButton(
                                        icon: Icon(Icons.clear),
                                        onPressed: () {
                                          setState(() {
                                            _selectedPeriod = null;
                                            _showAdditionalInfo = false;
                                            _isSaveEnabled = false;
                                          });
                                        },
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (_showAdditionalInfo) ...[
                        SizedBox(height: 16),
                        Text('Month',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        SizedBox(height: 8),
                        TextFormField(
                          controller: _monthController,
                          decoration: InputDecoration(
                            enabled: false,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Week',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextFormField(
                          controller: _weekController,
                          decoration: InputDecoration(
                            enabled: false,
                          ),
                        ),
                      ],
                    ],
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: _isSaveEnabled
                              ? () {
                                  // Perform cancel action
                                }
                              : null,
                          style: ButtonStyle(
                            padding:
                                MaterialStateProperty.all<EdgeInsetsGeometry>(
                              const EdgeInsets.symmetric(vertical: 15),
                            ),
                            minimumSize: MaterialStateProperty.all<Size>(
                              const Size(150, 50),
                            ),
                            backgroundColor: _isSaveEnabled
                                ? MaterialStateProperty.all<Color>(Colors.green)
                                : MaterialStateProperty.all<Color>(Colors.grey),
                          ),
                          child: const Text(
                            'Cancel',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: _isSaveEnabled
                              ? () {
                                  Navigator.of(context)
                                      .pushReplacement(MaterialPageRoute(
                                          builder: (context) => SKUInventory(
                                                userName: widget.userName,
                                                userLastName:
                                                    widget.userLastName,
                                                userEmail: widget.userEmail,
                                                selectedAccount: accountNameMap[
                                                    _selectedAccount],
                                                selectedWeek: _selectedWeek,
                                                selectedMonth: _selectedMonth,
                                              )));
                                }
                              : null,
                          style: ButtonStyle(
                            padding:
                                MaterialStateProperty.all<EdgeInsetsGeometry>(
                              const EdgeInsets.symmetric(vertical: 15),
                            ),
                            minimumSize: MaterialStateProperty.all<Size>(
                              const Size(150, 50),
                            ),
                            backgroundColor: _isSaveEnabled
                                ? MaterialStateProperty.all<Color>(Colors.green)
                                : MaterialStateProperty.all<Color>(Colors.grey),
                          ),
                          child: const Text(
                            'Proceed',
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
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
        _dateController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
      });
    }
  }
}

class SKUInventory extends StatefulWidget {
  final String userName;
  final String userLastName;
  final String userEmail;
  final String? selectedAccount;
  final String selectedWeek;
  final String selectedMonth;

  SKUInventory({
    required this.userName,
    required this.userLastName,
    required this.userEmail,
    this.selectedAccount,
    required this.selectedWeek,
    required this.selectedMonth,
  });

  @override
  _SKUInventoryState createState() => _SKUInventoryState();
}

class _SKUInventoryState extends State<SKUInventory> {
  bool _isDropdownVisible = false;
  String? _selectedDropdownValue;
  String? _productDetails;
  String? _skuCode;
  String? _versionSelected;
  String? _statusSelected;
  int? _selectedNumberOfDaysOOS;
  bool _showCarriedTextField = false;
  bool _showNotCarriedTextField = false;
  bool _showDelistedTextField = false;
  TextEditingController _beginningController = TextEditingController();
  TextEditingController _deliveryController = TextEditingController();
  TextEditingController _endingController = TextEditingController();
  TextEditingController _offtakeController = TextEditingController();
  TextEditingController _inventoryDaysLevelController = TextEditingController();
  TextEditingController _inputIdController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _accountNameController = TextEditingController();
  TextEditingController _periodController = TextEditingController();
  TextEditingController _skuDescriptionController = TextEditingController();
  TextEditingController _productsController = TextEditingController();
  TextEditingController _skuCodeController = TextEditingController();

  void _saveInventoryItem() {
    // Ensure _versionSelected, _statusSelected, and _selectedNumberOfDaysOOS are initialized properly
    String version = _versionSelected ?? '';
    String status = _statusSelected ?? ''; // Ensure _statusSelected is not null
    int numberOfDaysOOS = _selectedNumberOfDaysOOS ?? 0;

    // Parse the numeric fields from text controllers
    int beginning = int.tryParse(_beginningController.text) ?? 0;
    int delivery = int.tryParse(_deliveryController.text) ?? 0;
    int ending = int.tryParse(_endingController.text) ?? 0;

    // Compute offtake
    int offtake = beginning + delivery - ending;

    // Initialize inventoryDaysLevel to zero
    double inventoryDaysLevel = 0;

    // Check if status is "Not Carried" or "Delisted"
    if (status != "Not Carried" && status != "Delisted") {
      // Compute inventoryDaysLevel only if status is not "Not Carried" or "Delisted"
      if (offtake != 0 && ending != double.infinity && !ending.isNaN) {
        inventoryDaysLevel = ending / (offtake / 7);
      }
    }

    // Create a new InventoryItem from form inputs
    InventoryItem newItem = InventoryItem(
      id: ObjectId(), // You might want to generate this based on your DB setup
      date: DateTime.now().toString(), // Assuming current date for simplicity
      inputId: _inputIdController.text,
      name: _nameController.text,
      accountNameBranchManning: _accountNameController.text,
      period: _periodController.text,
      month: widget.selectedMonth,
      week: widget.selectedWeek,
      version: version,
      skuDescription: _skuDescriptionController.text,
      products: _productsController.text,
      skuCode: _skuCodeController.text,
      status: status,
      beginning: beginning,
      delivery: delivery,
      ending: ending,
      offtake: offtake,
      inventoryDaysLevel: inventoryDaysLevel.toInt(),
      noOfDaysOOS: numberOfDaysOOS,
    );

    // Save the new inventory item to the database
    _saveToDatabase(newItem);
  }

  Future<void> _saveToDatabase(InventoryItem item) async {
    try {
      // Connect to your MongoDB database
      final db = await mongo.Db.create(INVENTORY_CONN_URL);
      await db.open();

      // Get a reference to the collection where you want to save items
      final collection = db.collection(USER_INVENTORY);

      // Convert the InventoryItem to a Map using the toJson() method
      final Map<String, dynamic> itemMap = item.toJson();

      // Insert the item into the collection
      await collection.insert(itemMap);

      // Close the database connection when done
      await db.close();

      print('Inventory item saved to database');
    } catch (e) {
      // Handle any errors that occur during saving
      print('Error saving inventory item: $e');
    }
  }

  Map<String, List<String>> _categoryToSkuDescriptions = {
    'v1': [
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
      'WAFELLO BUTTER CARAMEL 60X53.5G',
      'WAFELLO COCO CREME 60X53.5G',
      'WAFELLO CREAMY VANILLA 60X48G PH',
      'WAFELLO CHOCOLATE 48G X 60',
      'WAFELLO CHOCOLATE 21G X 10 X 20',
      'WAFELLO BUTTER CARAMEL 48G X 60',
      'WAFELLO BUTTER CARAMEL 20.5G X 10 X 20',
      'WAFELLO COCO CRÈME 48G X 60',
      'WAFELLO COCONUT CRÈME 20.5G X 10 X 20',
      'CAL CHEESE 60 X 48G',
      'CAL CHEESE 20 X 10 X 20G',
      'CAL CHEESE 20 X 20 X 8.5G',
      'CAL CHEESE CHOCO 60 X 48G',
      'CAL CHEESE CHOCO 20 X 10 X 20.5G',
      'VALMER SANDWICH CHOCOLATE 12X10X36G',
      'MALKIST CAPPUCCINO 30X10X23G PH',
    ],
    'v2': [
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
      'ENERGEN CHAMPION 12 X 10 X 2 X 35G PH'
          'KOPIKO CAFE MOCHA TP 12 X 10 X (2 X 25.5G) PH'
          'ENERGEN CHAMPION NBA TP 15 X 8 X 2 X 30G PH',
      'BLACK 420011 KOPIKO BLACK 3IN1 TWINPACK 12 X 10 X 2 X 28G',
    ],
    'v3': [
      'LE MINERALE 24x330ML',
      'LE MINERALE 24x600ML',
      'LE MINERALE 12x1500ML',
      'LE MINERALE 4 X 5000ML',
      'KOPIKO LUCKY DAY 24BTL X 180ML'
    ],
  };

  Map<String, Map<String, String>> _skuToProductSkuCode = {
    //CATEGORY V1

    'KOPIKO COFFEE CANDY 24X175G': {
      'Product': 'COFFEE SHOT',
      'SKU Code': '326924'
    },
    'KOPIKO COFFEE CANDY JAR 6X560G': {
      'Product': 'COFFEE SHOT',
      'SKU Code': '326926'
    },
    'KOPIKO CAPPUCCINO CANDY 24X175G': {
      'Product': 'COFFEE SHOT',
      'SKU Code': '326925'
    },
    'FRES BARLEY MINT 24X50X3G': {'Product': 'FRES', 'SKU Code': '326446'},
    'FRES MINT BARLEY JAR 12X2003G': {'Product': 'FRES', 'SKU Code': '329136'},
    'FRES MINT BARLEY CANDY BIGPACK 6X1350G': {
      'Product': 'FRES',
      'SKU Code': ''
    },
    'FRES CHERRY CANDY, 24 X 50 X 3G': {
      'Product': 'FRES',
      'SKU Code': '326447'
    },
    'FRES CHERRY JAR, 12X 200 X 3G': {'Product': 'FRES', 'SKU Code': '329135'},
    'FRES MINT CHERRY CANDY BIGPACK 6X1350G': {
      'Product': 'FRES',
      'SKU Code': ''
    },

    //LATEST

    'FRES CANDY CANDY BIGPACK 24 X 50 X 3G': {
      'Product': 'FRES',
      'SKU Code': '326448'
    },
    'FRES GRAPE JAR, 12 X 200 X 3G': {'Product': 'FRES', 'SKU Code': '329137'},
    'FRES APPLE PEACH 24 X 50 X 3G': {'Product': 'FRES', 'SKU Code': '329545'},
    'FRES APPLEPEACH CANDY BIGPACK 6X1350G': {
      'Product': 'FRES',
      'SKU Code': ''
    },
    'FRES MIXED CANDY JAR 12 X 600G': {'Product': 'FRES', 'SKU Code': '320015'},
    'BENG BENG CHOCOLATE 12 X 10 X 26.5G': {
      'Product': 'BENG BENG',
      'SKU Code': '329067'
    },
    'BENG BENG SHARE IT 16 X 95G': {
      'Product': 'BENG BENG',
      'SKU Code': '322583'
    },
    'CAL CHEESE 10X20X8.5G': {'Product': 'CAL CHEESE', 'SKU Code': '329809'},
    'CAL CHEESE 60X35G': {'Product': 'CAL CHEESE', 'SKU Code': '322571'},
    'CAL CHEESE 60X53.5G': {'Product': 'CAL CHEESE', 'SKU Code': '329808'},
    'CAL CHEESE CHEESE CHOCO 60X53.5G': {
      'Product': 'CAL CHEESE',
      'SKU Code': '322866'
    },
    'CAL CHEESE CHEESE CHOCO 60X35G': {
      'Product': 'CAL CHEESE',
      'SKU Code': '322867'
    },
    'MALKIST CHOCOLATE 30X10X24G': {'Product': 'MALKIST', 'SKU Code': '321036'},
    'ROMA CREAM CRACKERS': {'Product': 'ROMA', 'SKU Code': ''},
    'WAFELLO CHOCOLATE WAFER 60X53.5G': {
      'Product': 'WAFELLO',
      'SKU Code': '330016'
    },
    'WAFELLO CHOCOLATE WAFER 60X35G': {
      'Product': 'WAFELLO',
      'SKU Code': '330025'
    },
    'WAFELLO BUTTER CARAMEL 60X35G': {
      'Product': 'WAFELLO',
      'SKU Code': '322871'
    },
    'WAFELLO COCO CREME 60X35G': {'Product': 'WAFELLO', 'SKU Code': '322868'},
    'WAFELLO CREAMY VANILLA 20X10X20.5G PH': {
      'Product': 'WAFELLO',
      'SKU Code': '330073'
    },
    'VALMER CHOCOLATE 12X10X54G': {'Product': 'VALMER', 'SKU Code': '321038'},
    'SUPERSTAR TRIPLE CHOCOLATE 12 X10 X 18G': {
      'Product': 'SUPERSTAR',
      'SKU Code': '322894'
    },
    'DANISA BUTTER COOKIES 12X454G': {
      'Product': 'DANISA',
      'SKU Code': '329650'
    },
    'WAFELLO BUTTER CARAMEL 60X53.5G': {
      'Product': 'WAFELLO',
      'SKU Code': '322870'
    },
    'WAFELLO COCO CREME 60X53.5G': {'Product': 'WAFELLO', 'SKU Code': '322869'},
    'WAFELLO CREAMY VANILLA 60X48G PH': {
      'Product': 'WAFELLO',
      'SKU Code': '330060'
    },
    'WAFELLO CHOCOLATE 48G X 60': {'Product': 'WAFELLO', 'SKU Code': '330050'},
    'WAFELLO CHOCOLATE 21G X 10 X 20': {
      'Product': 'WAFELLO',
      'SKU Code': '330051'
    },
    'WAFELLO BUTTER CARAMEL 48G X 60': {
      'Product': 'WAFELLO',
      'SKU Code': '330056'
    },
    'WAFELLO BUTTER CARAMEL 20.5G X 10 X 20': {
      'Product': 'WAFELLO',
      'SKU Code': '330057'
    },
    'WAFELLO COCO CRÈME 48G X 60': {'Product': 'WAFELLO', 'SKU Code': '330058'},

    'WAFELLO COCONUT CRÈME 20.5G X 10 X 20': {
      'Product': 'WAFELLO',
      'SKU Code': '330059'
    },
    'CAL CHEESE 60 X 48G': {'Product': 'CAL CHEESE', 'SKU Code': '330052'},

    'CAL CHEESE 20 X 10 X 20G': {'Product': 'CAL CHEESE', 'SKU Code': '330053'},

    'CAL CHEESE 20 X 20 X 8.5G': {
      'Product': 'CAL CHEESE',
      'SKU Code': '330071'
    },
    'CAL CHEESE CHOCO 60 X 48G': {
      'Product': 'CAL CHEESE',
      'SKU Code': '330054'
    },
    'CAL CHEESE CHOCO 20 X 10 X 20.5G': {
      'Product': 'CAL CHEESE',
      'SKU Code': '330055'
    },
    'VALMER SANDWICH CHOCOLATE 12X10X36G': {
      'Product': 'VALMER',
      'SKU Code': '321475'
    },
    'MALKIST CAPPUCCINO 30X10X23G PH': {
      'Product': 'MALKIST',
      'SKU Code': '321446'
    },

    //CATEGORY V2

    'KOPIKO BLACK 3 IN ONE HANGER 24 X 10 X 30G': {
      'Product': 'BLACK',
      'SKU Code': '322628'
    },
    'KOPIKO BLACK 3 IN ONE POUCH 24 X 10 X 30G': {
      'Product': 'BLACK',
      'SKU Code': '322630'
    },
    'KOPIKO BLACK 3 IN ONE BAG 8 X 30 X 30G': {
      'Product': 'BLACK',
      'SKU Code': '322629'
    },
    'KOPIKO BLACK 3 IN ONE PROMO TWIN 12 X 10 X 2 X 30G': {
      'Product': 'BLACK',
      'SKU Code': '322627'
    },

    'KOPIKO BROWN COFFEE HG 27.5G 24 X 10 X 27.5G': {
      'Product': 'BROWN',
      'SKU Code': '328890'
    },
    'KOPIKO BROWN COFFEE POUCH 24 X 10 X 27.GG': {
      'Product': 'BROWN',
      'SKU Code': '329958'
    },
    'KOPIKO BROWN COFFEE BAG 8 X 30 X 27.5G': {
      'Product': 'BROWN',
      'SKU Code': '329959'
    },
    'KOPIKO BROWN PROMO TWIN 12 X 10 X 53G': {
      'Product': 'BROWN',
      'SKU Code': '329940'
    },

    'KOPIKO CAPPUCCINO HANGER 24 X 10 X 25G': {
      'Product': 'CAPPUCCINO',
      'SKU Code': '329701'
    },
    'KOPIKO CAPPUCCINO POUCH 24 X 10 X 25G': {
      'Product': 'CAPPUCCINO',
      'SKU Code': '329703'
    },
    'KOPIKO CAPPUCCINO BAG 8 X 30 X 25G': {
      'Product': 'CAPPUCCINO',
      'SKU Code': '329704'
    },

    'KOPIKO L.A. COFFEE HANGER 24 X 10 X 25G': {
      'Product': 'L.A.',
      'SKU Code': '325666'
    },
    'KOPIKO L.A. COFFEE POUCH 24 X 10 X 25G': {
      'Product': 'L.A.',
      'SKU Code': '325667'
    },

    'KOPIKO BLANCA HANGER 24 X 10 X 30G': {
      'Product': 'BLANCA',
      'SKU Code': '328888'
    },
    'KOPIKO BLANCA POUCH 24 X 10 X 30G': {
      'Product': 'BLANCA',
      'SKU Code': '328887'
    },
    'KOPIKO BLANCA BAG 8 X 30 X 30G': {
      'Product': 'BLANCA',
      'SKU Code': '328889'
    },
    'KOPIKO BLANCA TWINPACK 12 X 10 X 2 X 29G': {
      'Product': 'BLANCA',
      'SKU Code': '322711'
    },
    'TORACAFE WHITE AND CREAMY 12 X (10 X 2) X 26G': {
      'Product': 'TORA',
      'SKU Code': '322731'
    },
    'KOPIKO CREAMY CARAMELO 12 X (10 X 2) X 25G': {
      'Product': 'CARAMELO',
      'SKU Code': '322725'
    },
    'KOPIKO DOUBLE CUPS 24 X 10 X 36G': {
      'Product': 'DOUBLE CUPS',
      'SKU Code': '329744'
    },
    'ENERGEN CHOCOLATE HANGER 24 X 10 X 40G': {
      'Product': 'ENERGEN',
      'SKU Code': '328497'
    },
    'ENERGEN CHOCOLATE POUCH 24 X 10 X 40G': {
      'Product': 'ENERGEN',
      'SKU Code': '328492'
    },
    'ENERGEN CHOCOLATE BAG 8 X 30 X 40G': {
      'Product': 'ENERGEN',
      'SKU Code': '328493'
    },
    'ENERGEN CHOCOLATE VANILLA HANGER 24 X 10 X 40G': {
      'Product': 'ENERGEN',
      'SKU Code': '328494'
    },
    'ENERGEN CHOCOLATE VANILLA POUCH 24 X 10 X 40G': {
      'Product': 'ENERGEN',
      'SKU Code': '328495'
    },
    'ENERGEN CHOCOLATE VANILLA BAG 8 X 30 X 40G': {
      'Product': 'ENERGEN',
      'SKU Code': '328496'
    },
    'ENERGEN CHAMPION NBA HANGER 24 X 10 X 35G': {
      'Product': 'CHAMPION',
      'SKU Code': '325945'
    },
    'ENERGEN PADESAL MATE 24 X 10 X 30G': {
      'Product': 'EPM',
      'SKU Code': '325920'
    },
    'ENERGEN CHAMPION 12 X 10 X 2 X 35G PH': {
      'Product': 'CHAMPION',
      'SKU Code': '325944'
    },
    'KOPIKO CAFE MOCHA TP 12 X 10 X (2 X 25.5G) PH': {
      'Product': 'CAFÉ MOCHA',
      'SKU Code': '324149'
    },
    'ENERGEN CHAMPION NBA TP 15 X 8 X 2 X 30G PH': {
      'Product': 'CHAMPION',
      'SKU Code': '325965'
    },
    'BLACK 420011 KOPIKO BLACK 3IN1 TWINPACK 12 X 10 X 2 X 28G': {
      'Product': 'BLACK',
      'SKU Code': '420011'
    },

    //CATEGORY V3

    'LE MINERALE 24x330ML': {'Product': 'WATER', 'SKU Code': '328566'},
    'LE MINERALE 24x600ML': {'Product': 'WATER', 'SKU Code': '328565'},
    'LE MINERALE 12x1500ML': {'Product': 'WATER', 'SKU Code': '326770'},
    'LE MINERALE 4 X 5000ML': {'Product': 'WATER', 'SKU Code': '324045'},
    'KOPIKO LUCKY DAY 24BTL X 180ML': {'Product': 'KLD', 'SKU Code': '324046'},
  };

  void _toggleDropdown(String version) {
    setState(() {
      _versionSelected = version;
      _isDropdownVisible = !_isDropdownVisible;
      _selectedDropdownValue = null;
      _productDetails = null;
      _skuCode = null;
      // Hide buttons when a category is deselected
      _showCarriedTextField = false;
      _showNotCarriedTextField = false;
      _showDelistedTextField = false;
    });
  }

  void _selectSKU(String? newValue) {
    setState(() {
      _selectedDropdownValue = newValue;
      _productDetails = _skuToProductSkuCode[newValue!]!['Product'];
      _skuCode = _skuToProductSkuCode[newValue]!['SKU Code'];
    });
  }

  void _toggleCarriedTextField(String status) {
    setState(() {
      _statusSelected = status;
      _showCarriedTextField = true;
      _showNotCarriedTextField = false;
      _showDelistedTextField = false;
      _beginningController.clear();
      _deliveryController.clear();
      _endingController.clear();
      _offtakeController.clear();
    });
  }

  void _toggleNotCarriedTextField(String status) {
    setState(() {
      _statusSelected = status;
      _showCarriedTextField = false;
      _showNotCarriedTextField = true;
      _showDelistedTextField = false;
      _beginningController.clear();
      _deliveryController.clear();
      _endingController.clear();
      _offtakeController.clear();
    });
  }

  void _toggleDelistedTextField(String status) {
    setState(() {
      _statusSelected = status;
      _showCarriedTextField = false;
      _showNotCarriedTextField = false;
      _showDelistedTextField = true;
      _beginningController.clear();
      _deliveryController.clear();
      _endingController.clear();
      _offtakeController.clear();
    });
  }

  @override
  void initState() {
    super.initState();
    _beginningController.addListener(_calculateOfftake);
    _deliveryController.addListener(_calculateOfftake);
    _endingController.addListener(_calculateOfftake);
    _offtakeController.addListener(_calculateInventoryDaysLevel);
  }

  @override
  void dispose() {
    _beginningController.dispose();
    _deliveryController.dispose();
    _endingController.dispose();
    _offtakeController.dispose();
    _inventoryDaysLevelController.dispose();
    super.dispose();
  }

  void _calculateOfftake() {
    double beginning = double.tryParse(_beginningController.text) ?? 0;
    double delivery = double.tryParse(_deliveryController.text) ?? 0;
    double ending = double.tryParse(_endingController.text) ?? 0;
    double offtake = beginning + delivery - ending;
    _offtakeController.text = offtake.toStringAsFixed(2);
  }

  void _calculateInventoryDaysLevel() {
    double ending = double.tryParse(_endingController.text) ?? 0;
    double offtake = double.tryParse(_offtakeController.text) ?? 0;
    double inventoryDaysLevel = ending / (offtake / 7);
    _inventoryDaysLevelController.text = inventoryDaysLevel.toStringAsFixed(2);
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
            'Inventory Form',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SingleChildScrollView(
            // Wrap with SingleChildScrollView
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Week Number',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextField(
                  controller: _accountNameController,
                  decoration: InputDecoration(
                    enabled: false,
                    hintText: widget.selectedWeek,
                  ),
                ),
                // DEMO MONTH
                Text(
                  'Month',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextField(
                  controller: _accountNameController,
                  decoration: InputDecoration(
                    enabled: false,
                    hintText: widget.selectedMonth,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Account Branch Name',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextField(
                  controller: _accountNameController,
                  decoration: InputDecoration(
                      enabled: false, hintText: widget.selectedAccount),
                ),
                SizedBox(height: 20),
                Text(
                  'Category',
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
                // Add text fields where user input is expected, and assign controllers
                if (_isDropdownVisible && _versionSelected != null)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Text(
                          'SKU Description',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16, // Adjust as needed
                          ),
                        ),
                      ),
                      _buildDropdown(
                        '',
                        _selectSKU,
                        _categoryToSkuDescriptions[_versionSelected]!,
                      ),
                      if (_productDetails != null) ...[
                        SizedBox(height: 10),
                        Text(
                          'PRODUCTS',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextField(
                          enabled: false,
                          controller:
                              _productsController, // Assigning controller
                          decoration: InputDecoration(
                            hintText: _productDetails,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'SKU CODE',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextField(
                          enabled: false,
                          controller:
                              _skuCodeController, // Assigning controller
                          decoration: InputDecoration(
                            hintText: _skuCode,
                          ),
                        ),
                      ],
                    ],
                  ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    if (_versionSelected != null)
                      OutlinedButton(
                        onPressed: () => _toggleCarriedTextField(
                            'Carried'), // Pass 'Carried' as the status
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(width: 2.0, color: Colors.green),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        child: Text('Carried'),
                      ),
                    if (_versionSelected != null)
                      OutlinedButton(
                        onPressed: () => _toggleNotCarriedTextField(
                            'Not Carried'), // Pass 'Not Carried' as the status
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(width: 2.0, color: Colors.green),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        child: Text('Not Carried'),
                      ),
                    if (_versionSelected != null)
                      OutlinedButton(
                        onPressed: () => _toggleDelistedTextField(
                            'Delisted'), // Pass 'Delisted' as the status
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(width: 2.0, color: Colors.green),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        child: Text('Delisted'),
                      ),
                  ],
                ),

                if (_showCarriedTextField)
                  TextField(
                    controller: _beginningController,
                    keyboardType:
                        TextInputType.number, // Set keyboardType to number
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly
                    ], // Allow only digits
                    decoration: InputDecoration(
                      labelText: 'Beginning',
                      labelStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                if (_showCarriedTextField)
                  TextField(
                    controller: _deliveryController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: InputDecoration(
                      labelText: 'Delivery',
                      labelStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                if (_showCarriedTextField)
                  TextField(
                    controller: _endingController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: InputDecoration(
                      labelText: 'Ending',
                      labelStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                if (_showCarriedTextField)
                  TextField(
                    controller: _offtakeController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: InputDecoration(
                      enabled: false,
                      labelText: 'Offtake',
                      labelStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                if (_showCarriedTextField)
                  TextField(
                    controller: _inventoryDaysLevelController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: InputDecoration(
                      enabled: false,
                      labelText: 'Inventory days Level',
                      labelStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                if (_showCarriedTextField)
                  if (_showCarriedTextField)
                    DropdownButtonFormField<int>(
                      decoration: InputDecoration(
                        labelText: 'No. of Days OOS',
                        labelStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14, // Adjust size as needed
                        ),
                      ),
                      value: _selectedNumberOfDaysOOS,
                      onChanged: (newValue) {
                        setState(() {
                          _selectedNumberOfDaysOOS = newValue;
                        });
                      },
                      items: List.generate(8, (index) {
                        return DropdownMenuItem<int>(
                          value: index,
                          child: Text(index.toString()),
                        );
                      }),
                    ),
                // if (_showNotCarriedTextField)
                //   TextField(
                //     decoration: InputDecoration(
                //       labelText: 'Beginning',
                //       labelStyle: TextStyle(
                //         fontWeight: FontWeight.bold,
                //         fontSize: 14, // Adjust size as needed
                //       ),
                //     ),
                //   ),
                // if (_showDelistedTextField)
                //   TextField(
                //     decoration: InputDecoration(
                //       labelText: 'Beginning',
                //       labelStyle: TextStyle(
                //         fontWeight: FontWeight.bold,
                //         fontSize: 14, // Adjust size as needed
                //       ),
                //     ),
                //   ),
                SizedBox(height: 20),
                if (_showCarriedTextField ||
                    _showNotCarriedTextField ||
                    _showDelistedTextField)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context)
                              .pop(); // Navigate back to previous screen
                        },
                        style: ButtonStyle(
                          padding:
                              MaterialStateProperty.all<EdgeInsetsGeometry>(
                            const EdgeInsets.symmetric(vertical: 15),
                          ),
                          minimumSize: MaterialStateProperty.all<Size>(
                            const Size(150, 50),
                          ),
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.green),
                        ),
                        child: const Text(
                          'Back',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(width: 20),
                      ElevatedButton(
                        onPressed: () {
                          _saveInventoryItem();
                        },
                        style: ButtonStyle(
                          padding:
                              MaterialStateProperty.all<EdgeInsetsGeometry>(
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

  Widget _buildDropdown(
    String title,
    ValueChanged<String?> onSelect,
    List<String> options,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.0),
          child: Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        DropdownButton<String>(
          value: _selectedDropdownValue,
          isExpanded: true,
          onChanged: onSelect,
          items: options.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ],
    );
  }
}
