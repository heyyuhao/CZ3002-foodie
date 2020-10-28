import 'package:flutter/material.dart';
import 'package:foodie_vendor/auth/loginPage.dart';
import 'package:foodie_vendor/auth/googleAuth.dart';
import 'package:foodie_vendor/model/restaurant.dart';

class RestaurantPage extends StatelessWidget {

  final String fallBackImage = "https://www.clipartmax.com/png/middle/138-1381067_fried-fish-fish-fry-roasting-fish-on-dish-cartoon.png";
  ListTile makeListTile(BuildContext context, Dish dish) => ListTile(
    contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
    leading: CircleAvatar(
      backgroundImage: NetworkImage(
        (dish.picture != "") ? dish.picture : fallBackImage,
      ),
      radius: 30,
      backgroundColor: Colors.transparent,
    ),
    title: Text(
      dish.name,
      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
    ),
    subtitle: Row(
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
              padding: EdgeInsets.only(top: 10.0),
              child: Text(
                  "Price: ",
                  style: TextStyle(color: Colors.white))),
        ),
        Expanded(
          flex: 5,
          child: Padding(
              padding: EdgeInsets.only(top: 10.0),
              child: Text(
                  "${dish.unitPrice}",
                  style: TextStyle(color: Colors.white))),
        )
      ],
    ),
    trailing: IconButton(
        icon: Icon(
          Icons.edit,
          color: Colors.blue,
          size: 30.0,
        ),
        onPressed: () {
          print('order change delivery state');
          showDialog(context: context, builder: (BuildContext context) => AlertDialog(
              title: Text(dish.name),
              content: Text("Edit this dish?\n(Tap outside to dismiss)"),
              actions: <Widget>[
                new FlatButton(
                  child: new Text(
                    "No",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                new FlatButton(
                  child: new Text(
                    "Yes",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  onPressed: () async {
                    print("Picked up order");
                    // await confirmOrder(order.orderID);
                    Navigator.of(context).pop();
                  },
                ),
              ])
          );
        }),
    onTap: () {
      print(dish.name);
      print('this dish is tapped');
    },
  );


  Card makeCard(BuildContext context, Dish dish) => Card(
    elevation: 8.0,
    margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
    child: Container(
      decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
      child: makeListTile(context, dish),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Color.fromRGBO(58, 66, 86, 1.0), Color.fromRGBO(58, 66, 86, 1.0)],
          ),
        ),
        child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(width: 30),
                  CircleAvatar(
                    backgroundImage: NetworkImage(
                      imageUrl,
                    ),
                    radius: 30,
                    backgroundColor: Colors.transparent,
                  ),
                  SizedBox(width: 15),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Text(
                              'Name:',
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            SizedBox(width: 15),
                            Text(
                              name,
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),

                          ]
                      ),
                      SizedBox(height: 10),
                      Text(
                        email,
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ]
                  )
                ],
              ),
              SizedBox(height: 5),
              RaisedButton(
                onPressed: () {
                  signOutGoogle();
                  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) {return LoginPage();}), ModalRoute.withName('/'));
                },
                color: Colors.blue,
                child: Padding(
                  padding: const EdgeInsets.all(0),
                  child: Text(
                    'Sign Out',
                    style: TextStyle(fontSize: 12, color: Colors.white),
                  ),
                ),
                elevation: 5,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40)),
              ),
              SizedBox(height: 20),
              Row(
                children: <Widget>[
                  SizedBox(width: 20),
                  Text(
                    'Restaurant:',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  SizedBox(width: 10),
                  Text(
                    restaurant.name,
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 10),
                  IconButton(
                      icon: Icon(
                        Icons.edit,
                        color: Colors.blue,
                        size: 20.0,
                      ),
                      onPressed: () {
                        print('order change delivery state');
                        showDialog(context: context, builder: (BuildContext context) => AlertDialog(
                            title: Text(restaurant.name),
                            content: Text("Edit this restaurant Name?\n(Tap outside to dismiss)"),
                            actions: <Widget>[
                              new FlatButton(
                                child: new Text(
                                  "No",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red,
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              new FlatButton(
                                child: new Text(
                                  "Yes",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue,
                                  ),
                                ),
                                onPressed: () async {
                                  print("Picked up order");
                                  // await confirmOrder(order.orderID);
                                  Navigator.of(context).pop();
                                },
                              ),
                            ])
                        );
                      }),
                ],
              ),
              Row(
                children: <Widget>[
                  SizedBox(width: 20),
                  Text(
                    'Dishes',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ],
              ),
              Container(
                height: 270,
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: restaurant.dishes.length,
                  itemBuilder: (BuildContext context, int index) {
                    return makeCard(context, restaurant.dishes[index]);
                  },
                ),
              )
            ],
          ),
      ),
    );
  }
}