// ignore_for_file: prefer_const_constructors, sort_child_properties_last, prefer_const_literals_to_create_immutables, depend_on_referenced_packages, use_super_parameters, library_private_types_in_public_api, file_names, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, prefer_final_fields

import 'dart:math';

import 'package:demo_app/Dashboard_Page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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

  Map<String, String> accountNameMap = {
    '1': 'PUREGOLD PRICE CLUB(JR.)- OLD CENTRO',
    '2': 'PUROGOLD PRICE CLUB(JR.)- PAM PLAZA',
    '3': 'PUREGOD PRICE CLUB - BAGUIO',
  };

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    _dateController = TextEditingController();
    _selectedDate = DateTime.now();
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
                        'TPA',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      TextFormField(
                        initialValue: 'BMP',
                        enabled: false,
                        decoration: InputDecoration(
                          hintText: 'Enter TPA',
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'ACCOUNT GROUP',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Enter Account Group',
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'AOR',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Enter AOR',
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'REGION',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Enter Region',
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'ADP',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Enter ADP',
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'CUSTOMER CODE',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Enter Customer Code',
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'COC',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Enter COC',
                        ),
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
                            hintText: 'Enter Month',
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
                            hintText: 'Enter Week',
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
                                                selectedAccount:
                                                    _selectedAccount,
                                                selectedAccountText:
                                                    accountNameMap[
                                                        _selectedAccount],
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

class SKUInventory extends StatelessWidget {
  final String userName;
  final String userLastName;
  final String userEmail;
  final String? selectedAccount;
  final String? selectedAccountText;

  SKUInventory({
    required this.userName,
    required this.userLastName,
    required this.userEmail,
    this.selectedAccount,
    this.selectedAccountText,
  });

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
                  builder: (context) => AddInventory(
                    userName: userName,
                    userLastName: userLastName,
                    userEmail: userEmail,
                  ),
                ),
              );
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                style: TextStyle(fontWeight: FontWeight.bold),
                'Week Number',
              ),
              TextField(
                decoration: InputDecoration(),
              ),
              SizedBox(height: 10),
              Text(
                style: TextStyle(fontWeight: FontWeight.bold),
                'Account Branch Name',
              ),
              TextField(
                decoration: InputDecoration(
                  hintText: selectedAccountText ?? '',
                ),
              ),
              SizedBox(height: 20),
              Text(
                'CATEGORY',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  OutlinedButton(
                    onPressed: () {
                      // Add your logic for what happens when v1 is pressed
                    },
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(width: 2.0, color: Colors.green),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4)),
                    ),
                    child: Text('v1'),
                  ),
                  OutlinedButton(
                    onPressed: () {
                      // Add your logic for what happens when v2 is pressed
                    },
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(width: 2.0, color: Colors.green),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4)),
                    ),
                    child: Text('v2'),
                  ),
                  OutlinedButton(
                    onPressed: () {
                      // Add your logic for what happens when v3 is pressed
                    },
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(width: 2.0, color: Colors.green),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4)),
                    ),
                    child: Text('v3'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
