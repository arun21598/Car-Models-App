import 'package:flutter/material.dart';
import 'package:flutter_sqlite/data/database-helper.dart';
import 'package:flutter_sqlite/models/user.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => new _RegisterPageState();
}

class _RegisterPageState  extends State<RegisterPage> {
  BuildContext _ctx;
  bool _isLoading = false;
  final formKey = new GlobalKey<FormState>();
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  String name, mail, pass;



TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmpassword = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController ages = TextEditingController();
  TextEditingController degree = TextEditingController();
  TextEditingController university = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _ctx = context;
    
    var loginBtn = new   Container(
                height: 40,
                width: 250,
                decoration: BoxDecoration(
                    color: Colors.deepPurple,
                    borderRadius: BorderRadius.circular(20)),
     child:new RaisedButton(
      onPressed: _submit,
      // child: new Text("Register"),
      color: Colors.deepPurple[600],
      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0),
                        side: BorderSide(color: Colors.deepPurple)
                    ),
                    textColor:Colors.white,child: Text("Register"),
    ),
    );


    var loginForm = new Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        // new Text(
        //   // "Sqflite App Login",
        //   // textScaleFactor: 2.0,
        // ),
        SizedBox(height: 50,),
        new Form(
          key: formKey,
          child:Container(
            //  decoration: BoxDecoration(
            //     image: const DecorationImage(
            //        image: AssetImage("assets/images/car_screen.png"),
            //       fit: BoxFit.fill,
            //     ),
            //   ),
          child: new Column(
            children: <Widget>[
          //                   Padding(
          //       padding: const EdgeInsets.only(top: 60.0),
          //       child: Center(
          //         child: Container(
          //            decoration: BoxDecoration(
          // image: DecorationImage(
          //   image: AssetImage("assets/images/car_screen.png"),
          //   fit: BoxFit.cover,
          //            ),
          //         ),
          //           ),
          //       ),
          //     ),

                // Image.asset("assets/images/car_screen.png") ,
              
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Username',
                      hintText: 'Enter username'),
                  validator:(String value){
                      if(value.isEmpty)
                      {
                        return 'Please Enter Name';
                      }
                      return null;
                    },
                     onSaved: (val) => name = val,
                    //  onSaved: (String value){
                    //   name = value;
                    // },
                  controller: username,
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                      hintText: 'Enter valid email id as abc@gmail.com'),
                  validator: (String value){
                      if(value.isEmpty)
                      {
                        return 'Please a Enter';
                      }
                      if(!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)){
                        return 'Please a valid Email';
                      }
                      return null;
                    },
                     onSaved: (val) => mail = val,
                    // onSaved: (String value){
                    //   mail = value;
                    // },
                  controller: email,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                child: TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                      hintText: 'Enter secure password'),
                  validator: MultiValidator([
                    RequiredValidator(errorText: "* Required"),
                    MinLengthValidator(6,
                        errorText: "Password should be atleast 6 characters"),
                    MaxLengthValidator(15,
                        errorText:
                            "Password should not be greater than 15 characters")
                  ]),
                   onSaved: (val) => pass = val,
                  controller: password,
                ),
              ),
               Container(
                padding: const EdgeInsets.all(10),
                child: TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Confirm Password',
                      hintText: 'Enter correct password'),
                  validator: (String value){
                      if(value.isEmpty)
                      {
                        return 'Please a Re-enter Password';
                      }
                       print(password.text);
                      print(confirmpassword.text);
                      if(password.text!=confirmpassword.text){
                        return "Password does not match";
                      }
                      return null;
                    },
                   
                  controller:confirmpassword,
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'age',
                      hintText: 'age'),
                  validator: MultiValidator([
                    RequiredValidator(errorText: "* Required"),
                  ]),
                  controller: ages,
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Address',
                      hintText: 'Address'),
                  validator: MultiValidator([
                    RequiredValidator(errorText: "* Required"),
                  ]),
                  controller: degree,
                ),
              ),
            
              
   
            ],
          ),
          ),
        ),
        SizedBox(height:30),
        loginBtn,
          SizedBox(height:100),
      ],
    );

    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Register"),
      ),
      
      // key: scaffoldKey,
          // child: new
      body: Container(
        decoration: BoxDecoration(
                image: const DecorationImage(
                   image: AssetImage("assets/images/white_car.png"),
                  fit: BoxFit.fill,
                ),
              ),
          
      child:SingleChildScrollView(
      // child: new Container(
      //   decoration: BoxDecoration(
      //           image: const DecorationImage(
      //              image: AssetImage("assets/images/car_screen.png"),
      //             fit: BoxFit.fill,
      //           ),
      //         ),
        child:  Center(
          //  child:Container(
             
          child: loginForm,
        ),
      // ),
      ),
      ),
    );
  }

  void _showSnackBar(String text) {
    scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text(text),
    ));
  }

  void _submit() async{
    final form = formKey.currentState;


    if (form.validate()) {
      setState(() {
        _isLoading = true;
         savePref(name);
        form.save();
        var user = new User(name, mail, pass,null);
        var db = new DatabaseHelper();
        db.saveUser(user);
        _isLoading = false;
        Navigator.of(context).pushNamed("/login");
      });
    }
  }
  
   
  savePref(String name) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setString("name", name);
      print(name);
      // preferences.setString("pass", pass);
      // ignore: deprecated_member_use
      preferences.commit();
    });
  }
}