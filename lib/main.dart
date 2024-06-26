import 'package:firebase/Splash_screen.dart';
import 'package:firebase/phone.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: 'AIzaSyD6CSGfTLYfdmtWf-RbXilmdwArEf3u6Co',
        appId: '1:129268242627:web:b793fa87b527ce6a496a76',
        messagingSenderId: '129268242627',
        projectId: 'fir-95d8f',
        authDomain: 'fir-95d8f.firebaseapp.com',
        storageBucket: 'fir-95d8f.appspot.com',
        measurementId: 'G-27NLD2RF8B',
        databaseURL: 'https://fir-95d8f-default-rtdb.firebaseio.com',

      ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
