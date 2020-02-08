import 'package:bodima/drawer/main.dart';
import 'package:bodima/scoped_models/main_scope.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class HomePage extends StatefulWidget {
  final MainModel _model;

  HomePage(this._model);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  initState(){}

  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {
          return Scaffold(
            drawer: DefaultSideDrawer(),
            appBar: new AppBar(
              iconTheme: new IconThemeData(color: Colors.black),
              backgroundColor: Colors.deepOrange,
              elevation: 0.0,
              title: Text(
                ("Home"),
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                ),
              ),
              centerTitle: true,
              bottom: TabBar(
                unselectedLabelColor: Colors.black54,
                unselectedLabelStyle: TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: 14.0,
                ),
                labelColor: Colors.black,
                labelStyle: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w800,
                ),
                indicatorColor: Colors.black,
                indicatorWeight: 4,
                tabs: <Widget>[
                  Tab(
                    text: /*'${model.user == null ? 'Category 1' : model.user.jobCategory1}'*/'Owner',
                  ),
                  Tab(
                    text: /*'${model.user == null ? 'Category 2' : model.user.jobCategory2}'*/'Border',
                  ),
                ],
              ),
            ),
            body: TabBarView(
              children: <Widget>[
                //ComJobCat1(model),
                //ComJobCat2(model),
              ],
            ),
          );
        },
      ),
    );
  }
}
