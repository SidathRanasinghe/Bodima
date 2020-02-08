import 'package:bodima/scoped_models/main_scope.dart';
import 'package:flutter/material.dart';

import 'package:scoped_model/scoped_model.dart';

class LogoutListTile extends StatefulWidget {
  @override
  _LogoutListTileState createState() => _LogoutListTileState();
}

class _LogoutListTileState extends State<LogoutListTile> {
  void _showDialog(MainModel model) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text(
            'Alert',
            style: TextStyle(
                fontSize: 18.0, fontWeight: FontWeight.w700, color: Colors.red),
          ),
          content: new Text(
            'Do you want to Logout ?',
            style: TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.w700,
              color: Colors.black87,
            ),
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text(
                'Yes',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w700,
                  color: Colors.teal,
                ),
              ),
              onPressed: () {
//                Navigator.popUntil(context, ModalRoute.withName('/'));
                //model.logout();
                Navigator.of(context).pushNamedAndRemoveUntil(
                    '/', (Route<dynamic> route) => false);
                model.isLoading = false;
              },
            ),
            new FlatButton(
              child: new Text(
                'No',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w700,
                  color: Colors.teal,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant(
      builder: (BuildContext context, Widget child, MainModel model) {
        return ListTile(
          leading: Icon(Icons.exit_to_app),
          title: Text('Logout'),
          onTap: () {
            _showDialog(model);
          },
        );
      },
    );
  }
}
