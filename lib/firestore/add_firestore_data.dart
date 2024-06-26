import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/posts/post_screen.dart';
import 'package:firebase/utils/utils.dart';
import 'package:firebase/widget/round_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';


class AddFirestoreData extends StatefulWidget {
  const AddFirestoreData({super.key});

  @override
  State<AddFirestoreData> createState() => _AddFirestoreDataState();
}

class _AddFirestoreDataState extends State<AddFirestoreData> {

  bool  loading = false;
  final postController = TextEditingController();
  final fireStore = FirebaseFirestore.instance.collection("users");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Firestore Data'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(height: 30),
            TextFormField(
              controller: postController,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: "Enter a Text",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 30),
            RoundButton(
                title: "Add",
                onTap: (){
                  String id = DateTime.now().millisecondsSinceEpoch.toString();

                  fireStore.doc(id).set({
                    'title': postController.text.toString(),
                    'id' : id,
                  }).then((value){
                    Utils().toastMessage('Data is Insert');
                  }).onError((error, stackTrace){
                      Utils().toastMessage(error.toString());
                  });
                }
            ),
          ],
        ),
      ),
    );
  }

}
