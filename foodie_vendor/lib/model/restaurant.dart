import 'package:cloud_firestore/cloud_firestore.dart';

class Dish {
  String _name;
  String _picture;
  String _unitPrice;

  Dish(this._name, this._picture, this._unitPrice);

  String get unitPrice => _unitPrice;
  set unitPrice(String value) {
    _unitPrice = value;
  }

  String get picture => _picture;
  set picture(String value) {
    _picture = value;
  }

  String get name => _name;
  set name(String value) {
    _name = value;
  }
}

class Restaurant {
  String _name;
  String _location;
  String _ownerID;
  List<Dish> _dishes;
  String _telephone;

  Restaurant(this._name, this._location, this._ownerID, this._dishes,
      this._telephone);

  String get telephone => _telephone;
  set telephone(String value) {
    _telephone = value;
  }

  List<Dish> get dishes => _dishes;
  set dishes(List<Dish> value) {
    _dishes = value;
  }

  String get ownerID => _ownerID;
  set ownerID(String value) {
    _ownerID = value;
  }

  String get location => _location;
  set location(String value) {
    _location = value;
  }

  String get name => _name;
  set name(String value) {
    _name = value;
  }
}
