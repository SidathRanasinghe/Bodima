import 'package:bodima/models/login_model.dart';
import 'package:bodima/models/user.dart';
import 'package:bodima/scoped_models/utility_scope.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rxdart/subjects.dart';

import 'dart:convert';
import 'dart:async';

mixin UserModel on Model, UtilityScope {
  User _authenticatedUser;
  User _boardingOwner;

  User get owner {
    return _boardingOwner;
  }

  set owner(User owner) {
    _boardingOwner = owner;
  }

  User get user {
    return _authenticatedUser;
  }

  PublishSubject<bool> _userSubject = PublishSubject();

  PublishSubject<bool> get userSubject {
    return _userSubject;
  }

  Future<Null> getOwnerDetails(String userId) async {
    isLoading = true;
    http.Response response = await http.get(
      '$hostUrl/users/$userId.json',
      headers: {'content-type': 'application/json'},
    );
    final Map<String, dynamic> responseData = json.decode(response.body);
    print(responseData);
    _boardingOwner = User(
        firstName: responseData['firstName'],
        email: responseData['email'],
        lastName: responseData['lastName'],
        token: responseData['token'],
        userId: responseData['userId'],
        address: responseData['address'],
        contactNo: responseData['contactNo'],
        userType: responseData['userType']);
    isLoading = false;
  }

  Future<Map<String, dynamic>> authenticate(Map<String, dynamic> formData,
      [AuthMode mode = AuthMode.Login]) async {
    isLoading = true;
    http.Response response;
    Map<String, dynamic> responseData;
    String message = 'Something went wrong';
    bool hasError = true;
    final Map<String, dynamic> loginFormData = {
      'email': formData['email'],
      'password': formData['password'],
      'returnSecureToken': true,
    };

    if (mode == AuthMode.Login) {
      response = await http.post(
        'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=$apiKey',
        body: json.encode(loginFormData),
        headers: {'content-type': 'application/json'},
      );
      responseData = json.decode(response.body);
      print(responseData);
      if (responseData.containsKey('idToken')) {
        hasError = false;
        message = 'Authentication Succeeded';
        response = await http.get(
          '$hostUrl/users/${responseData['localId']}.json',
          headers: {'content-type': 'application/json'},
        );
        formData.addAll({'token': responseData['idToken']});
        responseData = json.decode(response.body);
        formData['firstName'] = responseData['firstName'];
        formData['lastName'] = responseData['lastName'];
        formData['email'] = responseData['email'];
        formData['userId'] = responseData['userId'];
        formData['userType'] = responseData['userType'];
        formData['address'] = responseData['address'];
        formData['contactNo'] = responseData['contactNo'];

        print(responseData);

        _authenticatedUser = User(
            firstName: formData['firstName'],
            email: formData['email'],
            lastName: formData['lastName'],
            token: formData['token'],
            userId: formData['userId'],
            address: formData['address'],
            contactNo: formData['contactNo'],
            userType: formData['userType']);
        _userSubject.add(true);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('firstName', _authenticatedUser.firstName);
        prefs.setString('lastName', _authenticatedUser.lastName);
        prefs.setString('userId', _authenticatedUser.userId);
        prefs.setString('token', _authenticatedUser.token);
        prefs.setString('email', _authenticatedUser.email);
        prefs.setString('contactNo', _authenticatedUser.contactNo);
        prefs.setString('address', _authenticatedUser.address);
        prefs.setString('userType', _authenticatedUser.userType);
      } else if (responseData['error']['message'] == 'INVALID_PASSWORD') {
        message = 'INVALID_PASSWORD';
      } else if (responseData['error']['message'] == 'EMAIL_NOT_FOUND') {
        message = 'EMAIL_NOT_FOUND';
      }
    } else {
      response = await http.post(
        'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=$apiKey',
        body: json.encode(loginFormData),
        headers: {'content-type': 'application/json'},
      );
      responseData = json.decode(response.body);
      print(responseData);
      formData.addAll({'userId': responseData['localId']});
      if (responseData.containsKey('idToken')) {
        hasError = false;
        message = 'Authentication Succeeded';
        response = await http.put(
          '$hostUrl/users/${responseData['localId']}.json',
          body: json.encode(formData),
          headers: {'content-type': 'application/json'},
        );
        formData.addAll({'token': responseData['idToken']});
        responseData = json.decode(response.body);
        print(responseData);

        _authenticatedUser = User(
            firstName: formData['firstName'],
            email: formData['email'],
            lastName: formData['lastName'],
            token: formData['token'],
            userId: formData['userId'],
            address: formData['address'],
            contactNo: formData['contactNo'],
            userType: formData['userType']);
        _userSubject.add(true);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('firstName', _authenticatedUser.firstName);
        prefs.setString('lastName', _authenticatedUser.lastName);
        prefs.setString('userId', _authenticatedUser.userId);
        prefs.setString('token', _authenticatedUser.token);
        prefs.setString('email', _authenticatedUser.email);
        prefs.setString('contactNo', _authenticatedUser.contactNo);
        prefs.setString('address', _authenticatedUser.address);
        prefs.setString('userType', _authenticatedUser.userType);
      } else if (responseData['error']['message'] == 'EMAIL_EXISTS') {
        message = 'EMAIL_EXISTS';
      } else if (responseData['error']['message'] == 'OPERATION_NOT_ALLOWED') {
        message = 'OPERATION_NOT_ALLOWED';
      } else if (responseData['error']['message'] ==
          'TOO_MANY_ATTEMPTS_TRY_LATER') {
        message = 'TOO_MANY_ATTEMPTS_TRY_LATER';
      }
    }

    isLoading = false;
    notifyListeners();
    return {'success': !hasError, 'message': message};
  }

  void autoAuthenticate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String token = prefs.getString('token');
    if (token != null) {
      _authenticatedUser = User(
        firstName: prefs.getString('firstName'),
        email: prefs.getString('email'),
        lastName: prefs.getString('lastName'),
        token: prefs.getString('token'),
        userId: prefs.getString('userId'),
        userType: prefs.getString('userType'),
        contactNo: prefs.getString('contactNo'),
        address: prefs.getString('address'),
      );
      _userSubject.add(true);
      notifyListeners();
    }
  }

  void logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('firstName');
    prefs.remove('lastName');
    prefs.remove('userId');
    prefs.remove('email');
    prefs.remove('address');
    prefs.remove('userType');
    prefs.remove('contactNo');
    prefs.remove('token');
    _userSubject.add(false);
    _authenticatedUser = null;
    notifyListeners();
  }
}
