import 'package:flutter/material.dart';
import 'package:circular_bottom_navigation/circular_bottom_navigation.dart';
import 'package:circular_bottom_navigation/tab_item.dart';
import 'package:foodie_deliveryman/content/orderDonePage.dart';
import 'package:foodie_deliveryman/content/orderToDeliverPage.dart';
import 'package:foodie_deliveryman/content/orderToPickupPage.dart';
import 'package:foodie_deliveryman/content/profilePage.dart';

class ContentPage extends StatefulWidget {
  ContentPage({Key key}) : super(key: key);

  @override
  _ContentPageState createState() => _ContentPageState();
}

class _ContentPageState extends State<ContentPage> {
  List<TabItem> tabItems = List.of([
    new TabItem(Icons.assignment, "To Pick Up", Colors.red,
        labelStyle: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
    new TabItem(Icons.assignment_returned, "To Deliver", Colors.orange,
        labelStyle:
        TextStyle(color: Colors.orange, fontWeight: FontWeight.bold)),
    new TabItem(Icons.assignment_turned_in, "Done", Colors.green,
        labelStyle:
        TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
    new TabItem(Icons.accessibility, "My Profile", Colors.blue,
        labelStyle:
        TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
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
          title = "To Pick Up";
          break;
        case 1:
          title = "To Deliver";
          break;
        case 2:
          title = "Done";
          break;
        case 3:
          title = "Profile";
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

    Widget orderPage() {
      switch (selectedPos) {
        case 0:
          return OrderToPickupPage();
          break;
        case 1:
          return OrderToDeliverPage();
          break;
        case 2:
          return OrderDonePage();
          break;
        case 3:
          return ProfilePage();
          break;
      }
    }

    return Scaffold(
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      appBar: topBar(),
      body: orderPage(),
      bottomNavigationBar: bottomNav(),
    );
  }
}
