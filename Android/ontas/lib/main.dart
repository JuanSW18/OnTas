import 'package:flutter/material.dart';
import 'package:ontas/pages/login.dart';
import 'package:ontas/scoped_model/main_model.dart';
import 'package:scoped_model/scoped_model.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModel<MainModel>(
        model: MainModel(),
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'OnTas',
            theme: ThemeData(primarySwatch: Colors.amber, scaffoldBackgroundColor: Colors.white),
            home: LoginPage()));
  }
}
