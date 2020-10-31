import 'package:flutter/material.dart';
import 'package:foodie/global.dart' as global;
import 'package:foodie/model/cart.dart';
import 'package:foodie/content/checkOutPage.dart';


class CartPage extends StatefulWidget {
  CartPage({Key key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final String fallBackImage =
      "https://www.clipartmax.com/png/middle/138-1381067_fried-fish-fish-fry-roasting-fish-on-dish-cartoon.png";
  ListTile dishListTile(BuildContext context, CartItem cartItem) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(
          (cartItem.dish.picture != "") ? cartItem.dish.picture : fallBackImage,
        ),
        radius: 30,
        backgroundColor: Colors.transparent,
      ),
      title: Text(
        cartItem.dish.name,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      subtitle: Row(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: Padding(
                padding: EdgeInsets.only(bottom: 10.0),
                child: Text("Price: ", style: TextStyle(color: Colors.white))),
          ),
          Expanded(
            flex: 5,
            child: Padding(
                padding: EdgeInsets.only(bottom: 10.0),
                child: Text("${cartItem.dish.unitPrice}",
                    style: TextStyle(color: Colors.white))),
          ),
          Expanded(
            flex: 5,
            child: Padding(
                padding: EdgeInsets.only(bottom: 10.0),
                child:
                    Text("Qty: ", style: TextStyle(color: Colors.white))),
          ),
          Expanded(
            flex: 5,
            child: Padding(
                padding: EdgeInsets.only(bottom: 10.0),
                child: Text("${cartItem.quantity}",
                    style: TextStyle(color: Colors.white))),
          )
        ],
      ),
      trailing: IconButton(
          icon: Icon(
            Icons.delete,
            color: Colors.white,
            size: 30.0,
          ),
          onPressed: () {
            print('this item is deleted');
          }),
      onTap: () {
        print('this item is deleted');
      },
    );
  }

  Card dishCard(BuildContext context, CartItem cartItem) {
    return Card(
      elevation: 8.0,
      margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
        child: dishListTile(context, cartItem),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget topBar() {
      String title = "My Cart";
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
                'My Cart Items',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ],
          ),
          SizedBox(height: 10),
          Container(
            height: 490,
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: global.getCartItems().length,
              itemBuilder: (BuildContext context, int index) {
                return dishCard(context, global.getCartItems()[index]);
              },
            ),
          ),
          ButtonTheme(
            minWidth: 120.0,
            height: 35.0,
            child: RaisedButton(
              onPressed: (global.getCartItems().length > 0) ? () {
                print('check out');
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CheckOutPage()));
              } : null,
              color: (global.getCartItems().length > 0) ? Colors.blue : Colors.grey,
              child: Padding(
                padding: const EdgeInsets.all(0),
                child: Text(
                  'Check Out',
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
