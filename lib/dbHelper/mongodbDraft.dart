import 'dart:convert';
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
