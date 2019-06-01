import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ontas/components/image_input.dart';
import 'package:ontas/scoped_model/main_model.dart';
import 'package:scoped_model/scoped_model.dart';

class SearchPersonPage extends StatelessWidget {
  final _respondToNameController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {
      return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Text(''),
            elevation: 0.0,
          ),
          body: ListView(
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
                  Text('Encontré a ...',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 36)),
                  TextField(
                    controller: _respondToNameController,
                    decoration: InputDecoration(labelText: 'Responde al nombre de:'),
                  ),
                  TextField(
                    controller: _descriptionController,
                    maxLines: 5,
                    decoration: InputDecoration(
                      labelText: 'Pequeña descripción:',
                    ),
                    maxLength: 500,
                  ),
                  Text('Foto de la persona encontrada:'),
                  SizedBox(height: 20),
                  ImageInput(
                      onSave: (File imageFileSource) {
                        print('holi');
// _setImageFile(imageFileSource);
                      },
                      actualImage: null,
                      onlyCam: false),
                  SizedBox(height: 30),
                  Container(
                    alignment: Alignment.centerRight,
                    child: RaisedButton(
                        child: Container(
                          alignment: Alignment.center,
                          child: Text('REPORTAR', style: TextStyle(fontWeight: FontWeight.bold)),
                          width: 150,
                        ),
                        onPressed: () {
                          Map<String, dynamic> jsonPerson = {
                            'respondToName': _respondToNameController.text,
                            'description': _descriptionController.text
                          };
//                          model.registerMyFriend(model.authenticatedUser.id, jsonPerson);
                        },
                        color: Colors.amber),
                  ),
                ]),
              ),
            ],
          ));
    });
  }
}
