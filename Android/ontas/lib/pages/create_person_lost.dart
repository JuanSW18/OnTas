import 'package:flutter/material.dart';
import 'package:ontas/scoped_model/main_model.dart';

class CreatePersonLostPage extends StatefulWidget {

  MainModel _model;

  CreatePersonLostPage(this._model);

  @override
  _CreatePersonLostPageState createState() => _CreatePersonLostPageState();
}

class _CreatePersonLostPageState extends State<CreatePersonLostPage> {

  var lostPersonNameController = TextEditingController();
  BuildContext _context;

  @override
  Widget build(BuildContext context) {
    _context = context;
    return Scaffold(
      appBar: AppBar(title: Text(""), centerTitle: true),
      body: Container(
        margin: EdgeInsets.only(top: 100.0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Text('Ingresa tu usuario', style: TextStyle(fontSize: 20.0)),
              SizedBox(height: 10.0),
              _buildInputUsername(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputUsername() {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 8.0),
        child: TextField(
          controller: lostPersonNameController,
          textAlign: TextAlign.center,
          maxLength: 12,
          decoration: InputDecoration(
            hintStyle: new TextStyle(color: Colors.grey[600]),
            filled: true,
            fillColor: Colors.white,
            border: new OutlineInputBorder(
              borderRadius: const BorderRadius.all(
                const Radius.circular(50.0),
              ),
            ),
          ),
        ));
  }

}
