import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:messege/docid.dart';
import 'package:messege/mypage.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

class mypage extends StatefulWidget {
  const mypage({super.key});

  @override
  State<mypage> createState() => _mypageState();
}

class _mypageState extends State<mypage> {
  TextEditingController mysms=TextEditingController();





  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("AUTHOR"),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        actions: [
          IconButton(onPressed: ()async{
            await FirebaseFirestore.instance
                .collection("user")
                .doc(firebaseId)
                .set({
              'item':[]
            });


          }, icon: Icon(CupertinoIcons.delete_solid))
        ],
      ),
      body: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection("user")
              .doc(firebaseId)
              .snapshots(),
          builder: (context, snapshot) {
            if(!snapshot.hasData){
              return Center(child: CircularProgressIndicator(),);
            }
            var data=snapshot.data!.data() as Map<String,dynamic>;
            List items=data['item'] ;
            return










      Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: Container(
              color: Colors.white70,
              child:



              ListView.builder(
                itemCount: items.length, // total items
                itemBuilder: (BuildContext context, int index) {
                  var item = items[index];
                  bool isAuthor = item['name'] == 'author';

                  return Align(
                    alignment: isAuthor ? Alignment.centerRight: Alignment.centerLeft,
                    child: Container(
                      width: 250,
                        margin: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                      padding: EdgeInsets.all(16),

                      decoration: BoxDecoration(
                        color:isAuthor? Colors.deepPurple: Colors.white54,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: Colors.deepPurple,
                          width: 2,
                        ),

                      ),
                      child: Text(item['sms'],style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: isAuthor? Colors.white: Colors.deepPurple,
                      ),),
                    ),
                  );
                },
              )
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: mysms,
                        decoration: InputDecoration(
                          hint: Text("Enter you sms"),
                          label: Text("messege"),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)
                          )
                        ),
                      ),

                    ),
                    SizedBox(width: 10,),
                    ElevatedButton(onPressed: ()async{
                      setState(() async{
                      await FirebaseFirestore.instance
                          .collection("user")
                          .doc(firebaseId)
                          .update({
                        'item':FieldValue.arrayUnion([
                          {'name':'author','sms':mysms.text}])
                      });

                        mysms.clear();
                      });



                    },
                        child: Icon(Icons.send,color: Colors.white,),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.purple),
                    ),)
                  ],
                ),
              ),
            ),
          ),
        ],
      );

          })
    );
  }
}
