import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'pages/homeApp.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Nusantara",
      debugShowCheckedModeBanner: false,
      home: HomeApp(),
    );
  }
}
