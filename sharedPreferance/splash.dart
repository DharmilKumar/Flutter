import 'dart:async';

import 'package:data_storage/dashboard.dart';
import 'package:data_storage/main.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

var loggedin;
class splash extends StatefulWidget {
  const splash({super.key});

  @override
  State<splash> createState() => _splashState();
}

class _splashState extends State<splash> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 2),(){
      ScreenNavigation();
    /*  Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context)=>MyHomePage()));*/
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.purpleAccent,
      ),
    );
  }

  void ScreenNavigation() async{
    var pref = await SharedPreferences.getInstance();
    loggedin = pref.getBool("isloggedin");
    if(loggedin != null)
      {
        if(loggedin)
          {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context)=>dashboard()));
          }
        else
          {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context)=>MyHomePage()));
          }
      }
    else
      {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context)=>MyHomePage()));
      }

  }
}
