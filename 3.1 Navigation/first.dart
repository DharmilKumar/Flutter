import 'package:flutter/material.dart';

class first extends StatelessWidget {
  const first({super.key});

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: Text('List Demo'),
        backgroundColor:Colors.purpleAccent
      ),

      body: Container(
        child: Center(
          child: ElevatedButton(onPressed: (){
            Navigator.pushNamed(context, '/main');
          }, child: const Text('Launch')),
        ),
      )


    );
  }
}
