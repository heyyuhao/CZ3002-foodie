import 'package:flutter/material.dart';
import 'package:foodie/model/restaurant.dart';
import 'package:foodie/content/cartPage.dart';

class RestaurantTopWidget extends StatelessWidget {
  final Restaurant restaurant;
  RestaurantTopWidget({Key key, this.restaurant}) : super(key: key);

  final String fallBackImage =
      "https://www.clipartmax.com/png/middle/138-1381067_fried-fish-fish-fry-roasting-fish-on-dish-cartoon.png";

  @override
  Widget build(BuildContext context) {

    return Stack(
      children: <Widget>[
        Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(width: 50),
                  CircleAvatar(
                    backgroundImage: NetworkImage(
                      (restaurant.picture != "") ? restaurant.picture : fallBackImage,
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
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              SizedBox(width: 15),
                              Text(
                                restaurant.name,
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ]),
                        SizedBox(height: 10),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Text(
                                'Location:',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              SizedBox(width: 15),
                              Text(
                                restaurant.location,
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ]),
                      ])
                ],
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
        Positioned(
          left: 8.0,
          top: 40.0,
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back,
              color: Colors.white,
              size: 30,
            ),
          ),
        ),
        Positioned(
          right: 8.0,
          top: 40.0,
          child: InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CartPage()));
            },
            child: Icon(
              Icons.shopping_cart,
              color: Colors.white,
              size: 30,
            ),
          ),
        )
      ],
    );
  }
}
