import 'package:flutter/material.dart';

// Import the firebase_core and cloud_firestore plugin
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


enum UserType {
  Client,
  Vendor,
  Deliveryman
}



class User {
  String _userEmail;
  int _userType;

  User(this._userEmail, this._userType);

  factory User.fromDocument(DocumentSnapshot document) {
    return User(
        document.get("userEmail"),
        document.get("userType"),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userEmail': this._userEmail,
      'userType': this._userType,
    };
  }

  String get userEmail => _userEmail;

  set userEmail(String value) {
    _userEmail = value;
  }

  int get userType => _userType;

  set userType(int value) {
    _userType = value;
  }

}

add_user_to_firestore(User user, {String collectionPath = "users"}){
  Firestore.instance
      .collection(collectionPath)
      .add(user.toMap())
      .then((value){print("User ${user.userEmail} added");})
      .catchError((error) => print("Failed to add user: $error"));
}

update_user_by_fields_in_firestore(String documentID, Map<String, dynamic> updates, {String collectionPath = "users"}) {
  FirebaseFirestore.instance
      .collection(collectionPath)
      .doc(documentID)
      .update(updates)
      .then((value) => print("User Updated"))
      .catchError((error) => print("Failed to update user: $error"));
}

update_user_by_instance_in_firestore(String documentID, User user, {String collectionPath = "users"}) {
  Map<String, dynamic> updates = user.toMap();
  update_user_by_fields_in_firestore(documentID, updates, collectionPath:collectionPath);
}

Future<DocumentSnapshot> get_user_documentsnapshot_by_documentID(String documentID, {String collectionPath = "users"}) {
  return FirebaseFirestore.instance
      .collection(collectionPath)
      .doc(documentID)
      .get();
}

class GetUserEmailByDocumentIDWidget extends StatelessWidget {
  final String documentID;
  final String collectionPath = "users";

  GetUserEmailByDocumentIDWidget(this.documentID);

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection(collectionPath);

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(documentID).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {

        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          User user = User.fromDocument(snapshot.data);
          return Text("${user.userEmail}");
        }

        return Text("loading");
      },
    );
  }
}

class GetUserEmailByDocumentPathWidget extends StatelessWidget {
  final String documentPath;

  GetUserEmailByDocumentPathWidget(this.documentPath);

  @override
  Widget build(BuildContext context) {

    return FutureBuilder<DocumentSnapshot>(
      future: Firestore.instance.doc(documentPath).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {

        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          User user = User.fromDocument(snapshot.data);
          return Text("${user.userEmail}");
        }

        return Text("loading");
      },
    );
  }
}



Future<QuerySnapshot> getClientByEmail(
    String email,
    {String collectionPath = "users"}) {
  return FirebaseFirestore.instance
      .collection(collectionPath)
      .where('userEmail', isEqualTo: email)
      .where('userType', isEqualTo: UserType.Client.index)
      .get();
}