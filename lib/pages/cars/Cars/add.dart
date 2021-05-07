

import 'package:flutter/material.dart';
import 'package:flutter_sqlite/data/database-helper.dart';
import 'package:flutter_sqlite/pages/cars/User/car.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:flutter_sqlite/pages/login/cars/User/car.dart';
// import 'car.dart';
// import 'dbhelper.dart';




class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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

  // String names;
  

  List<Car> cars = [];
  List<Car> carsByName = [];
  bool onChangeColor1 = false;
  String name, miles;
   TextEditingController nameController = TextEditingController();
  TextEditingController milesController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: Center(
         key: formkey,
          child: SingleChildScrollView(
                      child: Column(
              
              children: [
                Center(
                child: Container(
                  height: 800,
                  decoration: BoxDecoration(
                    image: const DecorationImage(
                      image: NetworkImage(
                          // 'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg'),
                          // 'https://www.freepik.com/free-vector/dark-hexagonal-background-with-gradient-color_12804207.htm'),
                          'https://i.postimg.cc/XqFfrfCg/ff9.jpg'),
                      // 'https://www.google.com/url?sa=i&url=https%3A%2F%2Fwallpapercave.com%2Fcool-car-mobile-hd-wallpapers&psig=AOvVaw3XPKlwyI6Wis37HF4BR40S&ust=1615371176114000&source=images&cd=vfe&ved=0CAIQjRxqFwoTCPC4ydL8ou8CFQAAAAAdAAAAABAD'),
                      fit: BoxFit.fill,
                    ),
                  ),
                  child: Column(
                    children: <Widget>[
          //              Padding(
          //   padding: EdgeInsets.all(30),
          //   child: Text('names', style: TextStyle(fontSize: 18)),
          // ),
          SizedBox(height: 50,),
                      Padding(
                        padding: EdgeInsets.all(20),
                        child: InkWell(
                          child: Container(
                            color: onChangeColor1 ? Colors.white : null,
                            padding: EdgeInsets.all(0),
                            // decoration: BoxDecoration(
                            //   image: const DecorationImage(
                            //     image: NetworkImage(
                            //         'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg'),
                            //     fit: BoxFit.fill,
                            //   ),
                            // ),
                            child: TextField(
                              textInputAction: TextInputAction.next,
                              controller: nameController,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Car Name',
                                  hintText: 'Car Name'),
                              // onTap: () {
                              //   setState(() {
                              //     onChangeColor1 = true;
                              //   });
                              // },
                              onEditingComplete: () {
                                setState(() {
                                  onChangeColor1 = false;
                                });
                              },
                              onSubmitted: (value) {
                                setState(() {
                                  onChangeColor1 = false;
                                });
                              },
                            ),
                          ),
                          onTap: () {
                            setState(() {
                              onChangeColor1 = true;
                            });
                          },
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(20),
                        child: TextField(
                          textInputAction: TextInputAction.done,
                          controller: milesController,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Car Miles',
                              hintText: 'Car Miles'),
                        ),
                      ),
                      RaisedButton(
                        color: Colors.blueGrey[300],
                        child: Text('Insert Car Details'),
                        onPressed: () {
                          String name = nameController.text;
                          int miles = int.parse(milesController.text);
                          _insert(name, miles);
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
    void _insert(name, miles) async {
    // row to insert
    Map<String, dynamic> row = {
      // DatabaseHelper.columnName: name,
      DatabaseHelper.columnMiles: miles
    };
    Car car = Car.fromMap(row);
    final id = await dbHelper.add(car);
    _showMessageInScaffold('inserted row id: $id');
  }
}