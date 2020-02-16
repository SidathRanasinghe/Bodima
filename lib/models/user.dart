import 'package:flutter/material.dart';

class User {
  final String firstName;
  final String lastName;
  final String email;
  final String token;
  final int userId;
  final String userType;
  final String address;
  final String contactNo;

  User({
    @required this.firstName,
    @required this.email,
    @required this.lastName,
    @required this.token,
    @required this.userId,
    @required this.userType,
    @required this.address,
    @required this.contactNo,
  });
}
