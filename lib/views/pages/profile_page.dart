import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:new_app/views/pages/edit_profile_page.dart';

import '../widgets/logout_widget.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String name = '';
  String email = '';
  String phone = '';
  String? imagePath;

  @override
  void initstate() {
    super.initState();
    _loadProfileData();
  }

  Future<void> _loadProfileData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString('name') ?? 'Tee-show04';
      email = prefs.getString('email') ?? 'teeshow@example.com';
      phone = prefs.getString('phone') ?? '+234 123 456 7890';
      imagePath = prefs.getString('profileImage');
    });
  }

  Widget _buildInfoItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(value),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [
            Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 60.0,
                    backgroundImage: imagePath != null && File(imagePath!).existsSync()
                        ? FileImage(File(imagePath!))
                        : const AssetImage('assets/images/timi.jpg') as ImageProvider,
                  ),
                  Positioned(
                    bottom: -5,
                    right: -5,child: GestureDetector(

                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        color: Theme
                            .of(context)
                            .primaryColor,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                      child: Icon(
                          Icons.camera_alt, color: Colors.white, size: 20),
                    ),
                  ),
                  )
                ],
              ),
            ),
            SizedBox(height: 16),
            Text(name,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  _buildInfoItem("Full Name", name),
                  Divider(),
                  _buildInfoItem("Email", email),
                  Divider(),
                  _buildInfoItem("Phone", phone),
                  Divider(),
                  _buildInfoItem("Password", "••••••••"),
                ],
              ),
            ),
            SizedBox(height: 10),
            ListTile(
              leading: Icon(Icons.edit, color: Colors.grey),
              title: Text('Edit Profile'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        EditProfilePage(onProfileUpdate: _loadProfileData),
                  ),
                );
              },
            ),
            SizedBox(height: 10),
            LogoutTile(), // imported from logout_tile.dart
          ],
        ),
      ),
    );
  }
}
