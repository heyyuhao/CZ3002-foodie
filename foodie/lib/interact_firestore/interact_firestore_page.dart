import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foodie/model/user.dart';

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
                    // User user = new User("email1", -1);
                    // add_user_to_firestore(user);
                  },
                  color: Colors.deepPurple,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Add User -1',
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
                    // update_user_by_fields_in_firestore("pfOc90lJSibTbsgQn04v", {"address": {"city": "singapore1", "street": "street1"}}, collectionPath:"testings");
                  },
                  color: Colors.deepPurple,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Update testing',
                      style: TextStyle(fontSize: 25, color: Colors.white),
                    ),
                  ),
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40)),
                ),
                SizedBox(height: 40),
                // RaisedButton(
                //   onPressed: () {
                //     Navigator.of(context).push(
                //       MaterialPageRoute(
                //         builder: (context) {
                //           return DisplayDBModelWidget();
                //         },
                //       ),
                //     );
                //   },
                //   color: Colors.yellow,
                //   child: Padding(
                //     padding: const EdgeInsets.all(8.0),
                //     child: Text(
                //       'Retrieve from DB',
                //       style: TextStyle(fontSize: 25, color: Colors.white),
                //     ),
                //   ),
                //   elevation: 5,
                //   shape: RoundedRectangleBorder(
                //       borderRadius: BorderRadius.circular(40)),
                // ),
                // SizedBox(height: 40),
                // RaisedButton(
                //   onPressed: () {
                //     // get_user_documentsnapshot_by_documentID("0d6ubxYogJfX81TH5flO").then((documentSnapshot){
                //     //   User user = User.fromDocument(documentSnapshot);
                //       print('asdf');
                //     });
                //   },
                //   child: Text('Get data'),
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }
}





