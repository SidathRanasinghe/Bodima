import 'package:flutter/material.dart';

class Border {
  final String firstName;
  final String lastName;
  final String email;
  final String token;
  final int borderId;

  Border({
    @required this.firstName,
    @required this.email,
    @required this.lastName,
    @required this.token,
    @required this.borderId,
  });
}
