import 'package:foodie/model/restaurant.dart';

class CartItem {
  Dish _dish;
  int _quantity;

  CartItem(this._dish, this._quantity);

  Dish get dish => _dish;

  set dish(Dish value) {
    _dish = value;
  }

  int get quantity => _quantity;

  set quantity(int value) {
    _quantity = value;
  }
}