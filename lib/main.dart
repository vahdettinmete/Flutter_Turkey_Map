import 'package:flutter/material.dart';
import 'turkey.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Turkey Maps',
      theme: ThemeData(
  
        primarySwatch: Colors.blue,
      ),
      home: TurkeyMaps(),
    );
  }
}
