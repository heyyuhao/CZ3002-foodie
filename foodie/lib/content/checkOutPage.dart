import 'package:flutter/material.dart';
import 'package:foodie/global.dart' as global;
import 'package:foodie/model/order.dart';
import 'package:foodie/content/deliveryPointChoice.dart';
import 'package:foodie/content/deliveryTimeChoice.dart';
import 'package:foodie/content/contentPage.dart';

class CheckOutPage extends StatefulWidget {
  CheckOutPage({Key key}) : super(key: key);

  @override
  _CheckOutPageState createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {
  DeliveryTimeChoice selectedDeliveryTime;
  List<DeliveryTimeChoice> deliveryTimeChoices = getDeliveryTimeChoices();

  Widget dropDownDeliveryTime() {
    return DropdownButton<DeliveryTimeChoice>(
      hint: Text("Select Delivery Time",
          style: TextStyle(
            fontSize: 14,
            fontFamily: 'Raleway',
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          )),
      value: selectedDeliveryTime,
      onChanged: (DeliveryTimeChoice value) {
        setState(() {
          selectedDeliveryTime = value;
        });
      },
      items: deliveryTimeChoices.map((DeliveryTimeChoice deliveryTimeChoice) {
        return DropdownMenuItem<DeliveryTimeChoice>(
          value: deliveryTimeChoice,
          child: Text(
            deliveryTimeChoice.deliveryTimeStartStr,
            style: TextStyle(
              fontSize: 14,
              fontFamily: 'Raleway',
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
        );
      }).toList(),
    );
  }

  String selectedDeliveryPoint;
  List<String> deliveryPointChoices = getDeliveryPointChoices();

  Widget dropDownDeliveryPoint() {
    return DropdownButton<String>(
      hint: Text("Select Delivery Point",
          style: TextStyle(
            fontSize: 14,
            fontFamily: 'Raleway',
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          )),
      value: selectedDeliveryPoint,
      onChanged: (String value) {
        setState(() {
          selectedDeliveryPoint = value;
        });
      },
      items: deliveryPointChoices.map((String deliveryPointChoice) {
        return DropdownMenuItem<String>(
          value: deliveryPointChoice,
          child: Row(
            children: <Widget>[
              Text(
                deliveryPointChoice,
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Raleway',
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  bool _ableToPlaceOrder() {
    return (selectedDeliveryTime != null && selectedDeliveryPoint != null);
  }

  Widget orderSummary() {
    List<DataRow> dataRows = [];

    global.getCartItems().forEach((item) {
      dataRows.add(DataRow(
        cells: <DataCell>[
          DataCell(Text(
            item.dish.name,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          )),
          DataCell(Text(
            item.quantity.toString(),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          )),
          DataCell(Text(
            (item.quantity * item.dish.unitPrice).toString(),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          )),
        ],
      ));
    });

    return DataTable(
      columns: const <DataColumn>[
        DataColumn(
          label: Text(
            'Dish Name',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        DataColumn(
          label: Text(
            'Quantity',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        DataColumn(
          label: Text(
            'Price',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ],
      rows: dataRows,
    );
  }

  Order constructOrder() {
    List<OrderItem> orderItems = [];
    global.getCartItems().forEach((item) {
      orderItems.add(
          new OrderItem(item.dish.name, item.dish.unitPrice, item.quantity));
    });

    Order orderToAdd = new Order(
        selectedDeliveryPoint,
        selectedDeliveryTime.deliveryTimeStart,
        selectedDeliveryTime.deliveryTimeEnd,
        DateTime.now(),
        global.currentRestaurant.name,
        global.currentRestaurant.location,
        orderItems,
        OrderStatus.Created.index,
        global.appUser.userID);

    print('add order');

    print(orderToAdd.toString());

    // add order to firebase
    addOrder(orderToAdd);

    // add this order to current order as well
    global.addToCurrentOrders(orderToAdd);

    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context) => ContentPage()
        ),
            (Route<dynamic> route) => false
    );

  }

  @override
  Widget build(BuildContext context) {
    Widget topBar() {
      String title = "Check Out Order";
      return AppBar(
        automaticallyImplyLeading: false,
        elevation: 1,
        backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
        title: Text(
          title,
          style: TextStyle(color: Colors.blue),
        ),
      );
    }

    Widget pageBody() {
      return Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              SizedBox(width: 20),
              Text(
                global.currentRestaurant.name,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: <Widget>[
              SizedBox(width: 20),
              Icon(
                Icons.location_on,
                color: Colors.white,
              ),
              Text(
                global.currentRestaurant.location,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ],
          ),
          SizedBox(height: 30),
          Container(
            height: 290,
            child: Column(
              children: [
                orderSummary(),
                SizedBox(height: 15),
                Row(children: <Widget>[
                  SizedBox(width: 170),
                  Text(
                    "Total Price: S\$${global.getCartTotalPrice().toStringAsFixed(2)}",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ]),
              ],
            ),
          ),
          SizedBox(height: 15),
          Row(children: <Widget>[
            SizedBox(width: 20),
            Text(
              "Delivery Time: ",
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            SizedBox(width: 20),
            dropDownDeliveryTime()
          ]),
          SizedBox(height: 20),
          Row(children: <Widget>[
            SizedBox(width: 20),
            Text(
              "Delivery Point: ",
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            SizedBox(width: 20),
            dropDownDeliveryPoint()
          ]),
          SizedBox(height: 15),
          ButtonTheme(
            minWidth: 80.0,
            height: 35.0,
            child: RaisedButton(
              onPressed: _ableToPlaceOrder()
                  ? () {
                      print('Order Placed');
                      constructOrder();
                    }
                  : null,
              color: _ableToPlaceOrder() ? Colors.blue : Colors.grey,
              child: Padding(
                padding: const EdgeInsets.all(0),
                child: Text(
                  'Place Order and Pay',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
              elevation: 5,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40)),
            ),
          ),
        ],
      );
    }

    return Scaffold(
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      appBar: topBar(),
      body: pageBody(),
    );
  }
}
