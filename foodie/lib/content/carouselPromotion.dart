import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:foodie/model/restaurant.dart';
import 'package:dots_indicator/dots_indicator.dart';

class CarouselPromotion extends StatefulWidget {
  CarouselPromotion({Key key, this.title}) : super(key: key);
  final String title;

  @override
  CarouselPromotionState createState() => new CarouselPromotionState();
}

class CarouselPromotionState extends State<CarouselPromotion> {
  final String fallBackImage =
      "https://www.clipartmax.com/png/middle/138-1381067_fried-fish-fish-fry-roasting-fish-on-dish-cartoon.png";

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
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

            List<String> imageList = [];
            List<String> nameList = [];

            restaurants.forEach((restaurant) {
              imageList.add(restaurant.picture);
              nameList.add(restaurant.name);
            });

            final List promotions = map<Widget>(imageList, (index, i) {
              return Container(
                  margin: EdgeInsets.all(5.0),
                  child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      child: Stack(
                        children: <Widget>[
                          Image.network(
                            i,
                            fit: BoxFit.cover,
                            width: 1000.0,
                          ),
                          Positioned(
                              bottom: 0.0,
                              left: 0.0,
                              right: 0.0,
                              child: Container(
                                  decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                    colors: [
                                      Color.fromARGB(200, 0, 0, 0),
                                      Color.fromARGB(0, 0, 0, 0)
                                    ],
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topCenter,
                                  )),
                                  padding: EdgeInsets.symmetric(
                                      vertical: 40.0, horizontal: 40.0),
                                  child: Text(
                                    '${nameList[index]}',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ))),
                        ],
                      )));
            }).toList();

            return CarouselSlider(
                height: 100,
                autoPlay: false,
                viewportFraction: 0.8,
                aspectRatio: 2.0,
                items: promotions);
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
