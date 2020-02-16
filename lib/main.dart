import 'package:bodima/pages/Border_wall.dart';
import 'package:bodima/pages/home_page.dart';
import 'package:bodima/pages/login_page.dart';
import 'package:bodima/scoped_models/main_scope.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final MainModel _model = MainModel();
  bool _isAuthenticated = false;

  @override
  Widget build(BuildContext context) {
    return ScopedModel<MainModel>(
      model: _model,
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.orange,
          brightness: Brightness.light,
          accentColor: Colors.orange,
          buttonColor: Colors.deepOrange,
        ),
        routes: {
          '/': (BuildContext context) =>
              _isAuthenticated ? HomePage(_model) : LoginPage(),
          '/wall': (BuildContext context) => BorderWall(),
        },
        onGenerateRoute: (RouteSettings settings) {
          if (!_isAuthenticated) {
            MaterialPageRoute(builder: (BuildContext context) => LoginPage());
          }
          return null;
        },
      ),
    );
  }
}
