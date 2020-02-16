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
  String _profPic;

  User get user {
    return _authenticatedUser;
  }

  PublishSubject<bool> _userSubject = PublishSubject();

  PublishSubject<bool> get userSubject {
    return _userSubject;
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
          '$hostUrl/users',
          headers: {'content-type': 'application/json'},
        );
        _authenticatedUser = User(
            firstName: responseData['firstName'],
            email: formData['email'],
            lastName: responseData['lastName'],
            token: responseData['idToken'],
            userId: responseData['userId'],
            address: responseData['address'],
            contactNo: responseData['contactNo'],
            userType: responseData['userType']);
        _userSubject.add(true);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('firstName', responseData['firstName']);
        prefs.setString('lastName', responseData['lastName']);
        prefs.setInt('userId', responseData['userId']);
        prefs.setString('token', responseData['token']);
        prefs.setString('email', formData['email']);
      } else if (responseData['message'] ==
          'Verification link has been sent to your email') {
        message =
            'Verification link has been sent to your email ${formData['email']}';
      } else if (responseData['message'] == 'Incorrect password') {
        message = 'Invalid password';
      } else if (responseData['message'] == 'Incorrect email') {
        message = 'User does not exist';
      } else if (responseData['message'] ==
          'this email registered already.Try another email') {
        message = 'User already exist';
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
        response = await http.post(
          '$hostUrl/users.json',
          body: json.encode(formData),
          headers: {'content-type': 'application/json'},
        );
        responseData = json.decode(response.body);

        _authenticatedUser = User(
            firstName: responseData['firstName'],
            email: formData['email'],
            lastName: responseData['lastName'],
            token: responseData['idToken'],
            userId: responseData['userId'],
            address: responseData['address'],
            contactNo: responseData['contactNo'],
            userType: responseData['userType']);
        _userSubject.add(true);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('firstName', responseData['firstName']);
        prefs.setString('lastName', responseData['lastName']);
        prefs.setInt('userId', responseData['userId']);
        prefs.setString('token', responseData['token']);
        prefs.setString('email', formData['email']);
      } else if (responseData['message'] ==
          'Verification link has been sent to your email') {
        message =
            'Verification link has been sent to your email ${formData['email']}';
      } else if (responseData['message'] == 'Incorrect password') {
        message = 'Invalid password';
      } else if (responseData['message'] == 'Incorrect email') {
        message = 'User does not exist';
      } else if (responseData['message'] ==
          'this email registered already.Try another email') {
        message = 'User already exist';
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
        userId: prefs.getInt('userId'),
      );
      _userSubject.add(true);
      notifyListeners();
    }
  }

  Future<bool> getProfPic(int userId) async {
    isLoading = true;
    try {
      final http.Response response = await http.post(
        '$hostUrl/users/viewproimage',
        body: json.encode({'id': userId}),
        headers: {'content-type': 'application/json'},
      );
      final Map<String, dynamic> responseData = json.decode(response.body);
      print(responseData);
      _profPic = responseData['pic_name'];
    } catch (e) {
      print(e);
      isLoading = false;
      return false;
    }
    isLoading = false;
    return true;
  }

  void logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('firstName');
    prefs.remove('lastName');
    prefs.remove('userId');
    prefs.remove('email');
    prefs.remove('token');
    _userSubject.add(false);
    _authenticatedUser = null;
    notifyListeners();
  }
}
