import 'package:flutter/material.dart';
import 'package:flutter_sqlite/pages/cars/Cars/Homepage.dart';
// import 'package:flutter_sqlite/pages/home_page.dart';
// import 'package:flutter_sqlite/pages/login/Homepage.dart'; 
// import 'package:flutter_sqlite/pages/login/cars/main.dart';
// import 'package:flutter_sqlite/pages/login/cars/main.dart';
import 'package:flutter_sqlite/pages/login/login_page.dart';
import 'package:flutter_sqlite/pages/login/register.dart';
import 'package:flutter_sqlite/pages/main.dart';

void main() => runApp(MyApp());

final routes = {
  '/login': (BuildContext context) => new LoginPage(),
  '/home': (BuildContext context) => new MyApps(),
  '/register': (BuildContext context) => new RegisterPage(),
  '/': (BuildContext context) => new LoginPage(),
    // '/log': (BuildContext context) => new MyApps(),
};

class MyApp extends StatelessWidget {
 
 @override
 Widget build(BuildContext context){
   return new MaterialApp(
     debugShowCheckedModeBanner: false,
     title: ' App',
     theme: new ThemeData(primarySwatch: Colors.purple),
     routes: routes,
   );
 }
}
