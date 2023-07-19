import 'package:flutter/material.dart';
import 'turkeymapSVG.dart';


import 'dart:ui' as ui;


import 'package:flutter/rendering.dart';




class IlHaberleri extends StatefulWidget {
  const IlHaberleri() ;

  @override
  _IlHaberleriState createState() => _IlHaberleriState();
}

class _IlHaberleriState extends State<IlHaberleri> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Center(
          child: Text('il'),
        ),
      ),
    );
  }
}

class IlNews extends StatelessWidget {
  var secilenil;

  IlNews(this.secilenil,);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(secilenil),
      centerTitle: true,
      ),
      body: Container(
        child: Center(
          child: Text('il News' + secilenil),
        ),
      ),
    );
  }
}
