import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:inventory_management_system/screens/home.dart';
import 'package:inventory_management_system/screens/login.dart';
import 'package:inventory_management_system/screens/signup.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(

  // if (!kIsWeb) {
  //   WidgetsFlutterBinding.ensureInitialized();
  //   Firebase.initializeApp();
  // } else {
  //   Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyAgaYJUD6-a3KrzstJsBYQbGmXtNL1wrfM",
        appId: "1:985062138170:web:acecc4736427e8956f7003",
        messagingSenderId: "985062138170",
        projectId: "inventorymanagementsyste-75955",
      ),
    );
  // }
  runApp(MyApp());
}
DatabaseReference  users = FirebaseDatabase.instance.ref().child("users");

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      title: 'IMS',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      // home: Login(),
      initialRoute:
          FirebaseAuth.instance.currentUser == null ? '/login' : '/home',
      routes: {
        '/login': (context) => Login(),
        '/SignUp':(context)=>SignUp(),
        // ForgotPassword.id:(context)=>ForgotPassword(),
        //'/onboarding':(context)=>OnBoardingPage(),
        '/home': (context) => Home(),
        //SearchScreen.idScreen: (context) => SearchScreen(),
        //profilescreen.idScreen:(context)=>  profilescreen(),
      },
    );
  }
}
