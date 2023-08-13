import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

var email = null;
class dashboard extends StatefulWidget {

  const dashboard({super.key});

  @override
  State<dashboard> createState() => _dashboardState();
}

class _dashboardState extends State<dashboard> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      body: Container(
        child: Card(
          elevation: 10,
          shadowColor: Colors.blue,
          child: Text('$email',
          style: TextStyle(
            fontSize: 30
          ),),
        ),
      ),
    );
  }

  void getData() async{
    var pref = await SharedPreferences.getInstance();
    setState(() {
      email = pref.getString("email");
      print(email);
    });

  }
}
