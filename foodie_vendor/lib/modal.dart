import 'package:flutter/material.dart';

class Demo extends StatefulWidget {
  @override
  DemoState createState() => new DemoState();
}

class DemoState extends State<Demo> {
  Map<String, bool> values = {
    'foo': true,
    'bar': false,
  };

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text('CheckboxListTile demo')),
      body: new ListView(
        children: values.keys.map((String key) {
          return new ListTile(
            title: Text('title'),
            subtitle: Text('My new post'),
            onTap: () => alertDialog(context),
          );

        }).toList(),
      ),

    );
  }
}

void alertDialog(BuildContext context) {
  var alert = AlertDialog(
      title: Text("Dialog title"),
      content: Text("Dialog description"),
      actions: <Widget> [
        new FlatButton(
          child: new Text("Cancel"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        new FlatButton(
          child: new Text("Confirm"),
          onPressed: () {
            SnackBar(
              content: Text("Sending Message"),
            );
            Navigator.of(context).pop();
          },
        ),
      ]
  );
  showDialog(context: context, builder: (BuildContext context) => alert);
}

void main() {
  runApp(new MaterialApp(home: new Demo(), debugShowCheckedModeBanner: false));
}