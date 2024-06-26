import 'package:firebase/Login_screen.dart';
import 'package:firebase/posts/add_posts.dart';
import 'package:firebase/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {

  final auth = FirebaseAuth.instance;
  final ref = FirebaseDatabase.instance.ref('Post');
  final searchFilter = TextEditingController();
  final editController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text("Post Screen"),
        actions: [
          IconButton(onPressed: (){
            auth.signOut().then((value){
              Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
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
            TextFormField(
              controller: searchFilter,
              decoration: InputDecoration(
                hintText: 'Search',
                border: OutlineInputBorder(),
              ),
              onChanged: (String value){
                setState(() {

                });
              },
            ),
            Expanded(
              child: FirebaseAnimatedList(
                  query: ref,
                  itemBuilder: (context, snapshot, animation, index){

                    final title = snapshot.child('title').value.toString();

                    if(searchFilter.text.isEmpty){
                      return ListTile(
                        title: Text(snapshot.child('title').value.toString()),
                        subtitle: Text(snapshot.child('id').value.toString()),
                        trailing: PopupMenuButton(
                          icon: Icon(Icons.more_vert),
                          itemBuilder: (context) => [
                            PopupMenuItem(
                              value: 1,
                                child: ListTile(
                                  onTap: (){
                                    Navigator.pop(context);
                                    showMyDialog(title,snapshot.child('id').value.toString());
                                  },
                                  leading: Icon(Icons.edit),
                                  title: Text("Edit"),
                                )),
                            PopupMenuItem(
                                value: 1,
                                child: ListTile(
                                  onTap: (){
                                    Navigator.pop(context);
                                    ref.child(snapshot.child('id').value.toString()).remove();
                                  },
                                  leading: Icon(Icons.delete),
                                  title: Text("Delete"),
                                )),
                          ],
                        ),
                      );
                    }
                    else if(title.toLowerCase().contains(searchFilter.text.toLowerCase().toString())){
                      return ListTile(
                          title: Text(snapshot.child('title').value.toString()),
                         subtitle: Text(snapshot.child('id').value.toString()),
                      );
                    }
                    else{
                      return Container();
                    }
                  }),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => AddPostsScreen()));
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
                Navigator.pop(context);
                ref.child(id).update({
                  'title' : editController.text.toString(),
                }).then((value){
                  Utils().toastMessage('Value Updated');
                }).onError((error, stackTrace){
                  Utils().toastMessage(error.toString());
                });
              },
                  child: Text("Update"))
            ],
          );
        }
    );
  }
}
