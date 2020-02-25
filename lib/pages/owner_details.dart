import 'package:bodima/scoped_models/main_scope.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:url_launcher/url_launcher.dart';

class OwnerDetailsPage extends StatefulWidget {
  @override
  _OwnerDetailsPageState createState() => _OwnerDetailsPageState();
}

Widget _buildOwnerDetailsPageBody() {
  return ScopedModelDescendant(
    builder: (BuildContext context, Widget child, MainModel model) {
      return SingleChildScrollView(
        child: Container(
            padding: EdgeInsets.fromLTRB(20.0, 50.0, 20.0, 50.0),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Owner Name: ',
                      style: TextStyle(
                          fontSize: 22.0,
                          height: 1.3,
                          fontWeight: FontWeight.w400),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      '${model.owner.firstName} ${model.owner.lastName}',
                      style: TextStyle(
                          fontSize: 22.0,
                          height: 1.3,
                          fontWeight: FontWeight.w300),
                      textAlign: TextAlign.left,
                    ),
                    IconButton(
                      icon: Icon(Icons.person_outline),
                      onPressed: () {},
                    )
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'email: ',
                      style: TextStyle(
                          fontSize: 22.0,
                          height: 1.3,
                          fontWeight: FontWeight.w400),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      '${model.owner.email}',
                      style: TextStyle(
                          fontSize: 22.0,
                          height: 1.3,
                          fontWeight: FontWeight.w300),
                      textAlign: TextAlign.left,
                    ),
                    IconButton(
                      icon: Icon(Icons.email),
                      onPressed: () {
                        _launchEmail(model.owner.email);
                      },
                    )
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Address: ',
                      style: TextStyle(
                          fontSize: 22.0,
                          height: 1.3,
                          fontWeight: FontWeight.w400),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      '${model.owner.address}',
                      style: TextStyle(
                          fontSize: 22.0,
                          height: 1.3,
                          fontWeight: FontWeight.w300),
                      textAlign: TextAlign.left,
                    ),
                    IconButton(
                      icon: Icon(Icons.location_on),
                      onPressed: () {},
                    )
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Contact No: ',
                      style: TextStyle(
                          fontSize: 22.0,
                          height: 1.3,
                          fontWeight: FontWeight.w400),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      '${model.owner.contactNo}',
                      style: TextStyle(
                          fontSize: 22.0,
                          height: 1.3,
                          fontWeight: FontWeight.w300),
                      textAlign: TextAlign.left,
                    ),
                    IconButton(
                      icon: Icon(Icons.phone),
                      onPressed: () {
                        _launchCaller(model.owner.contactNo);
                      },
                    )
                  ],
                ),
              ],
            )),
      );
    },
  );
}

_launchCaller(String number) async {
  String url = "tel:$number";
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

_launchEmail(String email) async {
  String url = "mailto:$email";
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

class _OwnerDetailsPageState extends State<OwnerDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildOwnerDetailsPageBody(),
    );
  }
}
