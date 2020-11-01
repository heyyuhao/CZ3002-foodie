import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:foodie/model/restaurant.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:foodie/content/restaurantDetailPage.dart';
import 'package:foodie/global.dart' as global;

class RestaurantsList extends StatefulWidget {
  RestaurantsList({Key key, this.title}) : super(key: key);
  final String title;

  @override
  RestaurantsListState createState() => new RestaurantsListState();
}

class RestaurantsListState extends State<RestaurantsList> {
  final String fallBackImage =
      "https://www.clipartmax.com/png/middle/138-1381067_fried-fish-fish-fry-roasting-fish-on-dish-cartoon.png";
  ListTile restaurantsList(BuildContext context, Restaurant restaurant) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(
          (restaurant.picture != "") ? restaurant.picture : fallBackImage,
        ),
        radius: 30,
        backgroundColor: Colors.transparent,
      ),
      title: Text(
        restaurant.name,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      subtitle: Row(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: Padding(
                padding: EdgeInsets.only(top: 10.0),
                child:
                    Text("Location: ", style: TextStyle(color: Colors.white))),
          ),
          Expanded(
            flex: 5,
            child: Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Text("${restaurant.location}",
                    style: TextStyle(color: Colors.white))),
          )
        ],
      ),
      trailing: IconButton(
          icon: Icon(
            Icons.arrow_forward_ios,
            color: Colors.white,
            size: 30.0,
          ),
          onPressed: () {
            global.setCurrentRestaurant(restaurant);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => RestaurantDetailPage(restaurant: restaurant)));
          }),
      onTap: () {
        global.setCurrentRestaurant(restaurant);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => RestaurantDetailPage(restaurant: restaurant)));
      },
    );
  }

  Card restaurantCard(BuildContext context, Restaurant restaurant) {
    return Card(
      elevation: 8.0,
      margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
        child: restaurantsList(context, restaurant),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
        future: getRestaurants(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Container(child: Text('Error when loading data'));
          }

          if (snapshot.connectionState == ConnectionState.done) {
            List<DocumentSnapshot> restaurantDocuments = snapshot.data.docs;
            print('print orders done in main page');
            List<Restaurant> restaurants = [];
            restaurantDocuments.forEach((element) {
              restaurants.add(getRestaurantFromDocumentWithoutDish(element));
            });

            return Container(
              height: 360,
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: restaurants.length,
                itemBuilder: (BuildContext context, int index) {
                  return restaurantCard(context, restaurants[index]);
                },
              ),
            );
          }

          return Container(
              child: Center(
            child: DotsIndicator(
              dotsCount: 3,
              position: 1.0,
              decorator: DotsDecorator(
                size: const Size.square(9.0),
                activeSize: const Size(18.0, 9.0),
                activeShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)),
              ),
            ),
          ));
        });
  }
}
