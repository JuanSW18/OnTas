import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('ONTAS!!!!'),
        ),
        body: Center(
            child: Text(
          'AQUI TAAAA!!',
          style: TextStyle(fontSize: 36.0),
        )));
  }
}
