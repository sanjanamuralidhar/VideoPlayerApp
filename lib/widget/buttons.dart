import 'package:flutter/material.dart';

class CommonButton extends StatelessWidget {

  final VoidCallback onPressed;
  final String text;
  
  const CommonButton({ 
    Key? key, required this.onPressed, required this.text,
     }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(32, 32, 32, 4),
      child: Container(
        height: 50,
        width: MediaQuery.of(context).size.width * 0.8,
        // ignore: prefer_const_constructors
        decoration: BoxDecoration(
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 50 / 5,
                offset: const Offset(0, 50 / 5),
              ),
            ],
            color: Colors.deepOrangeAccent,
            borderRadius: const BorderRadius.all(Radius.circular(40))),
        child: TextButton(
            onPressed: onPressed,
  //              Navigator.push(
  //   context,
  //   MaterialPageRoute(builder: (context) => OtpScreen(phoneNumber: phonenumber!)),
  // );
          
            child: Text(
              text.toUpperCase(),style: TextStyle(color: Colors.black,fontSize: 16),
            )),
      ),
    );
  }
}