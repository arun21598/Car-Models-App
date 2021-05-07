import 'package:flutter/material.dart';

// import '../Homepage.dart';
import 'cars/Cars/Homepage.dart';

// import '../home_page.dart';

// import '../../home_page.dart';

// import 'Homepage.dart';
// import 'home.dart';

// void main() => runApp(MyApp());



class MyApps extends StatefulWidget {
  @override
  _MyAppsState createState() => _MyAppsState();
}

class _MyAppsState extends State<MyApps> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp( 
      debugShowCheckedModeBanner: false,
        title: 'Liquorie',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomesPage());
  }
}



