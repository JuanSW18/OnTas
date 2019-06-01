import 'package:flutter/material.dart';
import 'package:ontas/pages/create_person_lost.dart';
import 'package:ontas/pages/login.dart';
import 'package:ontas/pages/person_found.dart';
import 'package:ontas/pages/search_person_lost.dart';
import 'package:ontas/scoped_model/main_model.dart';
import 'package:scoped_model/scoped_model.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {
      return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Text(''),
            elevation: 0.0,
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.exit_to_app),
                onPressed: () {
                  model.logout();
                  Navigator.pushReplacement(context,
                      MaterialPageRoute<bool>(builder: (BuildContext context) => LoginPage()));
                },
              )
            ],
          ),
          body: Center(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(child: Image.asset('assets/logo.png')),
                  SizedBox(height: 160),
                  RaisedButton(
                      child: Container(
                          alignment: Alignment.center,
                          child: Text('Perdí a una persona',
                              style: TextStyle(fontWeight: FontWeight.w600)),
                          width: 300),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute<bool>(
                                builder: (BuildContext context) => CreatePersonLostPage()));
                      },
                      color: Colors.amber),
                  RaisedButton(
                      child: Container(
                          alignment: Alignment.center,
                          child: Text('Encontré una persona',
                              style: TextStyle(fontWeight: FontWeight.w600)),
                          width: 300),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute<bool>(
                                builder: (BuildContext context) => SearchPersonPage()));
                      },
                      color: Colors.amber)
                ]),
          ));
    });
  }
}
