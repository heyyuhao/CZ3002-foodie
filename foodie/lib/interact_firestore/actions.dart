import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FavoriteWidget extends StatefulWidget {
  @override
  _FavoriteWidgetState createState() => _FavoriteWidgetState();
}

class _FavoriteWidgetState extends State<FavoriteWidget> {
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



