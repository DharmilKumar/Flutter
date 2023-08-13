
import 'package:flutter/material.dart';
import 'package:navigation/main.dart';

class second extends StatefulWidget{

  var name;
  second(this.name);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return secondState();
  }

}
class secondState extends State<second>
{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Second'),
      ),
      body: Column(
        children: [
          Text('Welcome ${widget.name}'),
          ElevatedButton(onPressed: () {
            Navigator.pop(context);
          }, child: const Text('Go Back'))
        ],
      ),
    );
  }

}
/*class second extends StatelessWidget {
  var name;

  second(this.name);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
      appBar: AppBar(
        title: Text('Second'),
      ),
      body: Column(
        children: [
          Text('Welcome $name'),
          ElevatedButton(onPressed: () {
            Navigator.pop(context);
          }, child: const Text('Go Back'))
        ],
      ),
    );
  }
}*/


