import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/Login_screen.dart';
import 'package:firebase/firestore/add_firestore_data.dart';
import 'package:flutter/material.dart';
import 'package:firebase/posts/add_posts.dart';
import 'package:firebase/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

class FirestoreListScreen extends StatefulWidget {
  const FirestoreListScreen({super.key});

  @override
  State<FirestoreListScreen> createState() => _FirestoreListScreenState();
}

class _FirestoreListScreenState extends State<FirestoreListScreen> {
  final auth = FirebaseAuth.instance;
  final editController = TextEditingController();
  final fireStore = FirebaseFirestore.instance.collection("users").snapshots();
  CollectionReference ref = FirebaseFirestore.instance.collection("users");



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text("Firestore Screen"),
        actions: [
          IconButton(onPressed: (){
            auth.signOut().then((value){
              Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
            }).onError((error, stackTrack){
              Utils().toastMessage(error.toString());
            });
          }, icon: Icon(Icons.logout)),
          SizedBox(width: 10,)
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(height: 30),
            StreamBuilder<QuerySnapshot>(
                stream: fireStore,
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){

                  if(snapshot.connectionState == ConnectionState.waiting){
                    return CircularProgressIndicator();
                  }

                  if(snapshot.hasError){
                    return Text("Some error");
                  }
                  return  Expanded(
                      child: ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context ,index){
                            return ListTile(
                              onTap: (){
                               // ref.doc(snapshot.data!.docs[index]['id'].toString()).update({
                                //  'title': "We Are done"
                               // }).then((value){
                                //  Utils().toastMessage("data Update");
                              //  }).onError((error, stackTrace){
                                 // Utils().toastMessage(error.toString());
                               // });
                                ref.doc(snapshot.data!.docs[index]['id'].toString()).delete();
                              },
                              title: Text(snapshot.data!.docs[index]['title'].toString()),
                              subtitle: Text(snapshot.data!.docs[index]['id'].toString()),
                            );
                          })
                  );
                }),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => AddFirestoreData()));
        },
        child: Icon(Icons.add),

      ),
    );
  }
  Future<void> showMyDialog(String title, String id)async{
    editController.text = title;
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Update"),
            content: Container(
              child: TextField(
                controller: editController,
                decoration: InputDecoration(
                    hintText: "Edit"
                ),
              ),
            ),
            actions: [
              TextButton(onPressed: (){
                Navigator.pop(context);
              },
                  child: Text("Cancel")),
              TextButton(onPressed: (){

              },
                  child: Text("Update"))
            ],
          );
        }
    );
  }
}
