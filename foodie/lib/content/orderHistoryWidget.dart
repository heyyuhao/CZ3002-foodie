import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:foodie/global.dart' as global;
import 'package:foodie/model/order.dart';

class OrderHistoryWidget extends StatelessWidget {
  String getOrderTimeString(DateTime deliveryTimeStart) {
    String isoString = deliveryTimeStart.toIso8601String();
    String dateString = isoString.substring(0, 10);
    String timeString = isoString.substring(11, 13);
    if (timeString == "12") {
      timeString = "Lunch";
    }
    if (timeString == "18") {
      timeString = "Dinner";
    }
    return dateString + "  " + timeString;
  }

  ListTile orderHistoryList(BuildContext context, Order order) => ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        title: Text(
          order.orderName,
          style: TextStyle(
              color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
        ),
        subtitle: Row(
          children: <Widget>[
            Expanded(
              flex: 6,
              child: Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: Text("${getOrderTimeString(order.deliveryTimeStart)}",
                      style: TextStyle(color: Colors.white))),
            ),
            Expanded(
              flex: 3,
              child: Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: Text("Total Price: ",
                      style: TextStyle(color: Colors.white))),
            ),
            Expanded(
              flex: 3,
              child: Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: Text("\$${order.totalPrice}",
                      style: TextStyle(color: Colors.white))),
            )
          ],
        ),
        onTap: () {
          print('this order is tapped');
        },
      );

  Card orderHistoryCard(BuildContext context, Order order) => Card(
        elevation: 8.0,
        margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
        child: Container(
          decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
          child: orderHistoryList(context, order),
        ),
      );

  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
        future: getOrdersForUser(global.appUser.userID),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Container(child: Text('Error when loading data'));
          }

          if (snapshot.connectionState == ConnectionState.done) {
            List<DocumentSnapshot> orderDocuments = snapshot.data.docs;
            print('get order documents');
            print('length: ' + orderDocuments.length.toString());
            List<Order> orders = [];
            orderDocuments.forEach((element) {
              orders.add(getOrderFromDocument(element));
            });
            return Container(
              height: 500,
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: orders.length,
                itemBuilder: (BuildContext context, int index) {
                  return orderHistoryCard(context, orders[index]);
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
