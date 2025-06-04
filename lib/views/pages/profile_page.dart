import 'dart:io';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String name = '';
  String email = '';
  String phone = '';
  String dob = '';
  String? imagePath;

  @override
  void initState() {
    super.initState();
    // _loadProfileData();
  }

  // Future<void> _loadProfileData() async {
  //   final user = FirebaseAuth.instanceFor.currentUser

  //   if (user != null) {
  //     final doc =
  //         await FirebaseFirestore.instance
  //             .collection('users')
  //             .doc(user.uid)
  //             .get();
  //     final data = doc.data();

  //     if (!mounted || data == null) return;
  //     setState(() {
  //       name = data['name'] ?? 'User';
  //       email = data['email'] ?? 'user@example.com';
  //       phone = data['phone'] ?? 'Not set';
  //       dob = data['dob'] ?? 'Not set';
  //       imagePath = data['imgUrl'];
  //     });
  //   }
  // }

  Widget _buildInfoItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [Text(label), Text(value)],
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
              child: CircleAvatar(
                radius: 50.0,
                backgroundImage:
                    imagePath != null && File(imagePath!).existsSync()
                        ? FileImage(File(imagePath!))
                        : const AssetImage('assets/images/profile.png')
                            as ImageProvider,
              ),
            ),
            SizedBox(height: 16),
            Text(
              name,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  _buildInfoItem('Full Name', name),
                  Divider(),
                  _buildInfoItem('Email', email),
                  Divider(),
                  _buildInfoItem('Phone', phone),
                  Divider(),
                  _buildInfoItem('Password', '••••••••'),
                  Divider(),
                  _buildInfoItem('Date of Birth', dob),
                  Divider(),
                ],
              ),
            ),
            SizedBox(height: 10),
            // ListTile(
            //   leading: Icon(Icons.edit, color: Colors.grey),
            //   title: Text('Edit Profile'),
            //   onTap: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //         builder:
            //             (context) =>
            //                 // EditProfilePage(onProfileUpdate: _loadProfileData),
            //       ),
            //     );
            //   },
            // ), // imported from logout_tile.dart
          ],
        ),
      ),
    );
  }
}
