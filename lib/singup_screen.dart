import 'package:firebase/Login_screen.dart';
import 'package:firebase/utils/utils.dart';
import 'package:firebase/widget/round_button.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SingUp extends StatefulWidget {
  const SingUp({super.key});

  @override
  State<SingUp> createState() => _SingUpState();
}

class _SingUpState extends State<SingUp> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();


  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Center(child: Text("Sign Up",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w400),)),
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
              title: 'Sign Up',
              onTap: (){
                if(_formKey.currentState!.validate()){
                  _auth.createUserWithEmailAndPassword(
                      email: emailController.text.toString(),
                      password: passwordController.text.toString()).then((value){

                  }).onError((error, stackTrace){
                    Utils().toastMessage(error.toString());
                  });
                }
              },
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Already Have an Account?"),
                TextButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> LoginScreen()));
                },
                  child: Text("Login"),),
              ],
            )
          ],
        ),
      ),
    );
  }
}
