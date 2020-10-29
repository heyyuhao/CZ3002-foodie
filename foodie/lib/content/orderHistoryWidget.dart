import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:foodie/auth/googleAuth.dart';
import 'package:foodie/model/order.dart';

class OrderHistoryWidget extends StatelessWidget {
  ListTile orderHistoryList(BuildContext context, Order order) => ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        title: Text(
          order.orderName,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        subtitle: Row(
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: Text("Time: ", style: TextStyle(color: Colors.white))),
            ),
            Expanded(
              flex: 7,
              child: Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: Text("${order.totalPrice}",
                      style: TextStyle(color: Colors.white))),
            ),
            Expanded(
              flex: 4,
              child: Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: Text("Total Price: ",
                      style: TextStyle(color: Colors.white))),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: Text("${order.totalPrice}",
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
        future: getOrdersForUser(appUser.userID),
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
              height: 335,
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
