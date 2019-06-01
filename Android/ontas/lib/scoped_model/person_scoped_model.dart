import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:http/http.dart';
import 'package:http_parser/http_parser.dart';
import 'package:ontas/constants/firebase_child_reference.dart';
import 'package:ontas/constants/variables.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:ontas/model/user.dart';
import 'package:http/http.dart' as http;

mixin LostPersonScopedModel on Model {
  final DatabaseReference lostPersonDatabase = FirebaseReference.getReference('lostperson');

  registerMyFriend(File lostPersonPhoto, Map<String, dynamic> jsonPerson) async {
    String uuid;
      http.StreamedResponse res = await _addImage(lostPersonPhoto);
      //TODO: Leer res y sacar el uuid
    lostPersonDatabase.set({
      uuid: {'person': jsonPerson}
    });
  }

  Future<http.StreamedResponse> _addImage(File lostPersonPhoto) {
    var url = Uri.parse('http://138.68.51.122:5000/upload');
    var request = new http.MultipartRequest("POST", url);
    request.headers['content-type'] = 'multipart/form-data';
    request.files.add(new http.MultipartFile.fromBytes("data", lostPersonPhoto.readAsBytesSync(),
        contentType: MediaType.parse('multipart/form-data'), filename: 'data'));
    return request.send();
  }
}
