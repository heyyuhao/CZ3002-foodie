import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
          stream: Firestore.instance.collection('testings').snapshots(),
          builder: (context, snapshot){
            if(snapshot.data == null) return CircularProgressIndicator();
            return Column(
              children: <Widget>[
                Text("Here is the data from 'testing > 0 > name&email'"),
                Text(snapshot.data.documents[0].get("name")),
                Text(snapshot.data.documents[0].get("email"))
              ],
            );
          },
        ),
      ),
    );
  }
}



