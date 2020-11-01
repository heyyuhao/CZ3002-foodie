import 'package:flutter/material.dart';
import 'package:foodie/model/order.dart';

Color getOrderStatusColor(int orderStatus) {
  if (orderStatus == OrderStatus.Rejected.index) {
    return Colors.red;
  }
  if (orderStatus == OrderStatus.Created.index) {
    return Colors.white;
  }
  if (orderStatus == OrderStatus.Confirmed.index) {
    return Colors.blue;
  }
  if (orderStatus == OrderStatus.Delivering.index) {
    return Colors.purpleAccent;
  }
  if (orderStatus == OrderStatus.Delivered.index) {
    return Colors.green;
  }
  return Colors.black;
}
