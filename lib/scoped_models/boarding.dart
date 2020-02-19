import 'dart:convert';

import 'package:bodima/models/boarding.dart';
import 'package:bodima/scoped_models/auth.dart';
import 'package:bodima/scoped_models/utility_scope.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

mixin BoardingModel on Model, UtilityScope, UserModel {
  List<Boarding> _finalBoardingList = List();

  List<Boarding> get finalBoardingList {
    return _finalBoardingList;
  }

  Boarding _selectedBoarding;

  Boarding get selectedBoarding {
    return _selectedBoarding;
  }

  set selectedBoarding(Boarding boarding) {
    _selectedBoarding = boarding;
  }

  Future<Null> fetchBoardings() async {
    isLoading = true;
    final http.Response response = await http.get('$hostUrl/boardings.json');

    final Map<String, dynamic> fetchedNews = json.decode(response.body);
    final List<Boarding> fetchedBoardingList = [];
    fetchedNews.forEach((String boardingId, dynamic boarding) {
      Boarding fetchedBoardingElement = Boarding(
        boardingId: boardingId,
        ownerId: boarding['ownerId'],
        address: boarding['address'],
        lng: boarding['lng'],
        ltd: boarding['ltd'],
        memberCount: boarding['memberCount'],
        description: boarding['description'],
        imageUrl: boarding['imageUrl'],
        dateAdded: boarding['dateAdded'],
      );
      fetchedBoardingList.add(fetchedBoardingElement);
    });
    _finalBoardingList = fetchedBoardingList;
    print('boardings fetched');
    notifyListeners();
    isLoading = false;
  }

  submitBoarding(Map<String, dynamic> boardingDetails) async {
    isLoading = true;
    print('${user.userId}');
    DateTime now = DateTime.now();
    boardingDetails.addAll({
      'ownerId': user.userId,
      'dateAdded': '${now.day}/${now.month}/${now.year}'
    });
    final http.Response response = await http.post(
      '$hostUrl/boardings.json',
      body: json.encode(boardingDetails),
      headers: {'content-type': 'application/json'},
    );
    final Map<String, dynamic> responseData = json.decode(response.body);
    print(responseData);
    isLoading = false;
  }

  deleteBoarding(String boardingId) async {
    isLoading = true;
    print('${user.userId}');
    final http.Response response = await http.delete(
      '$hostUrl/boardings/$boardingId.json',
      headers: {'content-type': 'application/json'},
    );
    final Map<String, dynamic> responseData = json.decode(response.body);
    print(responseData);
    isLoading = false;
  }
}
