import 'package:flutter/material.dart';
import 'package:navigation/dashboard.dart';

class first extends StatelessWidget {
  const first({super.key});

  @override
  Widget build(BuildContext context) {
    var arrName = ['hfasj','shdgasj','rterdf','ghsvcg','sgdsh'];
    var phoneController = TextEditingController();
    var pswdController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text('List Demo'),
     //   backgroundColor:Colors.purpleAccent
      ),

      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: Colors.green,
              maxRadius: 60,
              child: Icon(Icons.add_shopping_cart,
              size:50),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: phoneController,
              keyboardType: TextInputType.phone,
              maxLength: 10,
            //  maxLines: 4,
              decoration: InputDecoration(
                labelText: 'Enter UserName',
                hintText: 'UserName',
                //enabled: false,

                prefixIcon: Icon(Icons.phone),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: Colors.deepOrange,
                    width: 2
                  )
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: Colors.purpleAccent,
                    width: 2
                  )
                ),
                disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                        color: Colors.green,
                        width: 2
                    )
                ),
              ),
            ),
            Container(
              height: 20,
            ),
            TextField(
              controller: pswdController,
              obscureText: true,
              obscuringCharacter: '*',
              decoration: InputDecoration(
                  labelText: 'Enter Password',
                  hintText: 'Password',
                  prefixIcon: Icon(Icons.remove_red_eye),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                          color: Colors.deepOrange,
                          width: 2
                      )
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                          color: Colors.purpleAccent,
                          width: 2
                      )
                  )
              ),
            ),
            ElevatedButton(onPressed: (){
              String phone = phoneController.text.toString();
              String pswd = pswdController.text.toString();

              if(phone == "1234567890" && pswd == "1234")
                {
                  Navigator.push(context, MaterialPageRoute(builder:
                  (context)=> dashboard(phoneno: phone)));
                }
              else
                {
                  print("Wrong username and password");
                }
            }, child: const Text('Login'))
          ],
        ),
      )
      /*body: Container(
        child: Center(
          child: ElevatedButton(onPressed: (){
            Navigator.pushNamed(context, '/main');
          }, child: const Text('Launch')),
        ),
      )*/


     /* body: ListView(
       // scrollDirection: Axis.horizontal,
        reverse: true,
        children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('One',style: TextStyle(
            fontSize: 21
          ),),
        ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Two',style: TextStyle(
                fontSize: 21
            ),),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Three',style: TextStyle(
                fontSize: 21
            ),),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Four',style: TextStyle(
                fontSize: 21
            ),),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Five',style: TextStyle(
                fontSize: 21
            ),),
          ),
        ],
        itemExtent: 50,
      )*/

    /*  body: ListView.builder(itemBuilder:
      (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('${index + 1}',style: TextStyle(fontSize: 21),),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(arrName[index],style: TextStyle(fontSize: 21),),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('contact no',style: TextStyle(fontSize: 21),),
              ),
            ],
          ),
        );
      },
      itemCount: arrName.length,
      itemExtent: 70,
     // scrollDirection: Axis.horizontal,
     // reverse: true,
    ),
*/
     /* body: ListView.separated(itemBuilder:
          (context, index) {
            //return Text(arrName[index]);
            return ListTile(
              leading: Text('${index+1}'),
              title: Text(arrName[index]),
              subtitle: Text('63453264'),
              trailing: Icon(Icons.add_box),
            );
          }, separatorBuilder: (context, index) {
            return Divider(height: 10,thickness: 2,);
          }, itemCount: arrName.length,

      )*/
    );
  }
}
