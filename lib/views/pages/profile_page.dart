import 'package:flutter/material.dart';
import 'package:new_app/data/notifiers.dart';
import 'package:new_app/views/pages/edit_profile_page.dart';
// import 'dart:io';
import 'package:new_app/views/pages/welcome_page.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('My Profile',
      textAlign: TextAlign.center,
      )),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [
            GestureDetector(
              // onTap: ,
              child: CircleAvatar(
                radius: 50.0,
                backgroundImage: AssetImage('assets/images/timi.jpg'),
              ),
            ),
            SizedBox(height: 16.0),
            Text("Timileyin Sonibare", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 24.0),

            TextField(

            ),
            ListTile(
              title: Text('Edit Profile'),
              onTap: () {
                // selectedPageNotifier.value = 0;
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) {
                //       return EditProfilePage();
                //     },
                //   ),
                // );
              },
            ),

            ListTile(
              title: Text('Logout'),
              onTap: () {
                selectedPageNotifier.value = 0;
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return WelcomePage();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}