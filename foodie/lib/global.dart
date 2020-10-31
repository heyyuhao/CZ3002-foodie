import 'dart:collection';
import 'package:foodie/model/user.dart';
import 'package:foodie/model/order.dart';
import 'package:foodie/model/cart.dart';
import 'package:foodie/model/restaurant.dart';

User appUser;
Order currOrder;
Restaurant currentRestaurant;
HashMap<Dish, int> cartItemsMap = new HashMap();


void addDishToCart(Dish dish) {
  if (cartItemsMap.containsKey(dish)) {
    cartItemsMap[dish] += 1;
  } else {
    cartItemsMap[dish] = 1;
  }
}


void setCurrentRestaurant(Restaurant restaurant) {
  currentRestaurant = restaurant;
}

List<CartItem> getCartItems() {
  List<CartItem> cartItems = [];
  cartItemsMap.forEach((dish, quantity) {
    cartItems.add(new CartItem(dish, quantity));
  });
  return cartItems;
}

void setCurrentOrder() {
  return ;
}


double getCartTotalPrice() {
  double totalPrice = 0;
  cartItemsMap.forEach((dish, quantity) {
    totalPrice += dish.unitPrice * quantity;
  });

  return totalPrice;
}