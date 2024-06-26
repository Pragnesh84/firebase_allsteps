import 'dart:io';

import 'package:firebase/utils/utils.dart';
import 'package:firebase/widget/round_button.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;


class UploadImage extends StatefulWidget {
  const UploadImage({super.key});

  @override
  State<UploadImage> createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {

  File? _image;
  final picker = ImagePicker();
  firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage.instance;
  DatabaseReference databaseReference = FirebaseDatabase.instance.ref('Post');

  Future getImageGallery() async{
    final pickerFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if(pickerFile != null){
        _image = File(pickerFile.path);
      }
      else{
        return print("No Image Selected");
      }
    });

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Image Upload"),
        backgroundColor: Colors.indigo,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: InkWell(
                onTap: (){
                  getImageGallery();
                },
                child: Container(
                  height: 200,
                  width: 200,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black
                    ),
                  ),
                  child: _image != null ? Image.file(_image!.absolute)
                  : Center(child: Icon(Icons.image)),
                ),
              ),
            ),
            SizedBox(height: 30),
            RoundButton(title: "Upload", onTap: ()async{
              firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance.ref("/foldername"+"Pragnesh");
              firebase_storage.UploadTask uploadTask = ref.putFile(_image!.absolute);

              Future.value(uploadTask).then((value)async {
                var newUrl = await ref.getDownloadURL();

                databaseReference.child("1").set({
                  'id': '1234',
                  'title': newUrl.          toString(),
                }).then((value){
                  Utils().toastMessage("Uploaded");
                }).onError((error,stackTrace){
                  Utils().toastMessage(error.toString());
                });
              }).onError((error,stackTrace){
                Utils().toastMessage(error.toString());
              });
            })
          ],
        ),
      ),
    );
  }
}
