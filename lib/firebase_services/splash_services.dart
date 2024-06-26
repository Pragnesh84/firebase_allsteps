import 'dart:async';
import 'dart:js_interop';
import 'package:firebase/Login_screen.dart';
import 'package:firebase/firestore/firestore_list_screen.dart';
import 'package:firebase/posts/post_screen.dart';
import 'package:firebase/upload_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class SplashServices {
  void isLogin(BuildContext context) {
    final auth = FirebaseAuth.instance;

    final user = auth.currentUser;

    if(user != null){
      Timer(
          const Duration(seconds: 3),
              () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => const UploadImage())));
    }
    else
      {
        Timer(
            const Duration(seconds: 3),
                () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => const LoginScreen())));
      }
  }
}
