import 'package:cloud_firestore/cloud_firestore.dart';

class Dish {
  String _dishID;
  String _name;
  String _picture;
  double _unitPrice;

  Dish(this._dishID, this._name, this._picture, this._unitPrice);

  String get dishID => _dishID;

  set dishID(String value) {
    _dishID = value;
  }

  double get unitPrice => _unitPrice;
  set unitPrice(double value) {
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
  String _restaurantID;
  String _name;
  String _location;
  String _ownerID;
  List<Dish> _dishes;

  Restaurant(this._restaurantID, this._name, this._location, this._dishes);

  String get restaurantID => _restaurantID;

  set restaurantID(String value) {
    _restaurantID = value;
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

Future<QuerySnapshot> getRestaurantByVendor(
    DocumentReference vendor,
    {String collectionPath = 'restaurants'}) {
  return FirebaseFirestore.instance
      .collection(collectionPath)
      .where('owner', isEqualTo: vendor)
      .get();
}

Future<Restaurant> getRestaurantFromDocument(DocumentSnapshot restaurantDocument) async {
  String restaurantID = restaurantDocument.reference.id;
  String location = restaurantDocument.data()['location'];
  String name = restaurantDocument.data()['name'];

  List<DocumentSnapshot> dishDocuments = (await restaurantDocument.reference.collection('dishes').get()).docs;
  List<Dish> dishes = [];

  dishDocuments.forEach((dishDocument) {
    dishes.add(getDishFromDocument(dishDocument));
  });

  Restaurant restaurant = new Restaurant(restaurantID, name, location, dishes);
  return restaurant;
}

Dish getDishFromDocument(DocumentSnapshot dishDocument) {
  String dishID = dishDocument.reference.id;
  String name = dishDocument.data()['name'];
  String picture = dishDocument.data()['picture'];
  double price = dishDocument.data()['price'].toDouble();

  Dish dish = new Dish(dishID,name,  picture, price);
  return dish;
}