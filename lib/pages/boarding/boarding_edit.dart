import 'package:bodima/models/boarding.dart';
import 'package:bodima/scoped_models/main_scope.dart';
import 'package:bodima/widgets/location_input_form.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class BoardingEditPage extends StatefulWidget {
  final Boarding editableBoarding;
  final MainModel _model;

  BoardingEditPage(this._model, {this.editableBoarding});

  @override
  _BoardingEditPageState createState() => _BoardingEditPageState();
}

class _BoardingEditPageState extends State<BoardingEditPage> {
  TextEditingController boardingAddressController = new TextEditingController();
  TextEditingController boardingMemberCountController =
      new TextEditingController();
  TextEditingController boardingDescriptionController =
      new TextEditingController();

  final Map<String, dynamic> _formData = {
    'address': null,
    'membersCount': null,
    'lat': null,
    'lng': null,
    'description': null,
    'imageUrl':
        'https://images.pexels.com/photos/106399/pexels-photo-106399.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
  };

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  Widget _buildFloatingActionButton() {
    return ScopedModelDescendant(
      builder: (BuildContext context, Widget child, MainModel model) {
        return FloatingActionButton(
          heroTag: 'blackFab',
          onPressed: () async {
            if (!_formKey.currentState.validate()) {
              return null;
            }
            _formKey.currentState.save();
            _formData['lat'] = model.currentLocation.lat;
            _formData['lng'] = model.currentLocation.lng;
            await model.submitBoarding(_formData);
            Navigator.pushReplacementNamed(context, '/BoardingFeedPage');
          },
          tooltip: 'Add a news',
          backgroundColor: Colors.black87,
          child: Icon(
            Icons.check,
            color: Colors.white,
          ),
        );
      },
    );
  }

  Widget _buildBoardingAddressFormField() {
    return TextFormField(
      controller: boardingAddressController,
      textAlign: TextAlign.left,
      maxLength: 150,
      maxLines: null,
      decoration: InputDecoration(
        fillColor: Colors.white,
        border: new OutlineInputBorder(
          borderRadius: new BorderRadius.circular(25.0),
          borderSide: new BorderSide(),
        ),
        filled: true,
        hintText: 'Boarding Address',
      ),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Address Cannot be empty';
        }
        return null;
      },
      onSaved: (String value) {
        _formData['address'] = value;
      },
    );
  }

  Widget _buildBoardingMemberCountFormField() {
    return TextFormField(
      keyboardType: TextInputType.number,
      controller: boardingMemberCountController,
      textAlign: TextAlign.center,
      maxLines: null,
      decoration: InputDecoration(
        fillColor: Colors.white,
        border: new OutlineInputBorder(
          borderRadius: new BorderRadius.circular(25.0),
          borderSide: new BorderSide(),
        ),
        filled: true,
        hintText: 'Boarding Member count',
      ),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Member count cannot be empty';
        }
        return null;
      },
      onSaved: (String value) {
        _formData['description'] = value;
      },
    );
  }

  Widget _buildBoardingDescriptionFormField() {
    return TextFormField(
      controller: boardingDescriptionController,
      textAlign: TextAlign.left,
      maxLines: null,
      decoration: InputDecoration(
        fillColor: Colors.white,
        border: new OutlineInputBorder(
          borderRadius: new BorderRadius.circular(25.0),
          borderSide: new BorderSide(),
        ),
        filled: true,
        hintText: 'Boarding Description',
      ),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Description Cannot be empty';
        }
        return null;
      },
      onSaved: (String value) {
        _formData['description'] = value;
      },
    );
  }

  Widget _buildNewsSubmitFormField() {
    return SingleChildScrollView(
      child: Container(
        padding:
            EdgeInsets.only(top: 30.0, left: 10.0, right: 10.0, bottom: 10.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Row(children: <Widget>[
                Text('Address :',
                    style:
                        TextStyle(fontSize: 25.0, fontWeight: FontWeight.w700)),
                Expanded(child: Container())
              ]),
              SizedBox(height: 10.0),
              _buildBoardingAddressFormField(),
              Row(
                children: <Widget>[
                  Text(
                    'Member count :',
                    style:
                        TextStyle(fontSize: 25.0, fontWeight: FontWeight.w700),
                  ),
                  Expanded(
                    child: Container(),
                  )
                ],
              ),
              SizedBox(height: 10.0),
              _buildBoardingMemberCountFormField(),
              SizedBox(height: 10.0),
              Row(
                children: <Widget>[
                  Text(
                    'Description :',
                    style:
                        TextStyle(fontSize: 25.0, fontWeight: FontWeight.w700),
                  ),
                  Expanded(
                    child: Container(),
                  )
                ],
              ),
              SizedBox(height: 10.0),
              _buildBoardingDescriptionFormField(),
              SizedBox(
                height: 10.0,
              ),
              Row(
                children: <Widget>[
                  Text(
                    'Location :',
                    style:
                        TextStyle(fontSize: 25.0, fontWeight: FontWeight.w700),
                  ),
                  Expanded(
                    child: Container(),
                  )
                ],
              ),
              SizedBox(height: 10.0),
              LocationInputFormField(widget._model),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      extendBody: true,
      body: _buildNewsSubmitFormField(),
      floatingActionButton: _buildFloatingActionButton(),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    if (widget._model.isEdit && widget.editableBoarding != null) {
      boardingAddressController.text = widget.editableBoarding.address;
      boardingMemberCountController.text =
          widget.editableBoarding.memberCount.toString();
      boardingDescriptionController.text = widget.editableBoarding.description;
    }
  }
}
