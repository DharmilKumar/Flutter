import 'package:flutter/material.dart';
import 'package:storage_sqflite_demo/sql_helper.dart';


void main() {
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
      home: const MyHomePage(title: 'SQFlite Demo'),

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
  List<Map<String,dynamic>> studList = [];
  var nameController = TextEditingController();
  var emailController = TextEditingController();

  showForm(int? id) async {
    if(id != null)
      {
        final existingrecord = studList.firstWhere((element) =>
        element['id'] == id);
        nameController.text = existingrecord['name'];
        emailController.text = existingrecord['email'];
      }
    showModalBottomSheet(context: context,
        elevation: 5,
        isScrollControlled: true,
        builder: (context) =>
            Container(
              padding: EdgeInsets.only(
                top: 15,
                left: 15,
                right: 15,
                bottom: MediaQuery
                    .of(context)
                    .viewInsets
                    .bottom + 120,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
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
                    controller: emailController,
                    decoration: InputDecoration(
                        labelText: 'Enter Email'
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(onPressed: () async {
                    if (id == null)
                      await addStudents();
                    if(id != null)
                      await updateStudent(id);
                    //close the bottom sheet
                    Navigator.of(context).pop();
                  }, child: Text(id == null ? 'Create New' : 'Update'))
                ],
              ),
            ));
  }

  Future<void> updateStudent(int id) async{
    final result = await SQLHelper.UpdateStudent(id,
        nameController.text.toString(),
        emailController.text.toString());
    if(result > 0)
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Student updated successfully')));
      getStudentList();
  }
  Future<void> getStudentList () async
  {
    final data = await SQLHelper.getList();
    print(data);
    setState(() {
      studList = data;

    });
  }
  initState(){
    getStudentList();
  }
  Future<void> addStudents() async{
    final id = await SQLHelper.AddStudent(nameController.text.toString(),
        emailController.text.toString());
    if(id > 0)
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Student Inserted Successfully')));
    getStudentList();
  }

  Future<void> deleteStudent(int id) async{
   SQLHelper.DeleteStudent(id);
   ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Student Deleted Successfully')));
   getStudentList();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
     floatingActionButton: FloatingActionButton(
       onPressed: ()=> showForm(null),
       child: Icon(Icons.add),
     ),
     body: ListView.builder(
         itemCount: studList.length,
         itemBuilder: (context, index) =>
       Card(
         color: Colors.orangeAccent,
         margin: EdgeInsets.all(10),
         child: ListTile(
           title: Text(studList[index]['name']),
           subtitle: Text(studList[index]['email']),
           trailing:
           Container(
             width: 100,
             child:Row(

               children: [
                 IconButton(onPressed: (){
                   showForm(studList[index]['id']);
                 }, icon: Icon(Icons.edit)),
                 IconButton(onPressed: () async{
                   await deleteStudent(studList[index]['id']);
                 }, icon: Icon(Icons.delete)),
               ],
             )
           )

         ),
       ),),


     // This trailing comma makes auto-formatting nicer for build methods.
    );
  }


}







