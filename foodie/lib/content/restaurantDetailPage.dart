import 'package:flutter/material.dart';
import 'package:foodie/model/restaurant.dart';
import 'package:foodie/content/restaurantPageTopWidget.dart';
import 'package:foodie/content/dishesList.dart';
import 'package:foodie/keys/keys.dart';

class RestaurantDetailPage extends StatelessWidget {
  final Restaurant restaurant;
  RestaurantDetailPage({Key key, this.restaurant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget bottomContent = Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(10.0),
      child: Center(
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Text(
                  'Dishes',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ],
            ),
          ],
        ),
      ),
    );

    return Scaffold(
      key: restaurantDetailKey,
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      body: Column(
        children: <Widget>[
          RestaurantTopWidget(restaurant: restaurant),
          bottomContent,
          DishesList(restaurant: restaurant)
        ],
      ),
    );
  }
}
