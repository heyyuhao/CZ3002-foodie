import 'package:cloud_firestore/cloud_firestore.dart';

class Order {
  String _deliveryPoint;
  DateTime _deliveryTimeStart;
  DateTime _deliveryTimeEnd;
  DateTime _orderTime;
  Map<String,dynamic> _restaurant;
  List _items;
  num _status;
  num _totalPrice;
  String _userID;

  Order(
      this._deliveryPoint,
      this._deliveryTimeStart,
      this._deliveryTimeEnd,
      this._orderTime,
      this._restaurant,
      this._items,
      this._status,
      this._totalPrice,
      this._userID);

  factory Order.fromDocument(DocumentSnapshot document) {
    return Order(
      document.get("deliveryPoint"),
      document.get("deliveryTimeStart").toDate(),
      document.get("deliveryTimeEnd").toDate(),
      document.get("orderTime").toDate(),
      document.get("restaurant"),
      document.get("items"),
      document.get("status"),
      document.get("totalPrice"),
      document.get("userID"),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'deliveryPoint': this._deliveryPoint,
      'deliveryTimeStart': this._deliveryTimeStart,
      'deliveryTimeEnd': this._deliveryTimeEnd,
      'orderTime': this._orderTime,
      'restaurant': this._restaurant,
      'items': this._items,
      'status': this._status,
      'totalPrice': this._totalPrice,
      'userID': this._userID,
    };
  }

  String get deliveryPoint => _deliveryPoint;
  set deliveryPoint(String value) {
    _deliveryPoint = value;
  }

  DateTime get deliveryTimeStart => _deliveryTimeStart;
  String get deliveryTimeStartInString => _deliveryTimeStart.toString();
  set deliveryTimeStart(DateTime value) {
    _deliveryTimeStart = value;
  }

  DateTime get deliveryTimeEnd => _deliveryTimeEnd;
  String get deliveryTimeEndInString => _deliveryTimeEnd.toString();
  set deliveryTimeEnd(DateTime value) {
    _deliveryTimeEnd = value;
  }

  DateTime get orderTime => _orderTime;
  String get orderTimeInString => _orderTime.toString();
  set orderTime(DateTime value) {
    _orderTime = value;
  }

  Map<String, dynamic> get restaurant => _restaurant;
  set restaurant(Map<String, dynamic> value) {
    _restaurant = value;
  }

  List get items => _items;
  set items(List value) {
    _items = value;
  }

  num get status => _status;
  set status(num value) {
    _status = value;
  }

  num get totalPrice => _totalPrice;
  set totalPrice(num value) {
    _totalPrice = value;
  }

  String get userID => _userID;
  set userID(String value) {
    _userID = value;
  }
}

add_order_to_firestore(Order order, {String collectionPath = "orders"}){
  Firestore.instance
      .collection(collectionPath)
      .add(order.toMap())
      .then((value){print("Order added");})
      .catchError((error) => print("Failed to add order: $error"));
}

update_order_by_fields_in_firestore(String documentID, Map<String, dynamic> updates, {String collectionPath = "orders"}) {
  FirebaseFirestore.instance
      .collection(collectionPath)
      .doc(documentID)
      .update(updates)
      .then((value) => print("Order Updated"))
      .catchError((error) => print("Failed to update order: $error"));
}

update_user_by_instance_in_firestore(String documentID, Order order, {String collectionPath = "orders"}) {
  Map<String, dynamic> updates = order.toMap();
  update_order_by_fields_in_firestore(documentID, updates, collectionPath:collectionPath);
}

Future<DocumentSnapshot> get_order_documentsnapshot_by_documentID(String documentID, {String collectionPath = "orders"}) {
  return FirebaseFirestore.instance
      .collection(collectionPath)
      .doc(documentID)
      .get();
}
