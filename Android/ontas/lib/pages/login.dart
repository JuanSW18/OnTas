import 'package:flutter/material.dart';
import 'package:ontas/components/custom_scroll_color.dart';
import 'package:ontas/constants/colors';
import 'package:ontas/pages/home.dart';
import 'package:ontas/scoped_model/main_model.dart';
import 'package:scoped_model/scoped_model.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController(text: '');
  final _passwordController = TextEditingController(text: '');
  final _confirmPasswordController = TextEditingController(text: '');
  bool login = true;
  bool _passwordsNotMatched = false;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: _isLoading ? Colors.white : Colors.amber,
        body: _isLoading
            ? Center(
                child: Column(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
                CircularProgressIndicator(),
                SizedBox(height: 10.0),
                Text('Iniciando sesión')
              ]))
            : ScopedModelDescendant<MainModel>(
                builder: (BuildContext context, Widget child, MainModel model) {
                return CustomScrollColor(
                    child: Stack(
                  children: <Widget>[
                    Positioned(top: 360,left: 120,child: Image.asset('assets/logo_background.png'),),
                    ListView(children: <Widget>[
                      SizedBox(height: 50.0),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        child: Text(
                          'Bienvenidos a Ontas',
                          style: TextStyle(fontSize: 46, fontWeight: FontWeight.bold,height: 0.8),
                        ),
                      ),
//                  Center(
//                      child: Icon(CustomIcons.water_amount_large, color: Colors.white, size: 80)),
                      SizedBox(height: 30.0),
                      _buildEmailLoginForm(model),
                      _buildLoginOrSignUp(),

                      SizedBox(height: 20.0),
                      _buildTermsAndConditions()
                    ])
                  ],
                ));
              }));
  }

  Widget _buildEmailLoginForm(MainModel model) {
    return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        elevation: 4.0,
        margin: new EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: Form(
            key: _formKey,
            child: SingleChildScrollView(
                padding: EdgeInsets.all(20.0),
                child: Column(children: <Widget>[
                  _buildEmailTextField(),
                  _buildPasswordTextField(),
                  login ? Container() : _buildConfirmPassword(),
                  SizedBox(height: 10.0),
                  Divider(),
                  _buildLoginSignUpButton(model)
                ]))));
  }

  Widget _buildEmailTextField() {
    return TextFormField(
        controller: _emailController,
        decoration: InputDecoration(helperText: 'Correo', counterText: ''),
        maxLength: 25,
        validator: (String value) {
          if (value.isEmpty || !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
            return 'El correo ingresado no cumple el formato ';
          }
        });
  }

  Widget _buildPasswordTextField() {
    return TextField(
        controller: _passwordController,
        decoration: InputDecoration(
            helperText: 'Contraseña',
            counterText: '',
            errorText: _passwordsNotMatched ? 'Las contraseñas no coinciden' : null),
        obscureText: true,
        maxLength: 20);
  }

  Widget _buildConfirmPassword() {
    return TextField(
        controller: _confirmPasswordController,
        decoration: InputDecoration(
            helperText: 'Confirmar contraseña',
            counterText: '',
            errorText: _passwordsNotMatched ? 'Las contraseñas no coinciden' : null),
        obscureText: true,
        maxLength: 20);
  }

  Widget _buildLoginSignUpButton(MainModel model) {
    return Container(
        width: MediaQuery.of(context).size.width,
        child: FlatButton(
            child: Text(login ? 'INGRESAR' : 'CREAR CUENTA'),
            onPressed: () => _emailAuthenticate(model),
            color: Colors.amber));
  }

  Widget _buildLoginOrSignUp() {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
      Text(login ? '¿Aún no tienes cuenta? ' : '¿Ya tienes cuenta? '),
      InkWell(
        onTap: toggleLoginToCreateAccount,
        child: Text(login ? 'Regístrate' : 'Inicia Sesión',
            style: TextStyle(fontWeight: FontWeight.bold)),
      )
    ]);
  }

  Widget _buildTermsAndConditions() {
    return Center(
      child: InkWell(
        //TODO:Link to terms and conditions
        onTap: () {},
        child: Text('Términos y condiciones', style: TextStyle(fontSize: 13.0)),
      ),
    );
  }

  toggleLoginToCreateAccount() {
    setState(() {
      login = !login;
      _formKey.currentState.reset();
      _emailController.text = '';
      _passwordController.text = '';
      _confirmPasswordController.text = '';
      _passwordsNotMatched = false;
    });
  }

  bool _confirmPassword() {
    return _passwordController.text == _confirmPasswordController.text;
  }

  _emailAuthenticate(MainModel model) async {
    if (!login && !_confirmPassword()) {
      setState(() {
        _passwordsNotMatched = true;
        _isLoading = false;
        if (!_formKey.currentState.validate()) {
          return;
        }
        return;
      });
    } else {
      if (!_formKey.currentState.validate()) {
        setState(() {
          _isLoading = false;
        });
        return;
      } else {
        setState(() {
          _isLoading = true;
        });
        final Map<String, dynamic> authData = {
          'email': _emailController.text,
          'password': _passwordController.text
        };
        Map<String, dynamic> successInformation = await model.loginWithEmail(login, authData);
        if (successInformation['success']) {
          _goToPlantsManagerPage(model);
        } else {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                    title: Text('Ocurrió un error'),
                    content: Text(successInformation['message']),
                    actions: <Widget>[
                      FlatButton(
                          child: Text('ESTA BIEN'),
                          onPressed: () {
                            Navigator.pop(context);
                          })
                    ]);
              });
        }
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  _goToPlantsManagerPage(Model model) => Navigator.pushReplacement(
      context, MaterialPageRoute<bool>(builder: (BuildContext context) => HomePage()));
}
