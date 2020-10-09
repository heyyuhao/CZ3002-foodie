import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foodie/display_firestore_as_models/display_firestore_as_models.dart';

class InteractDBWidget extends StatefulWidget {
  @override
  _InteractDBWidgetState createState() => _InteractDBWidgetState();
}

class _InteractDBWidgetState extends State<InteractDBWidget> {
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Interact db',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Interact db 2'),
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Colors.blue[100], Colors.blue[400]],
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                SizedBox(height: 40),
                RaisedButton(
                  onPressed: () {
                    final firestoreInstance = Firestore.instance;
                    firestoreInstance.collection("testings").add(
                        {
                          "name" : "john",
                          "age" : 50,
                          "email" : "example@example.com",
                          "address" : {
                            "street" : "street 24",
                            "city" : "new york"
                          }
                        }).then((value){
                      print(value.documentID);
                    });
                  },
                  color: Colors.deepPurple,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Add to DB',
                      style: TextStyle(fontSize: 25, color: Colors.white),
                    ),
                  ),
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40)),
                ),
                SizedBox(height: 40),
                RaisedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return DisplayDBModelWidget();
                        },
                      ),
                    );
                  },
                  color: Colors.yellow,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Retrieve from DB',
                      style: TextStyle(fontSize: 25, color: Colors.white),
                    ),
                  ),
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40)),
                ),
                SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}





// StreamBuilder(
//           stream: Firestore.instance.collection('testings').snapshots(),
//           builder: (context, snapshot){
//             if(snapshot.data == null) return CircularProgressIndicator();
//             return Column(
//               children: <Widget>[
//                 Text("Here is the data from 'testing > 0 > name&email'"),
//                 Text(snapshot.data.documents[0].get("name")),
//                 Text(snapshot.data.documents[0].get("email"))
//               ],
//             );
//           },
//         ),



