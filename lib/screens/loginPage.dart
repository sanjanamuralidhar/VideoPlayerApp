

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:videoplayer/screens/homepage.dart';
import 'package:videoplayer/screens/otpScreen.dart';
import 'package:videoplayer/screens/testvideoscreen.dart';

import '../widget/buttons.dart';

class LoginPageScreen extends StatefulWidget {
  const LoginPageScreen({super.key});

  @override
  State<LoginPageScreen> createState() => _LoginPageScreenState();
}

class _LoginPageScreenState extends State<LoginPageScreen> {
  TextEditingController phonecontroller = TextEditingController();
  String? phonenumber;
  bool _showPassword = false;
  TextEditingController passwordController = TextEditingController();
  final storage = new FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 100,),
          Image.asset('assets/videoPlayer (2).png'),
          const Text('Login',style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold),),
          Padding(
            padding: const EdgeInsets.only(top: 30.0, left: 20, right: 20),
            child: IntlPhoneField(
              controller: phonecontroller,
              decoration: const InputDecoration(
                labelText: 'Phone Number',
                border: OutlineInputBorder(
                  borderSide: BorderSide(),
                ),
              ),
              disableLengthCheck: true,
              initialCountryCode: 'IN',
              onChanged: (phone) {
                print(phone.completeNumber);
                print(phone.completeNumber.length);
                setState(() {
                  phonenumber = phone.completeNumber;
                });
              },
            ),
          ),
          _buildPassword(),
         CommonButton(
          text: "login",
          onPressed: () async {
            String? phoneNumber = await storage.read(key: "phoneNumber");
            String? password = await storage.read(key: "password");
            if(phoneNumber == phonenumber && password == passwordController.text){
 Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => VideoApp()),
  );
            } else {
              Fluttertoast.showToast(
            msg: 'Invalied details',
            toastLength: Toast.LENGTH_SHORT,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 16.0,
          );
            }
          
         },)
              ],
            ),
        ));
  }

    Widget _buildPassword() {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15, top: 10),
      child: TextField(
        scrollPadding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        enableInteractiveSelection: false,
        obscureText: !_showPassword,
        controller: passwordController,
        decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.always,
          labelText: "Password",
          hintText: "***********",
          hintStyle: TextStyle(color: Colors.grey),
          counterText: "",
          border: OutlineInputBorder(),
          suffixIcon: GestureDetector(
            onTap: () {
              _togglevisibility();
            },
            child: Icon(
              _showPassword ? Icons.visibility : Icons.visibility_off,
              color: Colors.grey,
            ),
          ),
        )
      ),
    );
  }

  void _togglevisibility() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }
}
