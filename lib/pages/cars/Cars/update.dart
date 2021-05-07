import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_sqlite/data/database-helper.dart';
import 'package:flutter_sqlite/pages/cars/User/car.dart';
// import 'package:flutter_sqlite/pages/login/cars/User/car.dart';
// import 'package:path_provider/path_provider.dart';
// import 'car.dart';
// import 'dbhelper.dart';




class MyUpdatePage extends StatefulWidget {
  @override
  _MyUpdatePageState createState() => _MyUpdatePageState();
}

class _MyUpdatePageState extends State<MyUpdatePage> {
  final dbHelper = DatabaseHelper.instance;
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
    final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  void _showMessageInScaffold(String message) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
        duration: Duration(seconds: 2),
        backgroundColor: Colors.blue,
        action: SnackBarAction(
          label: "Action",
          onPressed: () {
            // Code to execute.
          },
        ),
        content: Row(children: <Widget>[
          Icon(
            Icons.done,
            size: 26,
          ),
          SizedBox(
            width: 25,
          ),
          Text(
            message,
            style: TextStyle(fontSize: 22),
          ),
        ])));
  }

  List<Car> cars = [];
  List<Car> carsByName = [];
  bool onChangeColor1 = false;


  // /controllers used in update operation UI
  TextEditingController idUpdateController = TextEditingController();
  TextEditingController nameUpdateController = TextEditingController();
  TextEditingController milesUpdateController = TextEditingController();



    @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: Center(
         key: formkey,
          child: SingleChildScrollView(
                      child: Column(
              children: [
                Container(
                  height: 800,
                decoration: BoxDecoration(
                  image: const DecorationImage(
                    image: NetworkImage(
                        // 'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg'),
                        // 'https://www.freepik.com/free-vector/dark-hexagonal-background-with-gradient-color_12804207.htm'),
                        'https://i.postimg.cc/NLvj0T6m/white.jpg'),
                    // 'https://www.google.com/url?sa=i&url=https%3A%2F%2Fwallpapercave.com%2Fcool-car-mobile-hd-wallpapers&psig=AOvVaw3XPKlwyI6Wis37HF4BR40S&ust=1615371176114000&source=images&cd=vfe&ved=0CAIQjRxqFwoTCPC4ydL8ou8CFQAAAAAdAAAAABAD'),
                    fit: BoxFit.fill,
                  ),
                ),
                child: Center(
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(20),
                        child: TextField(
                          textInputAction: TextInputAction.next,
                          controller: idUpdateController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Car id',
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(20),
                        child: TextField(
                          textInputAction: TextInputAction.next,
                          controller: nameUpdateController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Car Name',
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(20),
                        child: TextField(
                          textInputAction: TextInputAction.done,
                          controller: milesUpdateController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Car Miles',
                          ),
                        ),
                      ),
                      RaisedButton(
                        color: Colors.blueGrey[300],
                        elevation: 10,
                        child: Text('Update Car Details'),
                        onPressed: () {
                          int id = int.parse(idUpdateController.text);
                          String name = nameUpdateController.text;
                          int miles = int.parse(milesUpdateController.text);
                          _update(id, name, miles);
                        },
                      ),
                    ],
                  ),
                ),
              ),

              ],
            ),
          ),
       ),
    );
  }
  
  void _update(id, name, miles) async {
    // row to update
    Car car = Car(id, name, miles);
    final rowsAffected = await dbHelper.update(car);
    _showMessageInScaffold('updated $rowsAffected row(s)');
  }
}