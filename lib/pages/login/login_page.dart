// import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
// import 'package:flutter_sqlite/data/database-helper.dart';
import 'package:flutter_sqlite/models/user.dart';
// import 'package:flutter_sqlite/pages/cars/Cars/Homepage.dart';
import 'package:flutter_sqlite/pages/login/login_presenter.dart';
import 'package:form_field_validator/form_field_validator.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> implements LoginPageContract {
  BuildContext _ctx;
  bool _isLoading = false;
  final formKey = new GlobalKey<FormState>();
  final scaffoldKey = new GlobalKey<ScaffoldState>();


  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  String _email, _password,finalName;
  
  LoginPagePresenter _presenter;

  _LoginPageState() {
    _presenter = new LoginPagePresenter(this);
  }

  void _register() {
    Navigator.of(context).pushNamed("/register");
  }

  void _submit() {
    final form = formKey.currentState;

    if (form.validate()) {
      setState(() {
        _isLoading = true;
        form.save();
        _presenter.doLogin(_email, _password);
      });
    }
  }

  void _showSnackBar(String text) {
    scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: Text(text),
    ));
  }


  

  @override
  Widget build(BuildContext context) {
    _ctx = context;
    var loginBtn =  Container(
                height: 50,
                width: 250,
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(20)),
              
   child: new RaisedButton(
      onPressed: _submit,
      color: Colors.purple,
      child: Text(
                    'Login',
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
    ),);
    var registerBtn = InkWell(
                child: Text('New User? Create Account'),
                onTap: _register,
              );
    var loginForm = new Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        SizedBox(height: 20,),
         Text(
          "CAR MODELS",
          textScaleFactor: 2.0,
        ),
        new Form(
          key: formKey,
          child: new Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 60.0),
                child: Center(
                  child: Container(
                      width: 200,
                      height: 200,
                      child: Image.asset(
                          'assets/images/purple_car.png')),
                ),
              ),
              SizedBox(height: 10,),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: TextFormField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                      hintText: 'Enter valid email id as abc@gmail.com'),
                  validator: MultiValidator([
                    RequiredValidator(errorText: "* Required"),
                    EmailValidator(errorText: "Enter valid email id"),
                  ]),
                  controller: username,
                   onSaved: (val) => _email = val,
                ),
              ),
              SizedBox(height: 20,),
              Padding(
                // padding: const EdgeInsets.only(
                //     left: 15.0, right: 15.0, top: 15, bottom: 0),
                 padding: EdgeInsets.symmetric(horizontal: 30),
                child: TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                      hintText: 'Enter secure password'),
                  validator: MultiValidator([
                    RequiredValidator(errorText: "* Required"),
                    // MinLengthValidator(6,
                    //     errorText: "Password is incorrect"),
                    // MaxLengthValidator(15,
                    //     errorText:
                    //         "Password should not be greater than 15 characters")
                 
                  ]),
                  onSaved: (val) => _password = val,
                  controller: password,
                  //validatePassword,        //Function to check validation
                ),
              ),
              FlatButton(
                onPressed: () {
                  // TODO FORGOT PASSWORD SCREEN GOES HERE 
                },
                child: Text(
                  'Forgot Password',
                  style: TextStyle(color: Colors.purple, fontSize: 15),
                ),
              ),
              // Container(
              //   height: 50,
              //   width: 250,
              //   decoration: BoxDecoration(
              //       color: Colors.blue,
              //       borderRadius: BorderRadius.circular(20)),
              // ),
              // SizedBox(
              //   height: 20,
              // ),
            ],
          ),
        ),
        new Padding(
            padding: const EdgeInsets.all(10.0),
            child: loginBtn),

        registerBtn
      ],
    );

    return new Scaffold(
      appBar: new AppBar(
        title: Text("Login Page"),
        backgroundColor: Colors.deepPurple,
      ),
      key: scaffoldKey,
      body: SingleChildScrollView(
      child:new Container(
        child: new Center(
          child: loginForm,
        ),
      ),
      ),
    );
  }

  @override
  void onLoginError(String error) {
    // TODO: implement onLoginError
    _showSnackBar("Login not successful");
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void onLoginSuccess(User user) async {
    // TODO: implement onLoginSuccess
    if(user.username == ""){
      _showSnackBar("Login not successful");
    }else{
    _showSnackBar(user.toString());
    }
    setState(() {
      _isLoading = false;
    });
    if(user.flaglogged == "logged"){
      print("Logged");
      Navigator.of(context).pushNamed("/home");
      //  Navigator.push(context,MaterialPageRoute(builder:(context) {
      //    return HomesPage(user: user);
      //  }));
    }else{
      print("Not Logged");
    }
  }
}











