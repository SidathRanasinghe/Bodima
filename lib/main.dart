import 'package:bodima/pages/boarding/boarding_content.dart';
import 'package:bodima/pages/boarding/boarding_edit.dart';
import 'package:bodima/pages/boarding/boardng_feed.dart';
import 'package:bodima/pages/login_page.dart';
import 'package:bodima/pages/owner_details.dart';
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
    _model.isEdit = false;
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
              _isAuthenticated ? BoardingFeedPage(_model) : LoginPage(),
          '/BoardingFeedPage': (BuildContext context) =>
              BoardingFeedPage(_model),
          '/BoardingEditPage': (BuildContext context) =>
              BoardingEditPage(_model),
          '/OwnerDetailsPage': (BuildContext context) => OwnerDetailsPage(),
        },
        onGenerateRoute: (RouteSettings settings) {
          final List<String> pathElements = settings.name.split('/');
          if (pathElements[0] != '') {
            return null;
          }
          if (pathElements[1] == 'BoardingContent') {
            final String boardingId = pathElements[2];
            return MaterialPageRoute(
                builder: (BuildContext context) =>
                    BoardingContentPage(boardingId, _model));
          }
          return null;
        },
      ),
    );
  }
}
