import 'package:flutter/material.dart';

class AboutUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.orange,
        ),
        title: Text(
          ("About Us"),
          style: TextStyle(
            fontSize: 25.0,
            color: Colors.orange,
            fontWeight: FontWeight.w700,
          ),
        ),
        bottom: PreferredSize(
            child: Container(
              color: Colors.orange,
              height: 4.0,
            ),
            preferredSize: Size.fromHeight(4.0)),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 30.0, right: 20.0, top: 20.0),
        child: SingleChildScrollView(
          child: Text(
            '     We are inovation Group 10.',
            style: TextStyle(
              fontSize: 15.0,
            ),
          ),
        ),
      ),
    );
  }
}
