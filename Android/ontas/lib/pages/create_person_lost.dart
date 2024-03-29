import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ontas/components/image_input.dart';
import 'package:ontas/pages/home.dart';
import 'package:ontas/scoped_model/main_model.dart';
import 'package:scoped_model/scoped_model.dart';

class CreatePersonLostPage extends StatefulWidget {
  @override
  _CreatePersonLostPageState createState() => _CreatePersonLostPageState();
}

class _CreatePersonLostPageState extends State<CreatePersonLostPage> {
  var _lostPersonNameController = TextEditingController(text: "");
  var _lastPlaceSeenController = TextEditingController(text: "");
  var _nameContactController = TextEditingController(text: "");
  var _phoneContactController = TextEditingController(text: "");
  File _imageFile;

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {
      return Scaffold(
          appBar: AppBar(title: Text(''), backgroundColor: Colors.white, elevation: 0.0),
          body: ListView(children: <Widget>[
            Container(
                padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 5.0),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
                  Text('No encuentro a ...',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 36)),
                  TextField(
                    controller: _lostPersonNameController,
                    decoration: InputDecoration(labelText: 'Responde al nombre de:'),
                  ),
                  TextField(
                    controller: _lastPlaceSeenController,
                    decoration: InputDecoration(
                      labelText: 'Último lugar donde fue visto:',
                    ),
                  ),
                  TextField(
                    controller: _nameContactController,
                    decoration: InputDecoration(
                      labelText: 'Nombre de contacto:',
                    ),
                  ),
                  TextField(
                    controller: _phoneContactController,
                    decoration: InputDecoration(
                      labelText: 'Celular de contacto',
                    ),
                  ),
                  SizedBox(height: 30),
                  Text('Foto de la persona encontrada:'),
                  SizedBox(height: 30),
                  ImageInput(
                      onSave: (File imageFileSource) {
                        _imageFile = imageFileSource;
                      },
                      actualImage: null,
                      onlyCam: true),
                  SizedBox(height: 30),
                  Container(
                      alignment: Alignment.centerRight,
                      child: RaisedButton(
                          child: Container(
                            alignment: Alignment.center,
                            child: Text('REGISTRAR', style: TextStyle(fontWeight: FontWeight.bold)),
                            width: 150,
                          ),
                          onPressed: () {
                            Map<String, dynamic> jsonPerson = {
                              'respondToName': _lostPersonNameController.text,
                              'lastPlaceSeen': _lastPlaceSeenController.text,
                              'contactName': _nameContactController.text,
                              'contactPhone': _phoneContactController.text
                            };
                            model.registerMyFriend(_imageFile, jsonPerson);
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute<bool>(
                                    builder: (BuildContext context) => HomePage()));
                          },
                          color: Colors.amber))
                ]))
          ]));
    });
  }
}
