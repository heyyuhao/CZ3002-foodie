import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:foodie/global.dart' as global;
import 'package:foodie/model/order.dart';
import 'package:foodie/content/colorUtil.dart';

class CurrentOrderWidget extends StatefulWidget {
  @override
  _RefreshFutureBuilderState createState() => _RefreshFutureBuilderState();
}

class _RefreshFutureBuilderState extends State<CurrentOrderWidget> {
  Future<QuerySnapshot> currentOrdersForUser =
      getCurrentOrdersForUser(global.appUser.userID);

  ListTile currentOrderListTile(Order order) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      title: Column(
        children: [
          Text(
            order.orderName,
            style: TextStyle(
                color: getOrderStatusColor(order.status),
                fontWeight: FontWeight.bold,
                fontSize: 12),
          ),
          SizedBox(height: 10),
          Text(
            "Status: ${order.getStatusString()}",
            style: TextStyle(
                color: getOrderStatusColor(order.status),
                fontWeight: FontWeight.bold,
                fontSize: 12),
          )
        ],
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

  Widget currentOrdersListView(List<Order> orders) {
    if (orders.length == 0) {
      return Center(
        child: Text('No order in progress',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.white,
            )),
      );
    }

    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: orders.length,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          elevation: 8.0,
          margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
          child: Container(
              decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  currentOrderListTile(orders[index]),
                ],
              )),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
        future: currentOrdersForUser,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Container(child: Text('Error when loading data'));
          }

          if (snapshot.connectionState == ConnectionState.done) {
            List<DocumentSnapshot> orderDocuments = snapshot.data.docs;
            print('print orders done in profile page');
            List<Order> orders = [];
            orderDocuments.forEach((element) {
              orders.add(getOrderFromDocument(element));
            });
            print('length ${orders.length}');
            return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  ConstrainedBox(
                    constraints: const BoxConstraints(
                        minWidth: double.infinity, maxHeight: 20.0),
                    child: RaisedButton(
                      onPressed: () {
                        setState(() {
                          currentOrdersForUser =
                              getCurrentOrdersForUser(global.appUser.userID);
                        });
                      },
                      color: Colors.blueGrey,
                      child: Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: Text(
                          'Refresh',
                          style: TextStyle(fontSize: 15, color: Colors.white),
                        ),
                      ),
                      elevation: 5,
                      // shape: RoundedRectangleBorder(
                      //     borderRadius: BorderRadius.circular(40)),
                    ),
                  ),
                  Container(
                    height: 290,
                    child: currentOrdersListView(orders),
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
