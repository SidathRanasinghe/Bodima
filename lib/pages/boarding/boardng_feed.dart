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
    return FloatingActionButton(
      heroTag: 'blackFab',
      onPressed: () {
        widget._model.isEdit = false;
        Navigator.pushNamed(context, '/BoardingEditPage');
      },
      tooltip: 'Add a news',
      backgroundColor: Colors.black87,
      child: Icon(
        Icons.add,
        color: Colors.white,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScopedModelDescendant<MainModel>(
          builder: (BuildContext context, Widget child, MainModel model) {
        return model.isLoading
            ? Center(child: CircularProgressIndicator())
            : _buildBoardingFeed(model);
      }),
      floatingActionButton: _buildFloatingActionButton(),
    );
  }

  @override
  void initState() {
    super.initState();
    widget._model.fetchBoardings();
  }
}
