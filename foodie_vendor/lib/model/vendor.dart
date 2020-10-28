import 'package:cloud_firestore/cloud_firestore.dart';

enum UserType {
  Client,
  Vendor,
  Deliveryman
}

class Vendor {
  String _name;
  String _userID;
  String _email;

  Vendor(String name, String userID, String email) {
    this._name = name;
    this._userID = userID;
    this._email = email;
  }


  String get name => _name;

  set name(String value) {
    _name = value;
  }

  String get userID => _userID;

  set userID(String value) {
    _userID = value;
  }

  String get email => _email;

  set email(String value) {
    _email = value;
  }
}

Future<QuerySnapshot> getVendorByEmail(
    String email,
    {String collectionPath = "users"}) {
  return FirebaseFirestore.instance
      .collection(collectionPath)
      .where('userEmail', isEqualTo: email)
      .where('userType', isEqualTo: UserType.Vendor.index)
      .get();
}

Vendor getVendorFromDocument(DocumentSnapshot userDocument) {
  String userID = userDocument.reference.id;
  String userName = userDocument.data()['userName'];
  String email = userDocument.data()['userEmail'];

  Vendor user = new Vendor(userID, userName, email);
  return user;
}