import 'package:demo_app/InventoryAdd.dart';
import 'package:demo_app/Login_Page.dart';
import 'package:demo_app/dbHelper/mongodb.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:async';

class Dashboard extends StatelessWidget {
  final String userName;
  final String userLastName;
  final String userEmail;

  Dashboard({
    required this.userName,
    required this.userLastName,
    required this.userEmail,
  });

  @override
  Widget build(BuildContext context) {
    return SideBarLayout(
      title: "Dashboard",
      mainContent: DateTimeWidget(),
      userName: userName,
      userLastName: userLastName,
      userEmail: userEmail,
    );
  }
}

class Inventory extends StatelessWidget {
  final String userName;
  final String userLastName;
  final String userEmail;

  const Inventory({
    required this.userName,
    required this.userLastName,
    required this.userEmail,
  });

  @override
  Widget build(BuildContext context) {
    return SideBarLayout(
      title: "Inventory",
      mainContent: Container(
        alignment: Alignment.center,
        child: Text('Inventory History Screen'),
      ),
      appBarActions: [
        IconButton(
          icon: Icon(
            Icons.assignment_add,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).push(
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
      ],
      userName: userName,
      userLastName: userLastName,
      userEmail: userEmail,
    );
  }
}

class RTV extends StatelessWidget {
  final String userName;
  final String userLastName;
  final String userEmail;

  RTV({
    required this.userName,
    required this.userLastName,
    required this.userEmail,
  });

  @override
  Widget build(BuildContext context) {
    return SideBarLayout(
      title: "RTV",
      mainContent: Container(
        alignment: Alignment.center,
        child: Text('RTV History Screen'),
      ),
      appBarActions: [
        IconButton(
          icon: Icon(
            Icons.assignment_return_rounded,
            color: Colors.white,
          ),
          onPressed: () {
            // Add your notification handling code here
          },
        ),
      ],
      userName: userName,
      userLastName: userLastName,
      userEmail: userEmail,
    );
  }
}

class Setting extends StatelessWidget {
  final String userName;
  final String userLastName;
  final String userEmail;

  Setting({
    required this.userName,
    required this.userLastName,
    required this.userEmail,
  });

  @override
  Widget build(BuildContext context) {
    return SideBarLayout(
      title: "Settings",
      mainContent: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
              child: Text(
                'LOG OUT',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          )
        ],
      ),
      userName: userName,
      userLastName: userLastName,
      userEmail: userEmail,
    );
  }
}

class SideBarLayout extends StatefulWidget {
  final String title;
  final Widget mainContent;
  final List<Widget>? appBarActions;
  String userName;
  String userLastName;
  String userEmail;

  SideBarLayout({
    required this.title,
    required this.mainContent,
    this.appBarActions,
    required this.userName,
    required this.userLastName,
    required this.userEmail,
  });

  @override
  _SideBarLayoutState createState() => _SideBarLayoutState();
}

class _SideBarLayoutState extends State<SideBarLayout> {
  String userName = '';
  String userLastName = '';
  String userEmail = '';

  @override
  void initState() {
    super.initState();
    _fetchUserInfo();
  }

  Future<void> _fetchUserInfo() async {
    try {
      final userInfo =
          await MongoDatabase.getUserDetailsByUsername('user_id_here');
      if (userInfo != null) {
        print(userInfo); // Print the retrieved user information
        setState(() {
          widget.userName = userInfo['firstName'] ?? '';
          widget.userLastName = userInfo['lastName'] ?? '';
          widget.userEmail = userInfo['emailAddress'] ?? '';
        });
      } else {
        // Handle case where user info is null
      }
    } catch (e) {
      // Handle error
      print('Error fetching user info: $e');
      // Show a message to the user
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _fetchUserInfo(),
      builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            flexibleSpace: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.green[900]!,
                    Colors.green[800]!,
                    Colors.green[400]!,
                  ],
                ),
              ),
            ),
            title: Text(
              widget.title,
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            leading: Builder(
              builder: (context) => IconButton(
                icon: Icon(
                  Icons.menu,
                  color: Colors.white,
                ),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              ),
            ),
            actions: widget.appBarActions,
          ),
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                UserAccountsDrawerHeader(
                  accountName: Text(
                    '${widget.userName} ${widget.userLastName}',
                    style: TextStyle(color: Colors.white),
                  ),
                  accountEmail: Text(
                    widget.userEmail,
                    style: TextStyle(color: Colors.white),
                  ),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.green[900]!,
                        Colors.green[800]!,
                        Colors.green[400]!,
                      ],
                    ),
                  ),
                ),
                ListTile(
                  leading: const Icon(
                    Icons.home_outlined,
                  ),
                  title: const Text('Home'),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => Dashboard(
                                userName: widget.userName,
                                userLastName: widget.userLastName,
                                userEmail: widget.userEmail,
                              )),
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.inventory_2_outlined),
                  title: const Text('Inventory'),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => Inventory(
                                userName: widget.userName,
                                userLastName: widget.userLastName,
                                userEmail: widget.userEmail,
                              )),
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.assignment_return_outlined),
                  title: const Text('RTV'),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => RTV(
                                userName: widget.userName,
                                userLastName: widget.userLastName,
                                userEmail: widget.userEmail,
                              )),
                    );
                  },
                ),
                const Divider(color: Colors.black),
                ListTile(
                  leading: const Icon(Icons.settings_outlined),
                  title: const Text('Settings'),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => Setting(
                                userName: widget.userName,
                                userLastName: widget.userLastName,
                                userEmail: widget.userEmail,
                              )),
                    );
                  },
                ),
              ],
            ),
          ),
          body: widget.mainContent,
        );
      },
    );
  }
}

class DateTimeWidget extends StatefulWidget {
  @override
  _DateTimeWidgetState createState() => _DateTimeWidgetState();
}

class _DateTimeWidgetState extends State<DateTimeWidget> {
  late Timer _timer;
  late DateTime _currentTime;

  @override
  void initState() {
    super.initState();
    // Initialize the current time and start the timer to update it periodically
    _currentTime = DateTime.now();
    _timer = Timer.periodic(Duration(seconds: 1), _updateTime);
  }

  @override
  void dispose() {
    // Dispose the timer when the widget is disposed
    _timer.cancel();
    super.dispose();
  }

  void _updateTime(Timer timer) {
    // Update the current time every second
    setState(() {
      _currentTime = DateTime.now();
    });
  }

  @override
  Widget build(BuildContext context) {
    String formattedTime = DateFormat('h:mm a').format(_currentTime);
    String dayOfWeek = DateFormat('EEEE').format(_currentTime);
    String formattedDate = DateFormat.yMMMMd().format(_currentTime);

    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          Text(
            formattedTime,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 5),
          Text(
            '$formattedDate, $dayOfWeek',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.normal,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}