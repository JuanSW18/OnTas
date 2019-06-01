import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:ontas/model/user.dart';

mixin UserScopedModel on Model {
  User authenticatedUser;

  Future<Map<String, dynamic>> loginWithEmail(bool login, Map<String, dynamic> authData) async {
    Response res;
    if (login) {
      res = await post(
          'https://www.googleapis.com/identitytoolkit/v3/relyingparty/verifyPassword?key=AIzaSyB3w8AMnOLzzeUA4dS7U51LsMm-PTWx32k',
          body: json.encode(authData),
          headers: {'Content-Type': 'application/json'});
    } else {
      res = await post(
          'https://www.googleapis.com/identitytoolkit/v3/relyingparty/signupNewUser?key=AIzaSyB3w8AMnOLzzeUA4dS7U51LsMm-PTWx32k',
          body: json.encode(authData),
          headers: {'Content-Type': 'application/json'});
    }
    final Map<String, dynamic> responseData = json.decode(res.body);
    return await _checkLoginWithEmail(responseData, authData['email']);
  }

  Future<Map<String, dynamic>> _checkLoginWithEmail(
      Map<String, dynamic> responseData, String email) async {
    bool hasError = true;
    String message = 'Ocurrió un error';
    if (responseData.containsKey('idToken')) {
      hasError = false;
      message = 'Autenticación exitosa.';
      authenticatedUser =
          User(id: responseData['localId'], email: email, token: responseData['idToken']);
    } else if (responseData['error']['message'] == 'EMAIL_NOT_FOUND') {
      message = 'Este correo no fue encontrado.';
    } else if (responseData['error']['message'] == 'INVALID_PASSWORD') {
      message = 'Contraseña inválida.';
    } else if (responseData['error']['message'] == 'EMAIL_EXISTS') {
      message = 'Este correo ya existe';
    }

    return {'success': !hasError, 'message': message};
  }

  void logout() async {
    authenticatedUser = null;
  }
}
