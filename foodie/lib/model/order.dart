import 'package:cloud_firestore/cloud_firestore.dart';

enum OrderStatus {
  Rejected,
  Created,
  Confirmed,
  Delivering,
  Delivered
}

class OrderItem {
  String _dishName;
  double _unitPrice;
  int _quantity;

  OrderItem(String dishName, double unitPrice, int quantity) {
    this._dishName = dishName;
    this._unitPrice = unitPrice;
    this._quantity = quantity;
  }

  int get quantity => _quantity;

  set quantity(int value) {
    _quantity = value;
  }

  double get unitPrice => _unitPrice;

  set unitPrice(double value) {
    _unitPrice = value;
  }

  String get dishName => _dishName;

  set dishName(String value) {
    _dishName = value;
  }

  Map<String, dynamic> toMap() {
    return {
      'dishName': this._dishName,
      'unitPrice': this._unitPrice,
      'quantity': this._quantity,
    };
  }
}

class Order {
  String _orderID;
  String _orderName;
  String _deliveryPoint;
  DateTime _deliveryTimeStart;
  DateTime _deliveryTimeEnd;
  DateTime _orderTime;
  String _restaurantName;
  String _restaurantLocation;
  List<OrderItem> _items;
  int _status;
  double _totalPrice;
  String _userID;

  Order(
      String deliveryPoint,
      DateTime deliveryTimeStart,
      DateTime deliveryTimeEnd,
      DateTime orderTime,
      String restaurantName,
      String restaurantLocation,
      List<OrderItem> items,
      int status,
      String userID,
      ) {
    this._orderName = deliveryPoint + '-' + userID;
    this._deliveryPoint = deliveryPoint;
    this._deliveryTimeStart = deliveryTimeStart;
    this._deliveryTimeEnd = deliveryTimeEnd;
    this._orderTime = orderTime;
    this._restaurantName = restaurantName;
    this._restaurantLocation = restaurantLocation;
    this._items = items;
    this._status = status;
    this._userID = userID;
    double totalPrice = 0;
    items.forEach((item) {
      totalPrice += item.quantity * item.unitPrice;
    });
    this._totalPrice = totalPrice;
  }

  factory Order.fromDocument(DocumentSnapshot document) {
    return Order(
      document.get("deliveryPoint"),
      document.get("deliveryTimeStart").toDate(),
      document.get("deliveryTimeEnd").toDate(),
      document.get("orderTime").toDate(),
      document.get("restaurantName"),
      document.get("restaurantLocation"),
      document.get("items"),
      document.get("status"),
      document.get("userID"),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'orderName': this._orderName,
      'deliveryPoint': this._deliveryPoint,
      'deliveryTimeStart': this._deliveryTimeStart,
      'deliveryTimeEnd': this._deliveryTimeEnd,
      'orderTime': this._orderTime,
      'restaurantName': this._restaurantName,
      'restaurantLocation': this._restaurantLocation,
      'items': this._items.map((item) => item.toMap()).toList(),
      'status': this._status,
      'totalPrice': this._totalPrice,
      'userID': this._userID,
    };
  }


  String get orderID => _orderID;
  set orderID(String value) {
    _orderID = value;
  }

  String get orderName => _orderName;
  set orderName(String value) {
    _orderName = value;
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

  List<OrderItem> get items => _items;
  set items(List<OrderItem> value) {
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

  String get restaurantName => _restaurantName;
  set restaurantName(String value) {
    _restaurantName = value;
  }

  String get restaurantLocation => _restaurantLocation;
  set restaurantLocation(String value) {
    _restaurantLocation = value;
  }
}

Future<void> addOrder(Order order, {String collectionPath = "orders"}) {
  print('adding orders to firebase');
  return FirebaseFirestore.instance
      .collection(collectionPath)
      .add(order.toMap())
      .then((value) {
    print("Order added successfully");
  }).catchError((error) => print("Failed to add order: $error"));
}

Future<QuerySnapshot> getOrdersForUser(
    String userID,
    {String collectionPath = "orders"}) {
  return FirebaseFirestore.instance
      .collection(collectionPath)
      .where('userID', isEqualTo: userID)
      .get();
}

void printOrderDocument(DocumentSnapshot orderDocument) {
  print('orderID: ' + orderDocument.reference.id);
  print('orderName: '+ orderDocument.data()['orderName']);
  print('deliveryPoint: '+ orderDocument.data()['deliveryPoint']);
  print('deliveryTimeStart: '+ orderDocument.data()['deliveryTimeStart'].toString());
  print('deliveryTimeEnd: '+ orderDocument.data()['deliveryTimeEnd'].toString());
  print('restaurantName: '+ orderDocument.data()['restaurantName']);
  print('restaurantLocation: '+ orderDocument.data()['restaurantLocation']);
  print('items: '+ orderDocument.data()['items'].toString());
  print('status: '+ orderDocument.data()['status'].toString());
  print('totalPrice: '+ orderDocument.data()['totalPrice'].toString());
  print('userID: '+ orderDocument.data()['userID']);
}

Order getOrderFromDocument(DocumentSnapshot orderDocument) {
  String orderID = orderDocument.reference.id;
  String orderName = orderDocument.data()['orderName'];
  String deliveryPoint = orderDocument.data()['deliveryPoint'];
  DateTime deliveryTimeStart = DateTime.parse(orderDocument.data()['deliveryTimeStart'].toDate().toString());
  DateTime deliveryTimeEnd = DateTime.parse(orderDocument.data()['deliveryTimeEnd'].toDate().toString());
  DateTime orderTime = DateTime.parse(orderDocument.data()['orderTime'].toDate().toString());
  String restaurantName = orderDocument.data()['restaurantName'];
  String restaurantLocation = orderDocument.data()['restaurantLocation'];
  List<OrderItem> items = [];
  orderDocument.data()['items'].forEach((item) {
    OrderItem orderItem = new OrderItem(item['dishName'], item['unitPrice'], item['quantity']);
    items.add(orderItem);
  });
  int status = orderDocument.data()['status'];
  String userID = orderDocument.data()['userID'];

  Order order = new Order(deliveryPoint, deliveryTimeStart, deliveryTimeEnd, orderTime, restaurantName, restaurantLocation, items, status, userID);
  order.orderID = orderID;
  order.orderName = orderName;

  return order;
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
