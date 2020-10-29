import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

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

class CarouselPromotion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
        height: 100,
        autoPlay: false,
        viewportFraction: 0.8,
        aspectRatio: 2.0,
        items: promotions);
  }
}
