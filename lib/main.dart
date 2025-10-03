import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: myapp(),
    );
  }
}
class myapp extends StatefulWidget {
  const myapp({super.key});

  @override
  State<myapp> createState() => _myappState();
}

class _myappState extends State<myapp> {
  TextEditingController name = TextEditingController();
  TextEditingController age = TextEditingController();
  String a="";
  String b="";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("FIRESTORE DETABASE"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            TextField(
              controller: name,
              decoration: InputDecoration(
                hintText: "Name",
              ),
            ),
            TextField(
              controller: age,
              decoration: InputDecoration(
                hintText: "Age",
              ),
            ),
            Row(
              children: [
                ElevatedButton(onPressed: ()async{
      await FirebaseFirestore.instance
          .collection('user')
          .doc('rJdMK36qiDq8Om4bUx7T') // custom ID
          .set({
      'items': [
      {'name': 'Item A', 'price': 10},
      {'name': 'Item B', 'price': 20},
      ],
      });

                }, child: Text('INSERT')),

            ElevatedButton(onPressed: ()async{
              setState(() async{


                await FirebaseFirestore.instance
                    .collection('user')
                    .doc('rJdMK36qiDq8Om4bUx7T')
                    .update({
                  'items': FieldValue.arrayUnion([
                    {'name': 'Item C', 'price': 40}
                  ])
                });


              });



            }, child: Text('READ')),
              ],
            ),
            SizedBox.square(
              dimension: 20,
            ),
            Container(
              height: 200,
              width: 300,
              color: Colors.white,
              child: Text("Name:$a\nAge:$b",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
            )
          ],
        ),
      ),
    );
  }
}


