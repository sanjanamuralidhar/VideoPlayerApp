import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:videoplayer/screens/loginPage.dart';
import 'package:videoplayer/screens/otpScreen.dart';

import '../widget/buttons.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  TextEditingController phonecontroller = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String? phonenumber;
  bool _showPassword = false;
  final storage = new FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 60,
          ),
          Image.asset('assets/videoPlayer (2).png'),
          const Text(
            'Registration',
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
          ),
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
                if (phone.number.length == 10) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            OtpScreen(phoneNumber: phone.completeNumber)),
                  );
                }
                setState(() {
                  phonenumber = phone.completeNumber;
                });
              },
            ),
          ),
          _textField("user", "User Name", nameController,TextInputType.name),
          _textField("user@example.com", "Email ID", emailController,TextInputType.emailAddress),
          _buildPassword(),
          CommonButton(
            text: "Register",
            onPressed: () async {
              await storage.write(key: "userName", value: nameController.text);
              await storage.write(key: "emailId", value: emailController.text);
              await storage.write(key: "phoneNumber", value: phonenumber);
              await storage.write(key: "password", value: passwordController.text);
              // ignore: use_build_context_synchronously
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const LoginPageScreen()),
              );
            },
          )
        ],
      ),
    ));
  }

  Widget _textField(
      String hintText, String labelText, TextEditingController controller,TextInputType keyboardType) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20, top: 15),
      child: TextFormField(
        scrollPadding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        keyboardType: TextInputType.name,
        maxLength: 25,
        controller: controller,
        decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.always,
          labelText: labelText,
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey),
          counterText: "",
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

    Widget _buildPassword() {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20, top: 15),
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
