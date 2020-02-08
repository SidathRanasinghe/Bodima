import 'package:bodima/scoped_models/main_scope.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class ProfileDetails extends StatefulWidget {
  @override
  _ProfileDetailsState createState() => _ProfileDetailsState();
}

class _ProfileDetailsState extends State<ProfileDetails> {
  Widget buildCoverImage(Size screenSize) {
    return Container(
      height: screenSize.height / 2.6,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/LogoBlack.jpg'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget buildProfileImage() {
    return Center(
      child: Container(
        width: 140.0,
        height: 140.0,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/code3.jpg'),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(80.0),
          border: Border.all(
            color: Colors.white,
            width: 10.0,
          ),
        ),
      ),
    );
  }

  Widget buildFullName(MainModel model) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 6.0),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Text(
        //'${model.user.firstName} ${model.user.lastName}',
        'Sidath Ranasinghe',
        style: TextStyle(
//      fontFamily:
          fontSize: 26.0,
          fontWeight: FontWeight.w700,
          color: Colors.black87,
        ),
      ),
    );
  }

  Widget buildStatus(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 6.0),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Text(
        'Owner / Border',
        style: TextStyle(
          fontWeight: FontWeight.w300,
          fontSize: 20.0,
          color: Colors.teal,
//            fontFamily:
        ),
      ),
    );
  }

  Widget buildId(MainModel model) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 6.0),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Text(
        //'ID : ${model.user.id}',
        'ID : 102',
        style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 15.0,
          color: Colors.black54,
//            fontFamily:
        ),
      ),
    );
  }

  Widget contactNumber(MainModel model) {
    return Container(
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 50.0,
          ),
          Icon(
            Icons.phone,
            color: Colors.teal,
          ),
          SizedBox(
            width: 15.0,
          ),
          Text(
            //'${model.user.contactNo}',
            '0701234567',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 20.0,
              color: Colors.teal,
            ),
          )
        ],
      ),
    );
  }

  Widget Email(MainModel model) {
    return Container(
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 50.0,
          ),
          Icon(
            Icons.mail_outline,
            color: Colors.teal,
          ),
          SizedBox(
            width: 15.0,
          ),
          Text(
            //'${model.user.email}',
            'sidath.17@itfac.mrt.ac.lk',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 20.0,
              color: Colors.teal,
            ),
          )
        ],
      ),
    );
  }

  /*Widget JobCat1(MainModel model) {
    return Container(
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 50.0,
          ),
          Icon(
            Icons.build,
            color: Colors.orange,
          ),
          SizedBox(
            width: 15.0,
          ),
          Text(
            '${model.user.jobCategory1}',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 20.0,
              color: Colors.orange,
            ),
          )
        ],
      ),
    );
  }

  Widget JobCat2(MainModel model) {
    return Container(
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 50.0,
          ),
          Icon(
            Icons.build,
            color: Colors.orange,
          ),
          SizedBox(
            width: 15.0,
          ),
          Text(
            '${model.user.jobCategory2}',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 20.0,
              color: Colors.orange,
            ),
          )
        ],
      ),
    );
  }*/

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        return Scaffold(
          body: Stack(
            children: <Widget>[
              buildCoverImage(screenSize),
              SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: screenSize.height / 4.8,
                      ),
                      buildProfileImage(),
                      buildFullName(model),
                      buildStatus(context),
                      buildId(model),
                      SizedBox(
                        height: 20.0,
                      ),
                      Divider(),
                      SizedBox(
                        height: 30.0,
                      ),
                      contactNumber(model),
                      SizedBox(
                        height: 20.0,
                      ),
                      Email(model),
                      SizedBox(
                        height: 30.0,
                      ),
                      /*Divider(),
                      SizedBox(
                        height: 20.0,
                      ),
                      Text(
                        'Job Categories',
                        style: TextStyle(
                          fontSize: 25.0,
                          fontWeight: FontWeight.w700,
                          color: Colors.black87,
//                          fontFamily:
                        ),
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      JobCat1(model),
                      SizedBox(
                        height: 20.0,
                      ),
                      JobCat2(model),
                      SizedBox(
                        height: 50.0,
                      ),*/
                      Divider(
                        thickness: 2.0,
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Text(
                        'by Team ⓇInovG10',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15.0,
                          color: Colors.black45,
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
