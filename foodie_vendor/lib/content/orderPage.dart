import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodie_vendor/model/order.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:foodie_vendor/auth/googleAuth.dart';

class OrderPage extends StatefulWidget {
  @override
  _RefreshFutureBuilderState createState() => _RefreshFutureBuilderState();
}

class _RefreshFutureBuilderState extends State<OrderPage> {
  Future<QuerySnapshot> ordersForVendor =
      getOrdersForVendor(restaurant.name, restaurant.location);

  ListTile confirmedOrderListTile(BuildContext context, Order order) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      title: Text(
        order.orderName,
        style: TextStyle(
            color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 13),
      ),
      subtitle: Row(children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
              padding: EdgeInsets.only(top: 5.0),
              child: orderDetailsTable(order)),
        ),
      ]),
    );
  }

  ListTile rejectedOrderListTile(BuildContext context, Order order) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      title: Text(
        order.orderName,
        style: TextStyle(
            color: Colors.red, fontWeight: FontWeight.bold, fontSize: 13),
      ),
      subtitle: Row(children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
              padding: EdgeInsets.only(top: 5.0),
              child: orderDetailsTable(order)),
        ),
      ]),
    );
  }

  ListTile unprocessedOrderListTile(BuildContext context, Order order) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      title: Text(
        order.orderName,
        style: TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13),
      ),
      subtitle: Row(children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
              padding: EdgeInsets.only(top: 5.0),
              child: orderDetailsTable(order)),
        ),
      ]),
    );
  }

  Widget orderDetailsTable(Order order) {
    List<DataRow> dataRows = [];

    order.items.forEach((item) {
      dataRows.add(DataRow(
        cells: <DataCell>[
          DataCell(Text(
            item.dishName,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          )),
          DataCell(Text(
            item.quantity.toString(),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          )),
          DataCell(Text(
            (item.quantity * item.unitPrice).toString(),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          )),
        ],
      ));
    });

    return DataTable(
      columns: const <DataColumn>[
        DataColumn(
          label: Text(
            'Dish Name',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        DataColumn(
          label: Text(
            'Quantity',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        DataColumn(
          label: Text(
            'Price',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ],
      rows: dataRows,
    );
  }

  Card makeCard(BuildContext context, Order order) {
    if (order.status == OrderStatus.Rejected.index) {
      return Card(
        elevation: 8.0,
        margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
        child: Container(
          decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
          child: rejectedOrderListTile(context, order),
        ),
      );
    } else if (order.status == OrderStatus.Confirmed.index) {
      return Card(
        elevation: 8.0,
        margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
        child: Container(
          decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
          child: confirmedOrderListTile(context, order),
        ),
      );
    }
    return Card(
      elevation: 8.0,
      margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
          decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              unprocessedOrderListTile(context, order),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  RaisedButton(
                    child: const Text(
                      "Reject",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                                  title: Text("Reject " + order.orderName),
                                  content: Text(
                                      "Are you sure to reject this order?\n(Tap outside to dismiss)"),
                                  actions: <Widget>[
                                    new FlatButton(
                                      child: new Text(
                                        "Reject",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.red,
                                        ),
                                      ),
                                      onPressed: () async {
                                        print("Rejected order");
                                        await rejectOrder(order.orderID);
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    new FlatButton(
                                      child: new Text(
                                        "Cancel",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blue,
                                        ),
                                      ),
                                      onPressed: () async {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ]));
                    },
                  ),
                  const SizedBox(width: 16),
                  RaisedButton(
                    child: const Text(
                      "Confirm",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                                  title: Text("Confirm " + order.orderName),
                                  content: Text(
                                      "Confirm this order?\n(Tap outside to dismiss)"),
                                  actions: <Widget>[
                                    new FlatButton(
                                      child: new Text(
                                        "Cancel",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blue,
                                        ),
                                      ),
                                      onPressed: () async {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    new FlatButton(
                                      child: new Text(
                                        "Confirm",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.green,
                                        ),
                                      ),
                                      onPressed: () async {
                                        await confirmOrder(order.orderID);
                                        setState(() {
                                          ordersForVendor = getOrdersForVendor(
                                              restaurant.name,
                                              restaurant.location);
                                        });
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ]));
                    },
                  ),
                  const SizedBox(width: 8),
                ],
              ),
            ],
          )),
    );
  }

  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
        future: ordersForVendor,
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
              Order order = getOrderFromDocument(element);
              if (order.status == OrderStatus.Confirmed.index) {
                orders.add(order);
              } else {
                orders.insert(0, order);
              }
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
                          ordersForVendor = getOrdersForVendor(
                              restaurant.name, restaurant.location);
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
                    height: 440,
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: orders.length,
                      itemBuilder: (BuildContext context, int index) {
                        return makeCard(context, orders[index]);
                      },
                    ),
                  ),
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
