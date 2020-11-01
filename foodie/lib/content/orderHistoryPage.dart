import 'package:flutter/material.dart';
import 'package:foodie/content/orderHistoryWidget.dart';

class OrderHistoryPage extends StatefulWidget {
  OrderHistoryPage({Key key}) : super(key: key);

  @override
  _OrderHistoryPageState createState() => _OrderHistoryPageState();
}

class _OrderHistoryPageState extends State<OrderHistoryPage> {
  @override
  Widget build(BuildContext context) {
    Widget topBar() {
      String title = "My Order History";

      return AppBar(
        automaticallyImplyLeading: false,
        elevation: 1,
        backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
        title: Text(
          title,
          style: TextStyle(color: Colors.blue),
        ),
      );
    }

    Widget pageBody() {
      return Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              SizedBox(width: 20),
              Text(
                'Order History',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ],
          ),
          SizedBox(height: 10),
          OrderHistoryWidget(),
        ],
      );
    }

    return Scaffold(
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      appBar: topBar(),
      body: pageBody(),
    );
  }
}
