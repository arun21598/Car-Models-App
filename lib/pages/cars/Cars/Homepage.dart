
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_sqlite/models/user.dart';
import 'package:flutter_sqlite/pages/cars/Cars/search.dart';
import 'package:flutter_sqlite/pages/cars/Cars/update.dart';
import 'package:flutter_sqlite/pages/login/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'add.dart';
import 'delete.dart';
// import 'package:flutter_sqlite/pages/login/cars/car%20pages/search.dart';
// import 'package:flutter_sqlite/pages/login/cars/car%20pages/update.dart';

// import '../home_page.dart';
// import 'cars/car pages/delete.dart';



class HomesPage extends StatefulWidget {
   User user;
  HomesPage({Key key,@required user}) : super(key: key);

  @override
  HomesPageState createState() => HomesPageState(user);
}

class HomesPageState extends State<HomesPage> {
  String get obtainedName => null;
 final User user;
 HomesPageState(this.user);




  int _selectedIndex = 0;
  final List<Widget> _options = <Widget>[
    new MyHomePage(),
    new MySearchPage(),
    // new MyModelPage(),
    new MyUpdatePage(),
    new MyDeletePage(),
  ];
  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  String name;

   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // print('userobject $user ${user.username}');
    getPref();
  }

  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      name = preferences.getString("name");
      print('inside function $name');
      
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title:  Text('Welcome '),
          actions: <Widget>[
            IconButton(icon: Icon(Icons.logout), onPressed: (){
              setState(() {
                // token = null;
              });
              Navigator.push(context,
                            MaterialPageRoute(builder: (_) => LoginPage()));
            }),
          ],
          // title:Text(name),
          backgroundColor: Colors.deepPurpleAccent
      ),
      body: Center(
        child: _options.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.add),
                label: 'Car',
                backgroundColor: Colors.deepPurpleAccent
            ),
             BottomNavigationBarItem(
                icon: Icon(Icons.search_off),
                label: 'Search',
                backgroundColor: Colors.deepPurpleAccent
            ),
            // BottomNavigationBarItem(
            //     icon: Icon(Icons.person),
            //     label: 'List',
            //     backgroundColor: Colors.deepPurpleAccent
            // ),
            BottomNavigationBarItem(
              icon: Icon(Icons.car_rental),
              label: 'Change',
              backgroundColor: Colors.deepPurpleAccent,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.car_repair),
              label: 'Del',
              backgroundColor: Colors.deepPurpleAccent,
            ),
          ],
          type: BottomNavigationBarType.shifting,
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.white60,
          iconSize: 40,
          onTap: _onItemTap,
          elevation: 5
      ),
    );
  }
}









