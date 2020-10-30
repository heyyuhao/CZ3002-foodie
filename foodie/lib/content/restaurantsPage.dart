import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:foodie/content/carouselPromotion.dart';
import 'package:foodie/content/restaurantsList.dart';

class RestaurantsPage extends StatefulWidget {
  RestaurantsPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  RestaurantsPageState createState() => new RestaurantsPageState();
}

class RestaurantsPageState extends State<RestaurantsPage> {
  @override
  Widget build(BuildContext context) {
    // List<Restaurant> restaurants = [];

    return Column(
      children: <Widget>[
        Padding(
            padding: EdgeInsets.symmetric(vertical: 15.0),
            child: CarouselPromotion()),
        RestaurantsList(),
      ],
    );
  }
}
