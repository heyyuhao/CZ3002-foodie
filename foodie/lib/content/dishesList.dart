import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodie/model/restaurant.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:foodie/global.dart' as global;
import 'package:foodie/keys/keys.dart';

class DishesList extends StatelessWidget {
  final Restaurant restaurant;
  DishesList({Key key, this.restaurant}) : super(key: key);

  final String fallBackImage =
      "https://www.clipartmax.com/png/middle/138-1381067_fried-fish-fish-fry-roasting-fish-on-dish-cartoon.png";
  ListTile dishListTile(BuildContext context, Dish dish) {
    return ListTile(
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
            flex: 3,
            child: Padding(
                padding: EdgeInsets.only(bottom: 10.0),
                child: Text("Price: ", style: TextStyle(color: Colors.white))),
          ),
          Expanded(
            flex: 9,
            child: Padding(
                padding: EdgeInsets.only(bottom: 10.0),
                child: Text("${dish.unitPrice}",
                    style: TextStyle(color: Colors.white))),
          )
        ],
      ),
      trailing: IconButton(
          icon: Icon(
            Icons.add_shopping_cart,
            color: Colors.white,
            size: 30.0,
          ),
          onPressed: () {
            global.addDishToCart(dish);
            restaurantDetailKey.currentState
                .showSnackBar(SnackBar(content: Text('Dish Added')));
            print('this dish is added');
          }),
      onTap: () {
        print('this dish is added');
      },
    );
  }

  Card dishCard(BuildContext context, Dish dish) {
    return Card(
      elevation: 8.0,
      margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
        child: dishListTile(context, dish),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
        future: getDishOfRestaurant(restaurant.restaurantID),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Container(child: Text('Error when loading data'));
          }

          if (snapshot.connectionState == ConnectionState.done) {
            List<DocumentSnapshot> dishDocuments = snapshot.data.docs;
            List<Dish> dishes = [];
            dishDocuments.forEach((dishDocument) {
              dishes.add(getDishFromDocument(dishDocument));
            });

            return Container(
              height: 480,
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: dishes.length,
                itemBuilder: (BuildContext context, int index) {
                  return dishCard(context, dishes[index]);
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
