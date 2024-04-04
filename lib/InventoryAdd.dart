// ignore_for_file: prefer_const_constructors, sort_child_properties_last, prefer_const_literals_to_create_immutables, depend_on_referenced_packages, use_super_parameters, library_private_types_in_public_api, file_names, use_key_in_widget_constructors

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
    super.dispose();
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
                        )),
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
                      decoration: InputDecoration(
                        hintText: 'Enter Input ID',
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Name',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Enter Name',
                      ),
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
                                        value: '1'),
                                    DropdownMenuItem(
                                        child: Text(
                                            'PUROGOLD PRICE CLUB(JR.)- PAM PLAZA'),
                                        value: '2'),
                                    DropdownMenuItem(
                                        child:
                                            Text('PUREGOD PRICE CLUB - BAGUIO'),
                                        value: '3'),
                                  ],
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedAccount = value;
                                      // Check if both dropdowns have a value
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
                                          _selectedPeriod =
                                              null; // Clear the selected period when account is cleared
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
                                          value: '1'),
                                      DropdownMenuItem(
                                          child: Text('Dec30-Jan05'),
                                          value: '2'),
                                      DropdownMenuItem(
                                          child: Text('Jan06-Jan12'),
                                          value: '3'),
                                    ],
                                    onChanged: (value) {
                                      setState(() {
                                        _selectedPeriod = value;
                                        // Check if both dropdowns have a value
                                        _isSaveEnabled =
                                            _selectedAccount != null &&
                                                _selectedPeriod != null;
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
                                            _showAdditionalInfo =
                                                false; // Hide additional info fields when period is cleared
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
                          decoration: InputDecoration(
                            hintText: 'Enter Month',
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Week',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextFormField(
                          decoration: InputDecoration(
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
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              SKUInventory()));
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
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            // leading: IconButton(
            //   icon: Icon(Icons.arrow_back),
            //   onPressed: () {
            //     Navigator.of(context).pushReplacement(
            //       MaterialPageRoute(builder: (context) => AddInventory()),
            //     );
            //   },
            // ),
          ),
        ));
  }
}
