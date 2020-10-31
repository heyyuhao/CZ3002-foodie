import 'package:flutter/material.dart';
import 'package:foodie/auth/googleAuth.dart';
import 'package:foodie/auth/loginPage.dart';
import 'package:foodie/content/orderHistoryPage.dart';
import 'package:foodie/global.dart' as global;
import 'package:foodie/model/order.dart';


class ProfilePage extends StatelessWidget {
  ListTile currentOrderListTile(Order order) {
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
      itemCount: global.currOrders.length,
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

  final String fallBackImage =
      "https://www.clipartmax.com/png/middle/138-1381067_fried-fish-fish-fry-roasting-fish-on-dish-cartoon.png";
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Color.fromRGBO(58, 66, 86, 1.0),
            Color.fromRGBO(58, 66, 86, 1.0)
          ],
        ),
      ),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(width: 30),
              CircleAvatar(
                backgroundImage: NetworkImage(
                  global.appUser.imageUrl,
                ),
                radius: 30,
                backgroundColor: Colors.transparent,
              ),
              SizedBox(width: 15),
              Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Text(
                            'Name:',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          SizedBox(width: 15),
                          Text(
                            global.appUser.userName,
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ]),
                    SizedBox(height: 10),
                    Text(
                      global.appUser.userEmail,
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ])
            ],
          ),
          ButtonTheme(
            minWidth: 10.0,
            height: 20.0,
            child: RaisedButton(
              onPressed: () {
                signOutGoogle();
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) {
                  return LoginPage();
                }), ModalRoute.withName('/'));
              },
              color: Colors.blue,
              child: Padding(
                padding: const EdgeInsets.all(0),
                child: Text(
                  'Sign Out',
                  style: TextStyle(fontSize: 12, color: Colors.white),
                ),
              ),
              elevation: 5,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40)),
            ),
          ),
          Container(
            height: 300,
            child: currentOrdersListView(global.currOrders),
          ),
          ButtonTheme(
            minWidth: 20.0,
            height: 30.0,
            child: RaisedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => OrderHistoryPage()));
              },
              color: Colors.blue,
              child: Padding(
                padding: const EdgeInsets.all(0),
                child: Text(
                  'View My Order History',
                  style: TextStyle(fontSize: 14, color: Colors.white),
                ),
              ),
              elevation: 5,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40)),
            ),
          ),
        ],
      ),
    );
  }
}
