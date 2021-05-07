
import 'package:flutter/material.dart';
import 'package:flutter_sqlite/data/database-helper.dart';
import 'package:flutter_sqlite/pages/cars/User/car.dart';
// import 'package:flutter_sqlite/pages/login/cars/User/car.dart';
// import 'car.dart';
// import 'dbhelper.dart';




class MySearchPage extends StatefulWidget {
  @override
  _MySearchPageState createState() => _MySearchPageState();
}

class _MySearchPageState extends State<MySearchPage> {
  final dbHelper = DatabaseHelper.instance;
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
    final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

      TextEditingController queryController = TextEditingController();

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
                        'https://i.postimg.cc/rpF75mg4/silver.jpg'),
                    // 'https://www.google.com/url?sa=i&url=https%3A%2F%2Fwallpapercave.com%2Fcool-car-mobile-hd-wallpapers&psig=AOvVaw3XPKlwyI6Wis37HF4BR40S&ust=1615371176114000&source=images&cd=vfe&ved=0CAIQjRxqFwoTCPC4ydL8ou8CFQAAAAAdAAAAABAD'),
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
                            controller: queryController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Car Name',
                            ),
                            onChanged: (text) {
                              if (text.length >= 2) {
                                setState(() {
                                  _query(text);
                                });
                              } else {
                                setState(() {
                                  carsByName.clear();
                                });
                              }
                            },
                          ),
                          height: 100,
                        ),
                        Container(
                          height: 300,
                          child: ListView.builder(
                            padding: const EdgeInsets.all(8),
                            itemCount: carsByName.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                height: 50,
                                margin: EdgeInsets.all(2),
                                child: Center(
                                  child: Text(
                                    '[${carsByName[index].id}] ${carsByName[index].name} - ${carsByName[index].miles} miles',
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                              );
                            },
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
  void _query(name) async {
    final allRows = await dbHelper.queryRows(name);
    carsByName.clear();
    allRows.forEach((row) => carsByName.add(Car.fromMap(row)));
  }
}
