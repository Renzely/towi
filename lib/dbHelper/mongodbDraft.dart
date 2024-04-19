import 'dart:convert';
import 'package:demo_app/dbHelper/constant.dart';
import 'package:mongo_dart/mongo_dart.dart';

MongoDemo welcomeFromJson(String str) => MongoDemo.fromJson(json.decode(str));

String welcomeToJson(MongoDemo data) => json.encode(data.toJson());

class MongoDemo {
  final ObjectId id;
  final String firstName;
  final String lastName;
  final String emailAddress;
  final String contactNum;
  final String username;
  final String password;

  MongoDemo({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.emailAddress,
    required this.contactNum,
    required this.username,
    required this.password,
  });

  factory MongoDemo.fromJson(Map<String, dynamic> json) {
    return MongoDemo(
      id: json['_id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      emailAddress: json['email_Address'],
      contactNum: json['contactNum'],
      username: json['username'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() => {
        '_id': id,
        'firstName': firstName,
        'lastName': lastName,
        'email_Address': emailAddress,
        'contactNum': contactNum,
        'username': username,
        'password': password,
      };
}

// // // INVENTORY DATABASE // // //

class InventoryItem {
  ObjectId id;
  String date;
  String inputId;
  String name;
  String accountNameBranchManning;
  String period;
  String month;
  String week;
  String category;
  String skuDescription;
  String products;
  String skuCode;
  String status; // Carried, Not Carried, Delisted
  int beginning;
  int delivery;
  int ending;
  int offtake;
  int inventoryDaysLevel;
  int noOfDaysOOS;

  InventoryItem({
    required this.id,
    required this.date,
    required this.inputId,
    required this.name,
    required this.accountNameBranchManning,
    required this.period,
    required this.month,
    required this.week,
    required this.category,
    required this.skuDescription,
    required this.products,
    required this.skuCode,
    required this.status,
    required this.beginning,
    required this.delivery,
    required this.ending,
    required this.offtake,
    required this.inventoryDaysLevel,
    required this.noOfDaysOOS,
  });

  factory InventoryItem.fromJson(Map<String, dynamic> json) => InventoryItem(
        id: json['_id'] ?? ObjectId(),
        date: json['date'] ?? '',
        inputId: json['inputId'] ?? '',
        name: json['name'] ?? '',
        accountNameBranchManning: json['accountNameBranchManning'] ?? '',
        period: json['period'] ?? '',
        month: json['month'] ?? '',
        week: json['week'] ?? '',
        category: json['category'] ?? '',
        skuDescription: json['skuDescription'] ?? '',
        products: json['products'] ?? '',
        skuCode: json['skuCode'] ?? '',
        status: json['status'] ?? '',
        beginning: json['beginning'] ?? 0,
        delivery: json['delivery'] ?? 0,
        ending: json['ending'] ?? 0,
        offtake: json['offtake'] ?? 0,
        inventoryDaysLevel: json['inventoryDaysLevel'] ?? 0,
        noOfDaysOOS: json['noOfDaysOOS'] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'date': date,
        'inputId': inputId,
        'name': name,
        'accountNameBranchManning': accountNameBranchManning,
        'period': period,
        'month': month,
        'week': week,
        'category': category,
        'skuDescription': skuDescription,
        'products': products,
        'skuCode': skuCode,
        'status': status,
        'beginning': beginning,
        'delivery': delivery,
        'ending': ending,
        'offtake': offtake,
        'inventoryDaysLevel': inventoryDaysLevel,
        'noOfDaysOOS': noOfDaysOOS,
      };
  void _saveToDatabase(InventoryItem newItem) async {
    // Connect to your MongoDB database
    final db = Db(MONGO_CONN_URL);
    await db.open();

    // Get a reference to the collection where you want to save items
    final collection = db.collection(USER_INVENTORY);

    // Convert the InventoryItem to a Map using the toJson() method
    final Map<String, dynamic> itemMap = newItem.toJson();

    // Insert the item into the collection
    try {
      await collection.insert(itemMap);
      print('Item saved to database');
    } catch (e) {
      // Handle any errors that occur during saving
      print('Error saving item: $e');
    }

    // Close the database connection when done
    await db.close();
  }
}
