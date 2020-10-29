import 'package:flutter/material.dart';
import 'package:foodie/auth/googleAuth.dart';
import 'package:foodie/auth/loginPage.dart';
import 'package:foodie/content/orderHistoryWidget.dart';

class ProfilePage extends StatelessWidget {
  final String fallBackImage =
      "https://www.clipartmax.com/png/middle/138-1381067_fried-fish-fish-fry-roasting-fish-on-dish-cartoon.png";
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Color.fromRGBO(58, 66, 86, 1.0),
            Color.fromRGBO(58, 66, 86, 1.0)
          ],
        ),
      ),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(width: 30),
              CircleAvatar(
                backgroundImage: NetworkImage(
                  appUser.imageUrl,
                ),
                radius: 30,
                backgroundColor: Colors.transparent,
              ),
              SizedBox(width: 15),
              Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Text(
                            'Name:',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          SizedBox(width: 15),
                          Text(
                            appUser.userName,
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ]),
                    SizedBox(height: 10),
                    Text(
                      appUser.userEmail,
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ])
            ],
          ),
          ButtonTheme(
            minWidth: 10.0,
            height: 20.0,
            child: RaisedButton(
              onPressed: () {
                signOutGoogle();
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) {
                  return LoginPage();
                }), ModalRoute.withName('/'));
              },
              color: Colors.blue,
              child: Padding(
                padding: const EdgeInsets.all(0),
                child: Text(
                  'Sign Out',
                  style: TextStyle(fontSize: 12, color: Colors.white),
                ),
              ),
              elevation: 5,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40)),
            ),
          ),
          Row(
            children: <Widget>[
              SizedBox(width: 20),
              Text(
                'Order History',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ],
          ),
          SizedBox(height: 10),
          OrderHistoryWidget(),
        ],
      ),
    );
  }
}
