import 'package:folding_cell/folding_cell.dart';
import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:foodie/getfood/payment1.dart';
import 'package:foodie/getfood/MainPage.dart';
import 'package:toast/toast.dart';

class OrderPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ExampleState();
}

class _ExampleState extends State<OrderPage> {
//  List<String> _locations = ['Please choose a location', 'A', 'B', 'C', 'D']; // Option 1
//  String _selectedLocation = 'Please choose a location'; // Option 1
  List<String> _locations = [
    'NTUU North Spine - LT19A',
    'NTU South Spine S2-B3',
    'Hall 1',
    'Hall 2'
  ]; // Option 2
  List<String> _times = [
    '12:20 - 12:50',
    '13:20 - 13:50',
    '18:00 - 19:00'
  ]; // Option 2
  String _selectedLocation; // Option 2
  String _selectedTime;
  final _formKey = GlobalKey<FormState>();
  bool _autovalidate = false;
  String dlvry_location;
  String dlvry_time;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: new AppBar(
        //   title: const Text('Canteens'),
        //   actions: <Widget>[
        //     IconButton(
        //       icon: Icon(
        //         Icons.shopping_cart,
        //         color: Colors.white,
        //       ),
        //       onPressed: () {
        //         Navigator.push(
        //           context,
        //           MaterialPageRoute(builder: (context) => ()),
        //         );
        //       },
        //     )
        //   ],
        // ),
        body: Container(
      // color: Colors.black,
      child: Column(
        children: <Widget>[
          // Positioned and Non-positioned Widget...
          Container(
              // constraints: BoxConstraints.expand(height: 60),
              child: Stack(
            textDirection: TextDirection.rtl,
            // alignment: Alignment.topLeft,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 10),
                padding: EdgeInsets.all(10.0),
                height: 200,
                width: 500,
                child: Center(
                  child: Table(
                    columnWidths: {
                      0: FixedColumnWidth(160),
                      1: FixedColumnWidth(160)
                    },
                    border: TableBorder(
                        horizontalInside: BorderSide(
                            width: 0.8,
                            color: Colors.grey,
                            style: BorderStyle.solid),
                      bottom: BorderSide( //                    <--- top side
                        color: Colors.grey,
                        width: 0.8,
                      ),),

                    children: [
                      TableRow(children: [
                        Text('Stall',
                            textAlign: TextAlign.left,
                            style: TextStyle(fontWeight: FontWeight.normal, fontSize:15, color: Colors.grey)),
                        Text('Item',
                            textAlign: TextAlign.left,
                            style: TextStyle(fontWeight: FontWeight.normal, fontSize:15, color: Colors.grey)),
                        Text('Price',
                            textAlign: TextAlign.left,
                            style: TextStyle(fontWeight: FontWeight.normal, fontSize:15, color: Colors.grey)),
                      ]),
                      TableRow(children: [
                        Text('Local Delights',
                            textAlign: TextAlign.left,
                            style: TextStyle(fontWeight: FontWeight.normal, fontSize:15)),
                        Text('Veg Noodles',
                            textAlign: TextAlign.left,
                            style: TextStyle(fontWeight: FontWeight.normal, fontSize:15)),
                        Text('4SGD',
                            textAlign: TextAlign.left,
                            style: TextStyle(fontWeight: FontWeight.normal, fontSize:15)),
                      ]),
                      // TableRow(children: [
                      //   Text('Cell 4'),
                      //   Text('Cell 5'),
                      //   Text('Cell 6'),
                      // ])
                    ],
                  ),
                ),
              ),
            ],
          )),
          Container(
              // margin: EdgeInsets.only(top: 20),
            padding: EdgeInsets.all(20.0),
              margin: EdgeInsets.only(top: 10),
              child:
                Form(
                key: _formKey,
                autovalidate: _autovalidate,
                child: Column(
                  children: <Widget>[
                    DropdownButtonFormField<String>(
                      value: dlvry_location,
                      hint: Text(
                        'Delivery Location',
                      ),
                      onChanged: (dl_time) =>
                          setState(() => dlvry_location = dl_time),
                      validator: (value) => value == null ? 'field required' : null,
                      items:
                      ['NTU North Spine LT19', 'NTU South Spine LT23', 'Hall 1'].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                    DropdownButtonFormField<String>(
                      value: dlvry_time,
                      hint: Text(
                        'Delivery Time',
                      ),
                      onChanged: (dl_time) =>
                          setState(() => dlvry_time = dl_time),
                      validator: (value) => value == null ? 'field required' : null,
                      items:
                      ['12:00 - 13:30', '18:00 - 19:30'].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                    FlatButton(
                      child: Text('Pay',
                          style: TextStyle(color: Colors.white)),
                      color: Colors.lightBlue,
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          //form is valid, proceed further
                          _formKey.currentState.save();//save once fields are valid, onSaved method invoked for every form fields
                            Toast.show("Payment Success", context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) =>VendorPage()),
                            );
                        } else {
                          setState(() {
                            _autovalidate = true; //enable realtime validation
                          });
                        }
                      },
                    )
                  ],
                ),
              ),
          ),
                // DropdownButton(
                //   hint: Text('Please choose a location'),
                //   // Not necessary for Option 1
                //   value: _selectedLocation,
                //   onChanged: (newValue) {
                //     setState(() {
                //       _selectedLocation = newValue;
                //     });
                //   },
                //   items: _locations.map((location) {
                //     return DropdownMenuItem(
                //       child: new Text(location),
                //       value: location,
                //     );
                //   }).toList(),
                // ),
          // Container(
          //   margin: EdgeInsets.only(top: 10),
          //   child: Stack(alignment: Alignment.topLeft, children: <Widget>[
          //     DropdownButton(
          //       hint: Text('Please choose a time'),
          //       // Not necessary for Option 1
          //       value: _selectedTime,
          //       onChanged: (newValue) {
          //         setState(() {
          //           _selectedTime = newValue;
          //         });
          //       },
          //       items: _times.map((time) {
          //         return DropdownMenuItem(
          //           child: new Text(time),
          //           value: time,
          //         );
          //       }).toList(),
          //     ),
          //   ]),
          // ),
          // Container(
          //   margin: EdgeInsets.only(top:10),
          //   child: Stack(alignment: Alignment.topLeft, children: <Widget>[
          //       new RaisedButton(
          //                 textColor: Colors.white,
          //                 color: Colors.blue,
          //                 elevation: 2.0,
          //                 padding: const EdgeInsets.all(8.0),
          //                 child: new Text("Pay",
          //                     style: new TextStyle(
          //                         color: Colors.white, fontSize: 20.0)),
          //                 onPressed: () {
          //                   Toast.show("Payment Success", context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
          //                   Navigator.push(
          //                     context,
          //                     MaterialPageRoute(builder: (context) =>VendorPage()),
          //                   );
          //                 },
          //       ),
          //   ])
          // )
        ],
      ),
    )
        //     child:Stack(
        //       alignment: Alignment.center,
        //   // mainAxisAlignment: MainAxisAlignment.s,
        //   //     crossAxisAlignment: CrossAxisAlignment.r,
        //   children: <Widget>[
        //     Positioned(
        //       // alignment: Alignment(-0.9, -0.5),
        //       top:10.0,
        //       left:10.0,
        //       height:10,
        //       child:
        //       // Container(
        //         // height: 50.0,
        //         // width: 100.0,
        //         // color: Colors.white,
        //         // padding: EdgeInsets.all(15.0),
        //         // child:
        //         Table(
        //           columnWidths: {
        //             0: FixedColumnWidth(150),
        //             1: FixedColumnWidth(150)
        //           },
        //           border: TableBorder(horizontalInside: BorderSide(width: 0.5, color: Colors.grey, style: BorderStyle.solid)),
        //           children: [
        //             TableRow(children: [
        //               Text('Cell 1', textAlign: TextAlign.left, style: TextStyle(fontWeight: FontWeight.normal)),
        //               Text('Cell 1', textAlign: TextAlign.left, style: TextStyle(fontWeight: FontWeight.normal)),
        //               Text('Cell 1', textAlign: TextAlign.left, style: TextStyle(fontWeight: FontWeight.normal)),
        //             ]),
        //             TableRow(children: [
        //               Text('Cell 4'),
        //               Text('Cell 5'),
        //               Text('Cell 6'),
        //             ])
        //           ],
        //         ),
        //       ),
        //     // ),
        //
        //
        //     Positioned(
        //       // alignment: Alignment(-0.9, 0.6),
        //       top:5,
        //       child:DropdownButton(
        //         hint: Text('Please choose a location'),
        //         // Not necessary for Option 1
        //         value: _selectedLocation,
        //         onChanged: (newValue) {
        //           setState(() {
        //             _selectedLocation = newValue;
        //           });
        //         },
        //         items: _locations.map((location) {
        //           return DropdownMenuItem(
        //             child: new Text(location),
        //             value: location,
        //           );
        //         }).toList(),
        //       ),
        //     ),
        //
        //     Positioned(
        //       // alignment: Alignment(-0.9, 0.7),
        //       top: 3,
        //       child:
        //       DropdownButton(
        //         hint: Text('Please choose a time'),
        //         // Not necessary for Option 1
        //         value: _selectedTime,
        //         onChanged: (newValue) {
        //           setState(() {
        //             _selectedTime = newValue;
        //           });
        //         },
        //         items: _times.map((time) {
        //           return DropdownMenuItem(
        //             child: new Text(time),
        //             value: time,
        //           );
        //         }).toList(),
        //       ),
        //     ),
        //
        //     Positioned(
        //         child:
        //         new RaisedButton(
        //           textColor: Colors.white,
        //           color: Colors.blue,
        //           elevation: 2.0,
        //           padding: const EdgeInsets.all(8.0),
        //           child: new Text("Pay",
        //               style: new TextStyle(
        //                   color: Colors.white, fontSize: 20.0)),
        //           onPressed: () {
        //             Navigator.push(
        //               context,
        //               MaterialPageRoute(builder: (context) => PayPage()),
        //             );
        //           },
        //         ),
        //     ),
        //
        //   ],
        // )

        );
  }
}
