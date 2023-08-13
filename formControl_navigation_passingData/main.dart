import 'dart:async';

import 'package:flutter/material.dart';
import 'package:navigation/first.dart';
import 'package:navigation/second.dart';
import 'package:navigation/splash_screen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      initialRoute: '/',
      routes: {
        '/' : (context) => first(),
        '/main' : (context) => MyHomePage(title: 'Home Page'),
        '/second' : (context) => second()
      },
      theme: ThemeData(
        primarySwatch: Colors.cyan,
       // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
       // useMaterial3: true,
      ),
    //  home: SplashScreen()//const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  var nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        title: Text(widget.title),
      ),
      body: Column(
        children: [
          TextField(controller: nameController,
          decoration: InputDecoration(
            labelText: 'Enter name'
          ),),
          ElevatedButton(onPressed: (){
            Navigator.pushNamed(context, '/second',
            arguments: nameController.text.toString());
           /* Navigator.push(context,
                MaterialPageRoute(
                builder: (context) =>
                    second(nameController.text.toString())));*/
          }, child: const Text('Next'))
        ],
      )

    );
  }
}
