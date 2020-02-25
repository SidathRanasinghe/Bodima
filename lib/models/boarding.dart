import 'package:flutter/material.dart';

class Boarding {
  final String boardingId;
  final String ownerId;
  final String address;
  final int memberCount;
  final String description;
  final double lng;
  final double ltd;
  final String imageUrl;
  final String dateAdded;
  final int rental;

  Boarding({
    @required this.boardingId,
    @required this.ownerId,
    @required this.address,
    @required this.memberCount,
    @required this.description,
    @required this.lng,
    @required this.ltd,
    @required this.imageUrl,
    @required this.dateAdded,
    @required this.rental,
  });
}
