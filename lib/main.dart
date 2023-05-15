import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_phone_auth_handler/firebase_phone_auth_handler.dart';
import 'package:flutter/material.dart';
import 'package:videoplayer/screens/RegistrationPage.dart';
import 'package:videoplayer/screens/homepage.dart';
import 'package:videoplayer/screens/loginPage.dart';
import 'package:videoplayer/screens/otpScreen.dart';
import 'package:videoplayer/screens/testvideoscreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(_MainApp());
}

class _MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FirebasePhoneAuthProvider(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
       theme: ThemeData(primarySwatch: Colors.deepOrange),
       darkTheme: ThemeData.dark(),
        home:RegistrationPage()
      ),
    );
  }
}