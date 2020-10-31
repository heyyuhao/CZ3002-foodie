import 'package:flutter/material.dart';
import 'package:foodie/global.dart' as global;

class CheckOutPage extends StatefulWidget {
  CheckOutPage({Key key}) : super(key: key);

  @override
  _CheckOutPageState createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {
  String selectedDeliveryTime;
  List<String> deliveryTimeChoices = <String>[
    'Today Lunch',
    'Today Dinner',
    'Tomorrow Lunch',
    'Tomorrow Dinner'
  ];

  Widget dropDownDeliveryTime() {
    return DropdownButton<String>(
      hint: Text("Select Delivery Time",
          style: TextStyle(
            fontFamily: 'Raleway',
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          )),
      value: selectedDeliveryTime,
      onChanged: (String value) {
        setState(() {
          selectedDeliveryTime = value;
        });
      },
      items: deliveryTimeChoices.map((String deliveryTimeChoice) {
        return DropdownMenuItem<String>(
          value: deliveryTimeChoice,
          child: Row(
            children: <Widget>[
              Text(
                deliveryTimeChoice,
                style: TextStyle(
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

  String selectedDeliveryPoint;
  List<String> deliveryPointChoices = <String>[
    'Crescent Hall',
    'Hall 3',
    'Hall 4',
    'Hall 8',
    'North Hill'
  ];

  Widget dropDownDeliveryPoint() {
    return DropdownButton<String>(
      hint: Text("Select Delivery Point",
          style: TextStyle(
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
            height: 240,
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
                  fontSize: 16,
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
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            SizedBox(width: 20),
            dropDownDeliveryPoint()
          ]),
          SizedBox(height: 55),
          ButtonTheme(
            minWidth: 80.0,
            height: 35.0,
            child: RaisedButton(
              onPressed: () {
                print('Payment received');
              },
              color: Colors.blue,
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
