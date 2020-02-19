import 'package:bodima/models/boarding.dart';
import 'package:bodima/scoped_models/main_scope.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class BoardingCard extends StatelessWidget {
  final Boarding boarding;

  BoardingCard(this.boarding);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/BoardingContent/' + boarding.boardingId); //ghsgdgshdg
      },
      child: Card(
        margin: EdgeInsets.only(top: 6.0, right: 9.0, left: 9.0, bottom: 7.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8.0),
                topRight: Radius.circular(8.0),
              ),
              child: AspectRatio(
                aspectRatio: 16 / 8,
                child: ScopedModelDescendant(
                  builder:
                      (BuildContext context, Widget child, MainModel model) {
                    return Hero(
                      tag: '${this.boarding.boardingId}',
                      child: FadeInImage(
                        image: NetworkImage('${this.boarding.imageUrl}'),
                        fit: BoxFit.cover,
                        alignment: FractionalOffset.center,
                        placeholder: AssetImage('assets/android.jpg'),
                      ),
                    );
                  },
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(20.0),
              child: Text(
                boarding.address ?? 'Default News Title',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.black54),
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }
}
