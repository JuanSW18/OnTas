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
  Map<dynamic, dynamic> personFound;
  final DatabaseReference lostPersonDatabase = FirebaseReference.getReference('lostperson');

  registerMyFriend(File lostPersonPhoto, Map<String, dynamic> jsonPerson) async {
    http.StreamedResponse streamedResponse = await _uploadImage(lostPersonPhoto);
    http.Response res = await http.Response.fromStream(streamedResponse);
    Map<dynamic, dynamic> map = json.decode(res.body);
    lostPersonDatabase.set({
      map['uuid']: {'person': jsonPerson}
    });
  }

  Future<bool> findMyFriend(File lostPersonPhoto, Map<String, dynamic> jsonPerson) async {
    http.StreamedResponse streamedResponse = await _matchImage(lostPersonPhoto);
    http.Response res = await http.Response.fromStream(streamedResponse);
    Map<dynamic, dynamic> map = json.decode(res.body);
    String uuid = map['uuid'];
    if (uuid != null) {
      DataSnapshot dataSnapshot = await lostPersonDatabase.child(uuid).once();
      if (dataSnapshot.value != null) {
        personFound = dataSnapshot.value['person'];
        return true;
      } else {
        return false;
      }
    }
    return false;
  }

  Future<http.StreamedResponse> _uploadImage(File lostPersonPhoto) {
    var url = Uri.parse('http://138.68.51.122:5000/upload');
    var request = new http.MultipartRequest("POST", url);
    request.headers['content-type'] = 'multipart/form-data';
    request.files.add(new http.MultipartFile.fromBytes("data", lostPersonPhoto.readAsBytesSync(),
        contentType: MediaType.parse('multipart/form-data'), filename: 'data'));
    return request.send();
  }

  Future<http.StreamedResponse> _matchImage(File lostPersonPhoto) {
    var url = Uri.parse('http://138.68.51.122:5000/match');
    var request = new http.MultipartRequest("POST", url);
    request.headers['content-type'] = 'multipart/form-data';
    request.files.add(new http.MultipartFile.fromBytes("data", lostPersonPhoto.readAsBytesSync(),
        contentType: MediaType.parse('multipart/form-data'), filename: 'data'));
    return request.send();
  }
}
