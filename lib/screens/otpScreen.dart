import 'dart:developer';

import 'package:firebase_phone_auth_handler/firebase_phone_auth_handler.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../widget/buttons.dart';
import 'homepage.dart';

class OtpScreen extends StatefulWidget {
  final String phoneNumber;
  const OtpScreen({super.key, required this.phoneNumber});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> with WidgetsBindingObserver {
  bool isKeyboardVisible = false;
  late bool verificationStatus;

  late final ScrollController scrollController;
  TextEditingController textEditingController = TextEditingController();
  @override
  void initState() {
    scrollController = ScrollController();
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    scrollController.dispose();
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    final bottomViewInsets = WidgetsBinding.instance.window.viewInsets.bottom;
    isKeyboardVisible = bottomViewInsets > 0;
  }

  @override
  Widget build(BuildContext context) {
    log(widget.phoneNumber);
    return SafeArea(
      child: FirebasePhoneAuthHandler(
        phoneNumber: widget.phoneNumber,
        signOutOnSuccessfulVerification: false,
        linkWithExistingUser: false,
        autoRetrievalTimeOutDuration: const Duration(seconds: 60),
        otpExpirationDuration: const Duration(seconds: 60),
        onCodeSent: () {
          log('OTP sent!');
        },
        onLoginSuccess: (userCredential, autoVerified) async {
          log("${autoVerified ? 'OTP was fetched automatically!' : 'OTP was fetched manually!'}");

          Fluttertoast.showToast(
            msg: 'Phone number verified successfully!',
            toastLength: Toast.LENGTH_SHORT,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 16.0,
          );

          log(
            'Login Success UID: ${userCredential.user?.uid}',
          );

          // Navigator.pushNamedAndRemoveUntil(
          //   context,
          //   HomeScreen.id,
          //   (route) => false,
          // );
        },
        // ignore: void_checks
        onLoginFailed: (authException, stackTrace) {
          log(
            "",
            name: authException.message.toString(),
            error: authException,
            stackTrace: stackTrace,
          );

          switch (authException.code) {
            case 'invalid-phone-number':
              // invalid phone number
              // return showSnackBar('Invalid phone number!');
              return Fluttertoast.showToast(
                msg: 'Invalid phone number!',
                toastLength: Toast.LENGTH_SHORT,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.black,
                textColor: Colors.white,
                fontSize: 16.0,
              );
            case 'invalid-verification-code':
              // invalid otp entered
              // return showSnackBar('The entered OTP is invalid!');
              return Fluttertoast.showToast(
                msg: 'The entered OTP is invalid!',
                toastLength: Toast.LENGTH_SHORT,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.black,
                textColor: Colors.white,
                fontSize: 16.0,
              );
            // handle other error codes
            default:
              // showSnackBar('Something went wrong!');
              return Fluttertoast.showToast(
                msg: 'Something went wrong!',
                toastLength: Toast.LENGTH_SHORT,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.black,
                textColor: Colors.white,
                fontSize: 16.0,
              );
            // handle error further if needed
          }
        },
        onError: (error, stackTrace) {
          log(
            "",
            error: error,
            stackTrace: stackTrace,
          );

          // showSnackBar('An error occurred!');
          Fluttertoast.showToast(
            msg: 'An error occurred!',
            toastLength: Toast.LENGTH_SHORT,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        },
        builder: (context, controller) {
          return Scaffold(
            body: controller.isSendingCode
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      CupertinoActivityIndicator(
                          radius: 20.0, color: CupertinoColors.activeBlue),
                      SizedBox(height: 50),
                      Center(
                        child: Text(
                          'Sending OTP',
                          style: TextStyle(fontSize: 25),
                        ),
                      ),
                    ],
                  )
                : ListView(
                  padding: const EdgeInsets.all(20),
                  controller: scrollController,
                  children: [
                    Image.asset('assets/videoPlayer (2).png'),
                    const Center(
                      child: Text(
                        'Verification',
                        style: TextStyle(
                            fontSize: 40, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const Center(
                      child: Text(
                        'Enter your otp code number',
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 80,
                    ),
                    const SizedBox(height: 15),
                    PinCodeTextField(
                      length: 6,
                      obscureText: false,
                      animationType: AnimationType.fade,
                      pinTheme: PinTheme(
                        inactiveColor: Colors.deepOrangeAccent,
                        inactiveFillColor: Colors.white,
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(5),
                        fieldHeight: 50,
                        fieldWidth: 40,
                        activeFillColor: Colors.white,
                      ),
                      animationDuration: const Duration(milliseconds: 300),
                      // backgroundColor: Colors.blue.shade50,
                      enableActiveFill: true,
                      // errorAnimationController: errorController,
                      controller: textEditingController,
                      onCompleted: (enteredOtp) async {
                        final verified =
                            await controller.verifyOtp(enteredOtp);
                            setState(() {
                            verificationStatus = verified;
                          });
                        // if (verified) {
                        //   // number verify success
                        //   // will call onLoginSuccess handler
                          
                        // } else {
                        //   // phone verification failed
                        //   // will call onLoginFailed or onError callbacks with the error
                        // }
                      },
                      onChanged: (hasFocus) async {
                        await _scrollToBottomOnKeyboardOpen();
                      },
                      beforeTextPaste: (text) {
                        print("Allowing to paste $text");
                        //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                        //but you can show anything you want here, like your pop up saying wrong paste format or etc
                        return true;
                      },
                      appContext: context,
                    ),
                    CommonButton(
                      text: "Verify",
                      onPressed: () {
                        verificationStatus?Navigator.pop(context):textEditingController.clear();
                      },
                    )
                  ],
                ),
          );
        },
      ),
    );
  }

  Future<void> _scrollToBottomOnKeyboardOpen() async {
    while (!isKeyboardVisible) {
      await Future.delayed(const Duration(milliseconds: 50));
    }

    await Future.delayed(const Duration(milliseconds: 250));

    await scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeIn,
    );
  }
}
