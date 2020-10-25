import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:circular_bottom_navigation/circular_bottom_navigation.dart';
import 'package:circular_bottom_navigation/tab_item.dart';
import 'package:foodie_vendor/orderBody.dart';
import 'package:foodie_vendor/keys.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vendor Application',
      theme: new ThemeData(
          primaryColor: Color.fromRGBO(58, 66, 86, 1.0), fontFamily: 'Raleway'),
      home: new ListPage(title: 'Current Orders'),
    );
  }
}

class ListPage extends StatefulWidget {
  ListPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  List<TabItem> tabItems = List.of([
    new TabItem(Icons.assignment, "Check Orders", Colors.red,
        labelStyle: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
    new TabItem(Icons.assignment_returned, "Edit Dish", Colors.orange,
        labelStyle:
        TextStyle(color: Colors.orange, fontWeight: FontWeight.bold)),
  ]);

  int selectedPos = 0;
  double bottomNavBarHeight = 60;
  CircularBottomNavigationController _navigationController;

  @override
  void initState() {
    super.initState();
    _navigationController = new CircularBottomNavigationController(selectedPos);
  }

  @override
  Widget build(BuildContext context) {
    Widget topBar() {
      String title;
      switch (selectedPos) {
        case 0:
          title = "Check Orders";
          break;
        case 1:
          title = "Edit Dish";
          break;
      }

      return AppBar(
          elevation: 1,
          backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
          title: Text(
            title,
            style: TextStyle(color: Colors.blue),
          ));
    }

    Widget bottomNav() {
      return CircularBottomNavigation(
        tabItems,
        controller: _navigationController,
        barHeight: bottomNavBarHeight,
        barBackgroundColor: Colors.white,
        animationDuration: Duration(milliseconds: 300),
        selectedCallback: (int selectedPos) {
          setState(() {
            this.selectedPos = selectedPos;
          });
        },
      );
    }

    return Scaffold(
      key: globalKey,
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      appBar: topBar(),
      body: (selectedPos == 0) ? new OrderBody() : new Text("Coming soon"),
      bottomNavigationBar: bottomNav(),
    );
  }
}
