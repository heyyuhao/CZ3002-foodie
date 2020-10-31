import 'package:flutter/material.dart';
import 'package:circular_bottom_navigation/circular_bottom_navigation.dart';
import 'package:circular_bottom_navigation/tab_item.dart';
import 'package:foodie/content/profilePage.dart';
import 'package:foodie/content/restaurantsPage.dart';


class ContentPage extends StatefulWidget {
  ContentPage({Key key}) : super(key: key);

  @override
  _ContentPageState createState() => _ContentPageState();
}

class _ContentPageState extends State<ContentPage> {
  List<TabItem> tabItems = List.of([
    new TabItem(Icons.local_dining, "Order Food", Colors.red,
        labelStyle: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
    new TabItem(Icons.accessibility, "Me", Colors.orange,
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
          title = "Order Food";
          break;
        case 1:
          title = "Me";
          break;
      }

      return AppBar(
        automaticallyImplyLeading: false,
        elevation: 1,
        backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
        title: Text(
          title,
          style: TextStyle(color: Colors.blue),
        ),
      );
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
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      appBar: topBar(),
      body: (selectedPos == 0) ? RestaurantsPage() : ProfilePage(),
      bottomNavigationBar: bottomNav(),
    );
  }
}
