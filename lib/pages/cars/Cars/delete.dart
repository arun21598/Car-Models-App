
import 'package:flutter/material.dart';
import 'package:flutter_sqlite/data/database-helper.dart';
import 'package:flutter_sqlite/pages/cars/User/car.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:flutter_sqlite/pages/login/cars/User/car.dart';
// import 'car.dart';
// import 'dbhelper.dart';




class MyDeletePage extends StatefulWidget {
  @override
  _MyDeletePageState createState() => _MyDeletePageState();
}

class _MyDeletePageState extends State<MyDeletePage> {
  final dbHelper = DatabaseHelper.instance;
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
    final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

      TextEditingController idDeleteController = TextEditingController();

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

  String name;

   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPref();
  }

  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      name = preferences.getString("names");
      print(name);
      
    });
  }


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
                    image:  AssetImage("assets/images/car_screen.png"),
                  fit: BoxFit.fill,
                  ),
                ),
                child: SingleChildScrollView(
                  child: Center(
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(20),
                          child: TextField(
                            controller: idDeleteController,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Car id',
                                hintText: 'Car id'),
                          ),
                        ),
                        Container(
                          child: SizedBox(
                            height: 30,
                            width: 100,
                            child: RaisedButton(
                              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                              color: Colors.blueGrey[300],
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    'Delete',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                    child: Icon(
                                      Icons.delete_forever,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                              onPressed: () {
                                int id = int.parse(idDeleteController.text);
                                _delete(id);
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              ],
            ),
          ),
       ),
    );
  }

  void _delete(id) async {
    // Assuming that the number of rows is the id for the last row.
    final rowsDeleted = await dbHelper.delete(id);
    _showMessageInScaffold('deleted $rowsDeleted row(s): row $id');
  }

}
