import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodie_deliveryman/model/order.dart';

class OrderBody extends StatelessWidget {
  OrderBody(this.orderStatus);
  final int orderStatus;

  ListTile makeListTile(Order order) => ListTile(
    contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
    title: Text(
      order.orderName,
      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
    ),
    subtitle: Row(
      children: (orderStatus == 0)
          ? <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
              padding: EdgeInsets.only(top: 10.0),
              child: Text(
                  "Pickup Location: ${order.restaurantName} @ ${order.restaurantLocation}",
                  style: TextStyle(color: Colors.white))),
        )
      ]
          : (orderStatus == 1)
          ? <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
              padding: EdgeInsets.only(top: 10.0),
              child: Text(
                  "Delivery Location: ${order.deliveryPoint}",
                  style: TextStyle(color: Colors.white))),
        )
      ]
          : <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
              padding: EdgeInsets.only(top: 10.0),
              child: Text(
                  "Pickup Location: ${order.restaurantName} @ ${order.restaurantLocation}",
                  style: TextStyle(color: Colors.white))),
        ),
        Expanded(
          flex: 2,
          child: Padding(
            padding: EdgeInsets.only(top: 5.0),
            child: Icon(Icons.keyboard_arrow_right,
                color: Colors.white, size: 40.0),
          ),
        ),
        Expanded(
          flex: 5,
          child: Padding(
              padding: EdgeInsets.only(top: 10.0),
              child: Text(
                  "Delivery Location: ${order.deliveryPoint}",
                  style: TextStyle(color: Colors.white))),
        )
      ],
    ),
    trailing: (orderStatus != 2)
        ? IconButton(
        icon: Icon(
          Icons.check,
          color: Colors.green,
          size: 30.0,
        ),
        onPressed: () {
          print('order change delivery state');
        })
        : null,
    onTap: () {
      print('this order is tapped');
    },
  );

  Card makeCard(Order order) => Card(
    elevation: 8.0,
    margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
    child: Container(
      decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
      child: makeListTile(order),
    ),
  );

  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
        future: (orderStatus == 0)
            ? getOrdersToPickUp()
            : (orderStatus == 1) ? getOrdersToDeliver() : getOrdersDone(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Container(child: Text('Error when loading data'));
          }

          if (snapshot.connectionState == ConnectionState.done) {
            List<DocumentSnapshot> orderDocuments = snapshot.data.docs;
            print('print orders done in main page');
            List<Order> orders = [];
            orderDocuments.forEach((element) {
              printOrderDocument(element);
              orders.add(getOrderFromDocument(element));
            });
            return Container(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: orders.length,
                itemBuilder: (BuildContext context, int index) {
                  return makeCard(orders[index]);
                },
              ),
            );
          }
          return Container(child: Text('Loading data'));
        });
  }
}
