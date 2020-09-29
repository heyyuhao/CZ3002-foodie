import 'package:folding_cell/folding_cell.dart';
import 'package:flutter/material.dart';
import 'package:foodie/getfood/payment1.dart';

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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body:
            // child:
            Column(
          // mainAxisAlignment: MainAxisAlignment.s,
          //     crossAxisAlignment: CrossAxisAlignment.r,
          children: <Widget>[
            Align(
              alignment: Alignment(-0.9, -0.5),
              child:
              Container(
                height: 50.0,
                // width: 100.0,
                color: Colors.white,
                padding: EdgeInsets.all(15.0),
                child: Table(
                  columnWidths: {
                    0: FixedColumnWidth(150),
                    1: FixedColumnWidth(150)
                  },
                  border: TableBorder(horizontalInside: BorderSide(width: 0.5, color: Colors.grey, style: BorderStyle.solid)),
                  children: [
                    TableRow(children: [
                      Text('Cell 1', textAlign: TextAlign.left, style: TextStyle(fontWeight: FontWeight.normal)),
                      Text('Cell 1', textAlign: TextAlign.left, style: TextStyle(fontWeight: FontWeight.normal)),
                      Text('Cell 1', textAlign: TextAlign.left, style: TextStyle(fontWeight: FontWeight.normal)),
                    ]),
                    TableRow(children: [
                      Text('Cell 4'),
                      Text('Cell 5'),
                      Text('Cell 6'),
                    ])
                  ],
                ),
              ),
            ),


            Align(
              alignment: Alignment(-0.9, 0.6),
              child:DropdownButton(
                hint: Text('Please choose a location'),
                // Not necessary for Option 1
                value: _selectedLocation,
                onChanged: (newValue) {
                  setState(() {
                    _selectedLocation = newValue;
                  });
                },
                items: _locations.map((location) {
                  return DropdownMenuItem(
                    child: new Text(location),
                    value: location,
                  );
                }).toList(),
              ),
            ),

            Align(
              alignment: Alignment(-0.9, 0.7),
              child:
              DropdownButton(
                hint: Text('Please choose a time'),
                // Not necessary for Option 1
                value: _selectedTime,
                onChanged: (newValue) {
                  setState(() {
                    _selectedTime = newValue;
                  });
                },
                items: _times.map((time) {
                  return DropdownMenuItem(
                    child: new Text(time),
                    value: time,
                  );
                }).toList(),
              ),
            ),

            new RaisedButton(
              textColor: Colors.white,
              color: Colors.blue,
              elevation: 2.0,
              padding: const EdgeInsets.all(8.0),
              child: new Text("Pay",
                  style: new TextStyle(
                      color: Colors.white, fontSize: 20.0)),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PayPage()),
              );
            },
            )
          ],
        )
      ),
    );
  }
}
