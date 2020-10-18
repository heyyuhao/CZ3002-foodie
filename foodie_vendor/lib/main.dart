import 'package:flutter/material.dart';
import 'package:foodie_vendor/model/order.dart';
import 'package:circular_bottom_navigation/circular_bottom_navigation.dart';
import 'package:circular_bottom_navigation/tab_item.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Startup Name Generator',
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
    new TabItem(Icons.assignment_turned_in, "Edit Dishes", Colors.green,
        labelStyle:
        TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
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
    ListTile makeListTile(Order order) => ListTile(
      contentPadding:
      EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      onTap: () => alertDialog(context,order),
      title: Text(
        order.orderName,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),

      ),

      subtitle: Row(
        children: (selectedPos == 0) ?
        <Widget>[Expanded(
          flex: 5,
          child: Padding(
              padding: EdgeInsets.only(top: 10.0),
              child: Text("Pickup Location: ${order.pickupLocation}",
                  style: TextStyle(color: Colors.white))),
        )] : (selectedPos == 1) ?
        <Widget>[Expanded(
          flex: 5,
          child: Padding(
              padding: EdgeInsets.only(top: 10.0),
              child: Text("Delivery Location: ${order.deliveryLocation}",
                  style: TextStyle(color: Colors.white))),
        )] : <Widget>[
          Expanded(
            flex: 5,
            child: Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Text("Pickup Location: ${order.pickupLocation}",
                    style: TextStyle(color: Colors.white))),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: EdgeInsets.only(top: 5.0),
              child: Icon(Icons.keyboard_arrow_right,
                  color: Colors.white, size: 40.0),
            ),
          ),
          Expanded(
            flex: 5,
            child: Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Text("Delivery Location: ${order.deliveryLocation}",
                    style: TextStyle(color: Colors.white))),
          )
        ],
      ),
    );

    Card makeCard(Order order) => Card(
      elevation: 8.0,
      margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
        child: makeListTile(order),
      ),
    );

    Widget ordersBody() {
      List ordersInCurrentState;
      switch (selectedPos) {
        case 0:
          ordersInCurrentState = getOrdersToPickUp();
          break;
        case 1:
        /*ordersInCurrentState = getOrdersToDeliver();*/
          break;
      }

      return Container(
        // decoration: BoxDecoration(color: Color.fromRGBO(58, 66, 86, 1.0)),
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: (ordersInCurrentState==null) ? 0 : ordersInCurrentState.length ,
          itemBuilder: (BuildContext context, int index) {
            return makeCard(ordersInCurrentState[index]);
          },
        ),
      );
    }

    Widget topBar() {
      String title;
      switch (selectedPos) {
        case 0:
          title = "Check Orders";
          break;
        case 1:
          title = "Edit Dishes";
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
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      appBar: topBar(),
      body: ordersBody(),
      bottomNavigationBar: bottomNav(),
    );
  }
}

List getOrdersToPickUp() {
  return [
    Order(
        orderName: "CH-2020-10-10-1",
        pickupLocation: "Canteen 2 Xiao Long Bao",
        deliveryLocation: "Crescent Hall",
        price: 20,
        content:
        "Beef Noodle                    \$3.50",
        dishes:[new Dish(dishName:"Beef Noodle", dishPrice: 3.5, dishQuantity:2)]
    ),

    Order(
        orderName: "C4-2020-10-10-2",
        pickupLocation: "Canteen 2 Xiao Long Bao",
        deliveryLocation: "NTU Hall 4",
        price: 20,
        content:
        "Pork Wanton                   \$3.50",
        dishes:[new Dish(dishName:"Pork Wanton", dishPrice: 3.5, dishQuantity:2)]
    ),
  ];
}

void alertDialog(BuildContext context, Order order) {
  var alert = AlertDialog(
      title: Text(order.orderName),
      content: Text("Dish                  Price      Qty\n" +
          order.dishes[0].dishName + "    " +
          order.dishes[0].dishPrice.toString() + "          " +
          order.dishes[0].dishQuantity.toString()) ,
      actions: <Widget> [
        new FlatButton(
          child: new Text("Cancel"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        new FlatButton(
          child: new Text("Confirm"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ]
  );
  showDialog(context: context, builder: (BuildContext context) => alert);
}