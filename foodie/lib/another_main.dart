// import 'package:flutter/material.dart';
//
// void main() => runApp(MaterialApp(
//   home: Home(),
// ));
// class Home extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: Container(
//           color: Colors.black,
//           child: Column(
//             children: <Widget>[
//               // Positioned and Non-positioned Widget...
//               Container(
//                   child: Stack(
//                     alignment: Alignment.topCenter,
//                     children: <Widget>[
//                       Positioned(
//                         top: 100,
//                         left: 100,
//                         child: Container(
//                           height: 300,
//                           width: 300,
//                           child: Center(child: Text('Positioned')),
//                           color: Colors.amber,
//                         ),
//                       ),
//                       Align(
//                         alignment: Alignment.topRight,
//                         child: Container(
//                           height: 200,
//                           width: 200,
//                           child: Center(child: Text('Aligned')),
//                           color: Colors.brown,
//                         ),
//                       ),
//                                                         Container(
//                         height: 100,
//                         width: 100,
//                         child: Center(child: Text('Non-Positioned')),
//                         color: Colors.cyan,
//                       ),
//                     ],
//                   )
//               ),
//
//               //textDirection => right to left...
//
//               Container(
//                 color: Colors.pinkAccent,
//                 constraints: BoxConstraints.expand(height: 60),
//                 child: Stack(
//                   textDirection: TextDirection.rtl,
//                   children: <Widget>[
//                     Text(
//                       "Flutter from right to left",
//                       style: TextStyle(color: Colors.white, fontSize: 18),
//                     )
//                   ],
//                 ),
//               ),
//
//               //textDirection => left to right...
//
//               Container(
//                 margin: EdgeInsets.only(top: 15),
//                 color: Colors.blueAccent,
//                 constraints: BoxConstraints.expand(height: 60),
//                 child: Stack(
//                   textDirection: TextDirection.ltr,
//                   children: <Widget>[
//                     Text(
//                       "Flutter from left to right",
//                       style: TextStyle(color: Colors.white, fontSize: 18),
//                     )
//                   ],
//                 ),
//               ),
//
//               // StackFit.loose
//
//               Container(
//                 margin: EdgeInsets.only(top: 15),
//                 constraints: BoxConstraints.expand(height: 60),
//                 color: Colors.deepOrangeAccent,
//                 child: Stack(
//                   fit: StackFit.loose,
//                   children: <Widget>[
//                     Container(
//                       color: Colors.brown,
//                       child: Text(
//                         "Loose StackFit",
//                         style: TextStyle(color: Colors.white, fontSize: 18),
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//
//               // StackFit.expand
//
//               Container(
//                 margin: EdgeInsets.only(top: 15),
//                 constraints: BoxConstraints.expand(height: 60),
//                 color: Colors.black,
//                 child: Stack(
//                   fit: StackFit.expand,
//                   children: <Widget>[
//                     Container(
//                       color: Colors.purpleAccent,
//                       child: Text(
//                         "Expanded StackFit",
//                         style: TextStyle(color: Colors.white, fontSize: 18),
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//
//               // StackFit.passthrough
//
//               Container(
//                 margin: EdgeInsets.only(top: 15),
//                 constraints: BoxConstraints.expand(height: 60),
//                 color: Colors.yellow,
//                 child: Stack(
//                   fit: StackFit.passthrough,
//                   children: <Widget>[
//                     Container(
//                       color: Colors.blueGrey,
//                       child: Text(
//                         "Passthrough StackFit",
//                         style: TextStyle(color: Colors.white, fontSize: 18),
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//
//               // Overflow.visible
//
//               Container(
//                 margin: EdgeInsets.only(top: 10),
//                 color: Colors.deepPurpleAccent,
//                 constraints: BoxConstraints.expand(height: 50),
//                 child: Stack(
//                   overflow: Overflow.visible,
//                   children: <Widget>[
//                     Positioned(
//                       top: 15,
//                       child: Text(
//                         "Overflow.visible Overflow.visible Overflow.visible Overflow.visible Overflow.visible Overflow.visibleOverflow.visible.\n898989898908908908098908098",
//                         style: TextStyle(color: Colors.white, fontSize: 18),
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//
//               // Overflow.clip
//
//               Container(
//                 margin: EdgeInsets.only(top: 15),
//                 color: Colors.green,
//                 constraints: BoxConstraints.expand(height: 46),
//                 child: Stack(
//                   overflow: Overflow.clip,
//                   children: <Widget>[
//                     Positioned(
//                       top: 15,
//                       child: Text(
//                         "Overflow.clip Overflow.clip Overflow.clip Overflow.clip Overflow.clip Overflow.clip \n9999999999999999999999999",
//                         style: TextStyle(color: Colors.white, fontSize: 18),
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//
//             ],
//           ),
//         )
//     );
//   }
// }