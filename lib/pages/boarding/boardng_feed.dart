import 'package:bodima/drawer/main.dart';
import 'package:bodima/pages/boarding/boarding_card.dart';
import 'package:bodima/scoped_models/main_scope.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class BoardingFeedPage extends StatefulWidget {
  final MainModel _model;

  BoardingFeedPage(this._model);

  @override
  _BoardingFeedPageState createState() => _BoardingFeedPageState();
}

class _BoardingFeedPageState extends State<BoardingFeedPage> {
  Widget _buildBoardingFeed(MainModel model) {
    Widget content = model.finalBoardingList.isEmpty
        ? Container(
            child: Center(
              child: Text('No Boardings yet, please add some'),
            ),
          )
        : ListView.builder(
            itemCount: model.finalBoardingList.length,
            itemBuilder: (BuildContext context, int index) {
              return BoardingCard(model.finalBoardingList[index]);
            },
          );
    return RefreshIndicator(
      onRefresh: model.fetchBoardings,
      child: content,
    );
  }

  Widget _buildFloatingActionButton() {
    return ScopedModelDescendant(
      builder: (BuildContext context, Widget child, MainModel model) {
        return model.user.userType == 'owner' ? FloatingActionButton(
          heroTag: 'blackFab',
          onPressed: () {
            widget._model.isEdit = false;
            Navigator.pushNamed(context, '/BoardingEditPage');
          },
          tooltip: 'Add a news',
          backgroundColor: Colors.green,
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
        ): Container();
      },
    );
  }

  Future<bool> _willPop(BuildContext context) async {
    if (!(Navigator.canPop(context)))
      return showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Alert !'),
                content: Text('Do you realy want to exit from the app ?'),
                actions: <Widget>[
                  FlatButton(
                      child: Text('Yes'),
                      onPressed: () {
                        Navigator.of(context).pop(true);
                      }),
                  FlatButton(
                      child: Text('No'),
                      onPressed: () {
                        Navigator.of(context).pop(false);
                      })
                ],
              );
            },
          ) ??
          false;
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _willPop(context),
      child: Scaffold(
        drawer: DefaultSideDrawer(),
        body: ScopedModelDescendant<MainModel>(
            builder: (BuildContext context, Widget child, MainModel model) {
          return model.isLoading
              ? Center(child: CircularProgressIndicator())
              : Container(
                  height: MediaQuery.of(context).size.height,
                  child: _buildBoardingFeed(model),
                );
        }),
        floatingActionButton: _buildFloatingActionButton(),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    widget._model.fetchBoardings();
  }
}
