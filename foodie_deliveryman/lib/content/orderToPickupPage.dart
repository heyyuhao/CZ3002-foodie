import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:foodie_deliveryman/model/order.dart';
import 'package:foodie_deliveryman/keys/keys.dart';

class OrderToPickupPage extends StatefulWidget {
  @override
  _RefreshFutureBuilderState createState() => _RefreshFutureBuilderState();
}

class _RefreshFutureBuilderState extends State<OrderToPickupPage> {
  Future<QuerySnapshot> ordersToPickUpQuerySnapshot = getOrdersToPickUp();

  ListTile makeListTile(BuildContext context, Order order) => ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        title: Text(
          order.orderName,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        subtitle: Row(
          children: <Widget>[
            Expanded(
              flex: 5,
              child: Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: Text(
                      "Pickup Location: ${order.restaurantName} @ ${order.restaurantLocation}",
                      style: TextStyle(color: Colors.white))),
            )
          ],
        ),
        trailing: IconButton(
            icon: Icon(
              Icons.check,
              color: Colors.green,
              size: 30.0,
            ),
            onPressed: () {
              print('order change delivery state');
              showDialog(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                          title: Text(order.orderName),
                          content: Text(
                              "Picked up this order?\n(Tap outside to dismiss)"),
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
                                await pickUpOrder(order.orderID);
                                globalKey.currentState.showSnackBar(SnackBar(
                                    content: Text('Picked up order!')));
                                setState(() {
                                  // setstate is in statefulwidget
                                  ordersToPickUpQuerySnapshot =
                                      getOrdersToPickUp();
                                });
                                Navigator.of(context).pop();
                              },
                            ),
                          ]));
            }),
        onTap: () {
          print('this order is tapped');
        },
      );

  Card makeCard(BuildContext context, Order order) => Card(
        elevation: 8.0,
        margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
        child: Container(
          decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
          child: makeListTile(context, order),
        ),
      );

  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
        // future: getOrdersToPickUp(),
        future: ordersToPickUpQuerySnapshot,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Container(child: Text('Error when loading data'));
          }

          if (snapshot.connectionState == ConnectionState.done) {
            List<DocumentSnapshot> orderDocuments = snapshot.data.docs;
            // print('print orders to pick up in main page');
            List<Order> orders = [];
            orderDocuments.forEach((element) {
              // printOrderDocument(element);
              orders.add(getOrderFromDocument(element));
            });

            return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  ConstrainedBox(
                    constraints:
                        const BoxConstraints(minWidth: double.infinity),
                    child: RaisedButton(
                      onPressed: () {
                        setState(() {
                          ordersToPickUpQuerySnapshot =
                              getOrdersToPickUp();
                        });
                      },
                      color: Colors.blueGrey,
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          'Refresh',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
                      elevation: 5,
                      // shape: RoundedRectangleBorder(
                      //     borderRadius: BorderRadius.circular(40)),
                    ),
                  ),
                  Container(
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: orders.length,
                      itemBuilder: (BuildContext context, int index) {
                        return makeCard(context, orders[index]);
                      },
                    ),
                  )
                ]);
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
