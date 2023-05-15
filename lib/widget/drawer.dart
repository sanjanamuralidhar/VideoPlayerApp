import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

class DrawerButton extends StatefulWidget {
  
  const DrawerButton({ 
    Key? key
     }) : super(key: key);

  @override
  State<DrawerButton> createState() => _DrawerButtonState();
}

class _DrawerButtonState extends State<DrawerButton> {
final storage = new FlutterSecureStorage();
 String? userName;
 String? emailId;
 String? phoneNumber;


Future<void> getUserDetails() async{
 userName = await storage.read(key: "userName");
    emailId=          await storage.read(key: "emailId");
     phoneNumber=         await storage.read(key: "phoneNumber");
}

  @override
  Widget build(BuildContext context) {
    return  Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              child: Image.asset('assets/videoPlayer (2).png'),
            ),
            ListTile(
              title: const Text("Logout",style: TextStyle(fontSize: 16),),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              title: const Text('Profile',style: TextStyle(fontSize: 16)),
              subtitle: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text('i  '),
                        Text(userName.toString()),
                      ],
                    ),
                   
                    Row(
                      children: [
                        Text('ii  '),
                        Text(emailId.toString()),
                      ],
                    ),
                    Row(
                      children: [
                        Text('iii  '),
                        Text(phoneNumber.toString()),
                      ],
                    ),
                  ],
                ),
              ),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              title: const Text('Settings',style: TextStyle(fontSize: 16)),
              subtitle: Row(
                children: [Text("1  "), Text("Change Theme")],
              ),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
           IconButton(
              icon: const Icon(Icons.lightbulb),
              onPressed: () {
                Get.isDarkMode
                    ? Get.changeTheme(ThemeData.light())
                    : Get.changeTheme(ThemeData.dark());
              })
          ],
        ),
      );
  }
}