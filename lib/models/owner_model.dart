import 'package:flutter/material.dart';

class Owner {
  final String firstName;
  final String lastName;
  final String email;
  final String token;
  final int ownerId;

  Owner({
    @required this.firstName,
    @required this.email,
    @required this.lastName,
    @required this.token,
    @required this.ownerId,
  });
}