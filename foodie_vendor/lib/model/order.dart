class Order {
  String orderName;
  String pickupLocation;
  String deliveryLocation;
  double price;
  String content;
  List<Dish> dishes;


  Order(
      {this.orderName,
        this.pickupLocation,
        this.deliveryLocation,
        this.price,
        this.content,
        this.dishes
      }
      );
}

class Dish{
  String dishName;
  double dishPrice;
  int dishQuantity;

  Dish(
      {this.dishName,
        this.dishPrice,
        this.dishQuantity
      }
      );
}
