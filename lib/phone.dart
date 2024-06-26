import 'package:firebase/otp.dart';
import 'package:firebase/utils/utils.dart';
import 'package:firebase/widget/round_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Phone extends StatefulWidget {
  const Phone({super.key});

  @override
  State<Phone> createState() => _PhoneState();
}

class _PhoneState extends State<Phone> {

  bool loading = false;
  TextEditingController  phoneController = TextEditingController();
  final auth = FirebaseAuth.instance;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Phone Auth"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: phoneController,
              decoration: InputDecoration(
                hintText: "Enter Phone Number",
                suffixIcon: Icon(Icons.phone),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                )
              ),
            ),
            SizedBox(
              height: 20,
            ),
            RoundButton(
                title: 'Verify Number',
                onTap: (){
                  setState(() {
                    loading = true;
                  });
                  auth.verifyPhoneNumber(
                    phoneNumber: phoneController.text,
                  verificationCompleted: (_){},
                      verificationFailed: (e){
                      Utils().toastMessage(e.toString());
                      },
                      codeSent: (String verificationId , int? token){
                      setState(() {
                        loading = false;
                      });
                      Navigator.push(context, MaterialPageRoute(builder: (context) => otp(verificationId: verificationId)));
                      },
                      codeAutoRetrievalTimeout: (e){
                        Utils().toastMessage(e.toString());
                        setState(() {
                          loading = false;
                        });
                      });
                }),
          ],
        ),
      ),
    );
  }
}
