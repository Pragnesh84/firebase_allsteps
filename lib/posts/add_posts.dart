import 'package:firebase/posts/post_screen.dart';
import 'package:firebase/utils/utils.dart';
import 'package:firebase/widget/round_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';


class AddPostsScreen extends StatefulWidget {
  const AddPostsScreen({super.key});

  @override
  State<AddPostsScreen> createState() => _AddPostsScreenState();
}

class _AddPostsScreenState extends State<AddPostsScreen> {

  bool  loading = false;
  final DatabaseReference databaseRef = FirebaseDatabase.instance.ref('Post');
  final postController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Post'),
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
                  databaseRef.child(id).set({
                    'title': postController.text.toString(),
                    'id' : id,
                  }).then((value){
                    Utils().toastMessage("Post is added");
                    Navigator.push(context, MaterialPageRoute(builder: (context) => PostScreen()));
                  }).onError((error,stackTrace){
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
