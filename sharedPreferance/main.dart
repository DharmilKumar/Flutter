
import 'package:data_storage/dashboard.dart';
import 'package:data_storage/splash.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


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
      debugShowCheckedModeBanner: false,
      home: splash(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var emailController = TextEditingController();
  var pswdController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Login"),
      ),
      body: Center(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(child: Icon(Icons.account_circle), maxRadius: 50,),
            Container(
              height: 20,
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Enter Email',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10)
                ),
                suffixIcon: Icon(Icons.email)
              ),
            ),
            Container(
              height: 20,
            ),
            TextField(
              controller: pswdController,
              obscureText: true,
              decoration: InputDecoration(
                  labelText: 'Enter Password',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)
                  ),
                  suffixIcon: Icon(Icons.remove_red_eye)
              ),
            ),
            Container(
              height: 20,
            ),
            ElevatedButton(onPressed: () async{
              var Email = emailController.text.toString();
              var pswd = pswdController.text.toString();

              if(Email == 'a@gmail.com' && pswd == '1234')
                {
                  var pref = await SharedPreferences.getInstance();
                  pref.setBool("isloggedin", true);
                  pref.setString("email", Email);

                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>dashboard()));
                }
              else
                {
                  print("Invalid username or password");
                }

            }, child: const Text('Login'))
          ],
        ),
      )// This trailing comma makes auto-formatting nicer for build methods.
    );
  }


}
