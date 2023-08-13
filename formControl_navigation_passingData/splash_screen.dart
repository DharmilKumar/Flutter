
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:navigation/main.dart';

class SplashScreen extends StatefulWidget
{
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 2),(){
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder:
              (context) => MyHomePage(title: 'Home Page')));
    });
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        color: Colors.purpleAccent,
        child: Center(child: Icon(Icons.ac_unit,size:200,color:Colors.white)),
      )
    );
  }
}