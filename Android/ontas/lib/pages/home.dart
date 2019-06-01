import 'package:flutter/material.dart';
import 'package:ontas/pages/login.dart';
import 'package:ontas/scoped_model/main_model.dart';
import 'package:scoped_model/scoped_model.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {
      return Scaffold(
          appBar: AppBar(
            title: Text('ONTAS!!!!'),
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
                  Container(child: Icon(Icons.person, size: 100.0)),
                  SizedBox(height: 160),
                  RaisedButton(
                      child: Container(
                          alignment: Alignment.center,
                          child: Text('Perdí a una persona',
                              style: TextStyle(fontWeight: FontWeight.w600)),
                          width: 300),
                      onPressed: () {},
                      color: Colors.amber),
                  RaisedButton(
                      child: Container(
                          alignment: Alignment.center,
                          child: Text('Encontré una persona',
                              style: TextStyle(fontWeight: FontWeight.w600)),
                          width: 300),
                      onPressed: () {},
                      color: Colors.amber)
                ]),
          ));
      ;
    });
  }
}
