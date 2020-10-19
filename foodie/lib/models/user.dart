import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String _name;
  String _email;
  int _age;
  Map<String,dynamic> _address;

  User(this._name, this._email, this._age, this._address);

  factory User.fromDocument(DocumentSnapshot document) {
    return User(
        document.get("name"),
        document.get("email"),
        document.get("age"),
        document.get("address"),
    );
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  String get email => _email;

  set email(String value) {
    _email = value;
  }

  int get age => _age;

  set age(int value) {
    _age = value;
  }

  Map<String, dynamic> get address => _address;

  set address(Map<String, dynamic> value) {
    _address = value;
  }

}
