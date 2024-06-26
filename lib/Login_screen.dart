import 'package:firebase/firestore/firestore_list_screen.dart';
import 'package:firebase/phone.dart';
import 'package:firebase/posts/post_screen.dart';
import 'package:firebase/singup_screen.dart';
import 'package:firebase/upload_image.dart';
import 'package:firebase/utils/utils.dart';
import 'package:firebase/widget/round_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/ui/firebase_sorted_list.dart';
import 'package:flutter/material.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final _auth = FirebaseAuth.instance;


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }
  
  
  void login(){
    _auth.signInWithEmailAndPassword(email: emailController.text,
        password: passwordController.text).then((value){
          Utils().toastMessage(value.user!.email.toString());
          Navigator.push(context, MaterialPageRoute(builder: (context) => const UploadImage()));
    }).onError((error,stackTrace){
      Utils().toastMessage(error.toString());
    });
  }

  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        automaticallyImplyLeading: false,
        title: const Center(child: Text("Login Page",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w400),)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Form(
              key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: emailController,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.email_outlined),
                        hintText: "Email",
                      ),
                      validator: (value){
                        if(value!.isEmpty){
                          return 'Enter Your Email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      obscureText: true,
                      controller: passwordController,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.password_outlined),
                        hintText: "Password",
                      ),
                      validator: (value){
                        if(value!.isEmpty){
                          return 'Enter Your Password';
                        }
                        return null;
                      },
                    ),
                  ],
                )),
            const SizedBox(
              height: 30,
            ),
            RoundButton(
                title: 'Login',
              onTap: (){
                  if(_formKey.currentState!.validate()){
                    login();
                  }
              },
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Don't Have an Account?"),
                TextButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> const SingUp()));
                },
                    child: const Text("Sign Up"),),
              ],
            ),
            const SizedBox(height: 25),
            InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => Phone()));
              },
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                 border: Border.all(
                   color: Colors.black,
                 )
                ),
                child: Center(child: Text("Sign Up with Phone")),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
