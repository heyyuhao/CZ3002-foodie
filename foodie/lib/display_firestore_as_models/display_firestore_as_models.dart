import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foodie/models/user.dart';
import 'package:foodie/models/order.dart';

class DisplayDBModelWidget extends StatefulWidget {
  @override
  _DisplayDBModelWidget createState() => _DisplayDBModelWidget();
}

class _DisplayDBModelWidget extends State<DisplayDBModelWidget> {
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Retrieve db',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Retrieve db'),
        ),
        body: StreamBuilder(
          stream: Firestore.instance.collection('orders').snapshots(),
          builder: (context, snapshot){
            if(snapshot.data == null) return CircularProgressIndicator();
            Order order = Order.fromDocument(snapshot.data.documents[0]);
            return Column(
              children: <Widget>[
                // Text(snapshot.data.documents[0].get("deliveryTimeEnd")),
                Text(order.items[0]['price'].toString()),
              ],
            );
          },
        ),
      ),
    );
  }
}



