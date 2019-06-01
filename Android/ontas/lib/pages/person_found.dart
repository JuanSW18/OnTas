import 'package:flutter/material.dart';
import 'package:ontas/pages/home.dart';
import 'package:ontas/scoped_model/main_model.dart';
import 'package:scoped_model/scoped_model.dart';

class PersonFound extends StatefulWidget {
  @override
  _PersonFoundState createState() => _PersonFoundState();
}

class _PersonFoundState extends State<PersonFound> {
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
                  Text('¡Felicitaciones!',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28)),
                  Text('Encontraste a ...',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 36)),
                  SizedBox(height: 20.0),
                  Center(
                      child: Text(model.personFound['respondToName'].toString(),
                          style: TextStyle(fontSize: 28))),
                  SizedBox(height: 40.0),
                  Text('Contactarse con:'),
                  Text(model.personFound['contactName'].toString(),
                      style: TextStyle(color: Colors.grey)),
                  SizedBox(height: 10.0),
                  Text('Número de contacto:'),
                  Text(model.personFound['contactPhone'].toString(),
                      style: TextStyle(color: Colors.grey)),
                  Container(
                      alignment: Alignment.centerRight,
                      child: RaisedButton(
                          child: Container(
                            alignment: Alignment.center,
                            child: Text('LISTO', style: TextStyle(fontWeight: FontWeight.bold)),
                            width: 150,
                          ),
                          onPressed: () {
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
