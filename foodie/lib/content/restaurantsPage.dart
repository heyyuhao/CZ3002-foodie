import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:foodie/model/restaurant.dart';
import 'package:dots_indicator/dots_indicator.dart';

final List<String> imgList = [
  'https://www.zaobao.com.sg/sites/default/files/images/201706/20170628/20170628_news_ntu01.jpg',
  'http://www.jayyeo.com/projects/nanyangchronicle/wp-content/uploads/2013/08/KW_9179_RS.jpg',
  'http://www.ntu.edu.sg/has/FnB/SiteAssets/Pages/HallCanteens/NorthHIllFC_280x180.jpg',
  'https://pic.sgchinese.net/attachments/forum/201508/19/113839h24fzyztfmm6iid7.png',
  'http://1.bp.blogspot.com/-YO6qZgyktUs/Um_E-YhopuI/AAAAAAAAKQs/1R9fc56wmd4/s1600/2.+NTU+Hall+13+%2528Hong+Yun%2529.JPG',
];

final List<String> nameList = [
  "365 Mala Tang",
  "HeyTea",
  "Korean Cuisine",
  "Raydy Prawn Mee",
  "Route 35 Western Food",
];

List<T> map<T>(List list, Function handler) {
  List<T> result = [];
  for (var i = 0; i < list.length; i++) {
    result.add(handler(i, list[i]));
  }

  return result;
}

final List promotions = map<Widget>(imgList, (index, i) {
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

class RestaurantsPage extends StatefulWidget {
  RestaurantsPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  RestaurantsPageState createState() => new RestaurantsPageState();
}

class RestaurantsPageState extends State<RestaurantsPage> {
  final String fallBackImage =
      "https://www.clipartmax.com/png/middle/138-1381067_fried-fish-fish-fry-roasting-fish-on-dish-cartoon.png";
  ListTile restaurantsList(BuildContext context, Restaurant restaurant) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(
          fallBackImage,
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
            Icons.edit,
            color: Colors.blue,
            size: 30.0,
          ),
          onPressed: () {
            print('order change delivery state');
            showDialog(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                        title: Text(restaurant.name),
                        content:
                            Text("Edit this dish?\n(Tap outside to dismiss)"),
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
                        ]));
          }),
      onTap: () {
        print(restaurant.name);
        print('this dish is tapped');
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
    // List<Restaurant> restaurants = [];

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

            return Column(
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.symmetric(vertical: 15.0),
                    child: CarouselSlider(
                        height: 100,
                        autoPlay: false,
                        viewportFraction: 0.8,
                        aspectRatio: 2.0,
                        items: promotions)),
                Container(
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: restaurants.length,
                    itemBuilder: (BuildContext context, int index) {
                      return restaurantCard(context, restaurants[index]);
                    },
                  ),
                ),
              ],
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
