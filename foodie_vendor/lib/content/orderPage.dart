import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodie_vendor/model/order.dart';
import 'package:foodie_vendor/keys/keys.dart';

class OrderPage extends StatelessWidget {
  ListTile makeVendorOrderList(BuildContext context, Order order) {
    if (order.status == OrderStatus.Rejected.index) {
      return ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        title: Text(
          order.orderName,
          style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
        ),
        subtitle: Row(children: <Widget>[
          Expanded(
            flex: 5,
            child: Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Text("Rejected Order")),
          )
        ]),
        onTap: () {
          globalKey.currentState.showSnackBar(SnackBar(content: Text('Order Already Rejected')));
        },
      );
    } else if (order.status == OrderStatus.Confirmed.index) {
      return ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        title: Text(
          order.orderName,
          style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
        ),
        subtitle: Row(children: <Widget>[
          Expanded(
            flex: 5,
            child: Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Text("Confirmed Order")),
          )
        ]),
        onTap: () {
          globalKey.currentState.showSnackBar(SnackBar(content: Text('Order Already Confirmed')));
        },
      );
    }

    return makeListToConfirmTile(context, order);

  }
  ListTile makeListToConfirmTile(BuildContext context, Order order) => ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        title: Text(
          order.orderName,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        subtitle: Row(children: <Widget>[
          Expanded(
            flex: 5,
            child: Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Text(
                    "Pickup Location: ${order.restaurantName} @ ${order.restaurantLocation}",
                    style: TextStyle(color: Colors.white))),
          )
        ]),
        onTap: () {
          print('this order is tapped');
          showDialog(context: context, builder: (BuildContext context) => AlertDialog(
              title: Text(order.orderName),
              content: Text("Confirm or Reject Order?\n(Tap outside to dismiss)"),
              actions: <Widget>[
                new FlatButton(
                  child: new Text(
                    "Reject",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                  onPressed: () {
                    print("Rejected order");
                    Navigator.of(context).pop();
                  },
                ),
                new FlatButton(
                  child: new Text(
                    "Confirm",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  onPressed: () async {
                    print("Confirmed order");
                    await confirmOrder(order.orderID);
                    globalKey.currentState.showSnackBar(SnackBar(content: Text('Yay! Success')));
                    Navigator.of(context).pop();
                  },
                ),
              ])
          );
        },
      );

  Card makeCard(BuildContext context, Order order) => Card(
        elevation: 8.0,
        margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
        child: Container(
          decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
          child: makeVendorOrderList(context, order),
        ),
      );

  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
        future: getOrdersForVendor(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Container(child: Text('Error when loading data'));
          }

          if (snapshot.connectionState == ConnectionState.done) {
            List<DocumentSnapshot> orderDocuments = snapshot.data.docs;
            print('print orders done in main page');
            List<Order> orders = [];
            orderDocuments.forEach((element) {
              // printOrderDocument(element);
              orders.add(getOrderFromDocument(element));
            });
            return Container(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: orders.length,
                itemBuilder: (BuildContext context, int index) {
                  return makeCard(context, orders[index]);
                },
              ),
            );
          }

          return Container(child: Text('Loading data'));
        });
  }
}
