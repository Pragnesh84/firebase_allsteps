import 'package:firebase/phone.dart';
import 'package:firebase/posts/post_screen.dart';
import 'package:firebase/utils/utils.dart';
import 'package:firebase/widget/round_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class otp extends StatefulWidget {
  final String verificationId;
  otp({super.key, required this.verificationId});

  @override
  State<otp> createState() => _otpState();
}

class _otpState extends State<otp> {
  bool loading = false;
  TextEditingController otpController = TextEditingController();
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("OTP Verification"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              controller: otpController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                hintText: "Enter OTP",
                suffixIcon: Icon(Icons.phone),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
          ),
          SizedBox(height: 20),
          RoundButton(
              title: 'Verify Number',
              onTap: ()async{
                setState(() {
                  loading = true;
                });
                final credential = PhoneAuthProvider.credential(
                    verificationId: widget.verificationId,
                    smsCode: otpController.text.toString());
                try{
                  await auth.signInWithCredential(credential);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => PostScreen()));
                }
                catch(e){
                  loading =false;
                  Utils().toastMessage(e.toString());
                }
              }),
        ],
      ),
    );
  }
}
