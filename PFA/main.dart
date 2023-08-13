import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quickalert/quickalert.dart';

void main() async{
  //initialize firebase database in app
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
 //refer the collection or table in the firebase database
  final CollectionReference _tblProduct =
  FirebaseFirestore.instance.collection('tblproduct');

  final nameController = TextEditingController();
  final priceController = TextEditingController();
  Future<void> _Delete(String productId) async{
    await _tblProduct.doc(productId).delete();
  }
  void _showForm(DocumentSnapshot? documentSnapshot) async
  {
    if(documentSnapshot != null)
      {

        nameController.text = documentSnapshot['name'];
        priceController.text = documentSnapshot['price'].toString();
      }

    await showModalBottomSheet(context: context,
        isScrollControlled: true,
        elevation: 5,
        builder: (context) => Container(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top:20,
            bottom: MediaQuery.of(context).viewInsets.bottom + 20
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                    labelText: 'Enter Name'
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: priceController,
                decoration: InputDecoration(
                  labelText: 'Enter Price'
                ),
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(onPressed: (){
                if(documentSnapshot == null)
                  _Add();
                else
                  _Update(documentSnapshot);
                nameController.clear();
                priceController.clear();
                Navigator.of(context).pop();
              },
                  child: Text(documentSnapshot == null ?
                  'Create New':'Update')

              )
            ],
          ),
        ),);
  }
  Future<void> _Add() async{
    String name = nameController.text;
    final double? price = double.tryParse(priceController.text.toString());

    await _tblProduct.add({"name":name,"price":price});
    QuickAlert.show(context: context, type: QuickAlertType.success,);
    //await _tblProduct.doc(documentSnapshot.id).
    //update({"name":name,"price":price});
  }

  Future<void> _Update(DocumentSnapshot documentSnapshot) async
  {
    String name = nameController.text;
    final double? price = double.tryParse(priceController.text.toString());
    await _tblProduct.doc(documentSnapshot.id).update({"name":name,"price":price});
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
          _showForm(null);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: StreamBuilder(
        stream: _tblProduct.snapshots(), //contains data
        builder: (context,
            AsyncSnapshot<QuerySnapshot> streamsnapshot) {
          if(streamsnapshot.hasData)
            {
              return ListView.builder(
                  itemCount: streamsnapshot.data!.docs.length, //docs refers to the rows
                  itemBuilder: (context, index) {
                    final DocumentSnapshot documentSnapshot =
                    streamsnapshot.data!.docs[index];

                    return Card(
                      margin: EdgeInsets.all(10),
                      child:
                        ListTile(
                          title: Text(documentSnapshot['name']),
                          subtitle: Text(documentSnapshot['price'].toString()),
                          trailing: SizedBox(
                            width: 100,
                            child: Row(
                              children: [
                                IconButton(onPressed: (){
                                  _showForm(documentSnapshot);
                                }, icon: Icon(Icons.edit)),
                                IconButton(onPressed: (){
                                  QuickAlert.show(context: context,
                                      type: QuickAlertType.confirm,
                                    onConfirmBtnTap: (){
                                      _Delete(documentSnapshot.id);
                                      Navigator.of(context).pop();
                                    },
                                    confirmBtnText: 'Yes',
                                    onCancelBtnTap: (){
                                    Navigator.of(context).pop();
                                    },
                                    title: 'Are you sure you want to Delete?'
                                  );

                                }, icon: Icon(Icons.delete))
                              ],
                            ),
                          ),
                        )

                    );
                  },);
            }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      )


    );
  }
}
