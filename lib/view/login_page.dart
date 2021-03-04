import 'package:demo_project/constants/input_decoration.dart';
import 'package:flutter/material.dart';

import 'menu.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  String email = "";
  String passsword = "";
  String error = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 231, 75, 35),
        title: Text("Login"),
      ),
      body: buildBody(context),
    );
  }

  Container buildBody(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
      child: Form(
          key: formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.0),
              buildLogo(),
              SizedBox(height: 40.0),
              buildEmailTextFormField(),
              SizedBox(height: 20.0),
              buildPasswordTextFormField(),
              SizedBox(height: 30.0),
              buildLoginRaisedButton(context),
              SizedBox(height: 12.0),
              buildErrorText(),
            ],
          )),
    );
  }

  Text buildErrorText() {
    return Text(
      error,
      style: TextStyle(color: Color.fromARGB(255, 231, 75, 35), fontSize: 14.0),
    );
  }

  RaisedButton buildLoginRaisedButton(BuildContext context) {
    return RaisedButton(
      onPressed: () {
        if (formKey.currentState.validate()) {
          formKey.currentState.save();
          Navigator.push(context,
              MaterialPageRoute(builder: (BuildContext context) => MenuPage()));
        }
      },
      color: Color.fromARGB(255, 231, 75, 35),
      child: Text(
        "LOGIN",
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  TextFormField buildPasswordTextFormField() {
    return TextFormField(
      decoration: textInputDecoration.copyWith(hintText: "Password"),
      obscureText: true,
      validator: (value) => value.length < 6
          ? "The password should be 6 characters at least!"
          : null,
      onChanged: (value) {
        setState(() {
          email = passsword;
        });
      },
    );
  }

  TextFormField buildEmailTextFormField() {
    return TextFormField(
      decoration: textInputDecoration.copyWith(hintText: "Email"),
      validator: (value) => value.isEmpty ? "Please enter a valid email" : null,
      onChanged: (value) {
        setState(() {
          email = value;
        });
      },
    );
  }

  Flexible buildLogo() {
    return Flexible(
        child: Hero(
            tag: "logo",
            child: Container(
              child: Image.asset("images/eralpsoftware.png"),
            )));
  }
}
