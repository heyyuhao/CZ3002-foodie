import "package:flutter/material.dart";
import 'package:foodie/getfood/payment1.dart';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:foodie/getfood/SelectDish.dart';
import 'package:foodie/getfood/OrderList.dart';

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

final Widget placeholder = new Container(color: Colors.blue);

final List child = map<Widget>(imgList, (index, i) {
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
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ))),
            ],
          )));
}).toList();

List<T> map<T>(List list, Function handler) {
  List<T> result = [];
  for (var i = 0; i < list.length; i++) {
    result.add(handler(i, list[i]));
  }

  return result;
}

class Dish {
  const Dish({this.name, this.price, this.calories, this.imageUrl});

  final String name;
  final String price;
  final String calories;
  final String imageUrl;
}

final List<Dish> _dishes = <Dish>[
  Dish(
      name: 'Veg Noodles',
      price: '3 SGD',
      calories: '120kcal',
      imageUrl: 'one.jpg'),
  Dish(
      name: 'Beef Fried Rice',
      price: '4.5 SGD',
      calories: '350k',
      imageUrl: '201205-xl-beef-fried-rice.jpg'),
  Dish(
    name: 'Chicken Fillet Rice',
    price: '4.5 SGD',
    calories: '400k',
    imageUrl: '92122816-chicken-fillet-with-fried-rice-on-white-plate-.jpg',
  ),
  Dish(
    name: 'Fish Fillet Rice',
    price: '5.5 SGD',
    calories: '330k',
    imageUrl: 'crispy-fish-Greek-rice-bowls-1.jpg',
  ),
];

class VendorPage extends StatefulWidget {
  VendorPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  VendorPageState createState() => new VendorPageState();
}

class VendorPageState extends State<VendorPage> {
  List<String> itemData = ["one", "two", "three", "four"];

  Widget _dialogBuilder(BuildContext context, Dish dish) {
    ThemeData localTheme = Theme.of(context);
    return SimpleDialog(
      contentPadding: EdgeInsets.zero,
      children: [
        Image.network(dish.imageUrl, fit: BoxFit.fill),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                dish.name,
                style: localTheme.textTheme.display1,
              ),
              Text(dish.price,
                  style: localTheme.textTheme.subhead.copyWith(
                    fontStyle: FontStyle.italic,
                  )),
              SizedBox(height: 16.0),
              Text(dish.calories, style: localTheme.textTheme.body1),
              SizedBox(height: 16.0),
              Align(
                  alignment: Alignment.centerRight,
                  child: Wrap(children: [
                    FlatButton(
                      onPressed: () {},
                      child: const Text('Back'),
                      color: Colors.white,
                      textColor: Colors.blue,
                    ),
                    RaisedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => PayPage()),
                        );
                      },
                      child: const Text('Check out'),
                      color: Colors.blue,
                      textColor: Colors.white,
                    )
                  ]))
            ],
          ),
        ),
      ],
    );
  }

  Widget _listItemBuilder(BuildContext context, int index) {
    return new GestureDetector(
      onTap: () => showDialog(
          context: context,
          builder: (context) => _dialogBuilder(context, _dishes[index])),
      child: Container(
        padding: const EdgeInsets.only(left: 16.0),
        alignment: Alignment.centerLeft,
        child: Text(_dishes[index].name,
            style: Theme.of(context).textTheme.headline),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: const Text('Canteens'),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.shopping_cart,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => OrderListPage()),
              );
            },
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          new Padding(
              padding: EdgeInsets.symmetric(vertical: 15.0),
              child: CarouselSlider(
                  height:100,
                  autoPlay: false,
                  viewportFraction: 0.8,
                  aspectRatio: 2.0,
                  items: child
              )),
          CustomScrollView(
            shrinkWrap: true,
            // padding: const EdgeInsets.all(20.0),
            slivers: <Widget> [
              SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  return new GestureDetector(
                    onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SelectDishPage()),
                        );
                      },
                    child: Card(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                              padding: EdgeInsets.all(5.0),
                              decoration: BoxDecoration(
//                          color: Colors.grey,
                                  borderRadius: BorderRadius.circular(5.0)),
                              width: 100.0,
                              height: 100.0,
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => SelectDishPage()),
                                  );
                                },
                                child: Hero(
                                  tag: "image_$index",
                                  child: Material(
                                    borderRadius: BorderRadius.circular(5.0),
                                    elevation: 5.0,
                                    child: Stack(
                                      fit: StackFit.expand,
                                      children: <Widget>[
                                        Image.asset(
                                            "assets/${_dishes[index].imageUrl}",
                                            fit: BoxFit.fill),
                                      ],
                                    ),
                                  ),
                                ),
                              )),
                          Expanded(
                              child: Padding(
                                padding: EdgeInsets.all(5.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: <Widget>[
                                    Text(
                                      "${_dishes[index].name}",
                                      style: TextStyle(fontSize: 16.0),
                                    ),
                                    Text(
                                      "Price: ${_dishes[index].price}    Calories: 400k",
                                      style: TextStyle(fontSize: 13.0),
                                    ),
                                  ],
                                ),
                              )),
                        ],
                      ),
                    ),
                  );
                }, childCount: itemData.length),
              )
            ],
          )
        ],
      ),

    );
  }
}
