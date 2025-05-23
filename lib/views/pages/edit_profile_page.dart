import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';


class EditProfilePage extends StatefulWidget {
  final Function onProfileUpdate;

  const EditProfilePage({super.key, required this.onProfileUpdate});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final dobController = TextEditingController();
  String? imagePath;
  bool _obscurePassword = true;

  // Store original login credentials
  String originalEmail = '';
  String originalPassword = '';

  @override
  void initState() {
    _loadSavedData();
    super.initState();

  }

  Future<void> _loadSavedData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      nameController.text = prefs.getString('name') ?? '';
      emailController.text = prefs.getString('email') ?? '';
      phoneController.text = prefs.getString('phone') ?? '';
      passwordController.text = prefs.getString('password') ?? '';
      dobController.text = prefs.getString('dob') ?? '';
      imagePath = prefs.getString('profileImage');

      originalEmail = prefs.getString('email') ?? '';
      originalPassword = prefs.getString('password') ?? '';
    });
  }

  Future<void> _pickImage() async {
    await Permission.photos.request();
    final ImagePicker picker = ImagePicker();
    final XFile? picked = await picker.pickImage(source: ImageSource.gallery);

    if (picked != null) {
      setState(() {
        imagePath = picked.path;
      });
    }
  }

  Future<void> _saveProfile() async {
    if (nameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter name')),
      );
      return;
    }

    String email = emailController.text.trim();
    bool isEmailValid = RegExp(
        r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$"
    ).hasMatch(email);

    if (emailController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter email')),
      );
      return;
    }

    if (!isEmailValid) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter a valid email')),
      );
      return;
    }

    if (passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter new password')),
      );
      return;
    }

    if (passwordController.text.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Password must be at least 6 characters')),
      );
      return;
    }


    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('name', nameController.text);
      await prefs.setString('email', emailController.text);
      await prefs.setString('phone', phoneController.text);
      await prefs.setString('password', passwordController.text);
      await prefs.setString('dob', dobController.text);


      if (imagePath != null) {
        await prefs.setString('profileImage', imagePath!);
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Profile updated successfully!')),
      );
      widget.onProfileUpdate(); // callback to refresh profile
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update profile. Please try again.')),
      );
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    dobController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Edit Profile')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            GestureDetector(
              onTap: () => _pickImage(),
              child: CircleAvatar(
                radius: 50,
                backgroundImage: imagePath != null
                    ? FileImage(File(imagePath!))
                    : const AssetImage('assets/images/timi.jpg') as ImageProvider,
              ),
            ),
            SizedBox(height: 20),
            TextField(controller: nameController, decoration: InputDecoration(labelText: 'Full Name')),
            TextField(controller: emailController, decoration: InputDecoration(labelText: 'Email')),
            TextField(controller: phoneController, decoration: InputDecoration(labelText: 'Phone')),
            TextField(controller: passwordController, decoration: InputDecoration(labelText: 'Password',

              suffixIcon: IconButton(
                  icon: Icon(_obscurePassword ? Icons.visibility_off : Icons.visibility),
                onPressed: () {
                  setState(() {
                    _obscurePassword = !_obscurePassword;
                  });
                },
              ),
            ),
              obscureText: _obscurePassword,
            ),
    TextField(
      controller: dobController,
        readOnly: true,
        decoration: InputDecoration(
            labelText: 'Date of Birth',
        suffixIcon: Icon(Icons.calendar_today),
        ),
    onTap: () async {
      DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate:
           DateTime(2025),
          firstDate: DateTime(1900),
          lastDate: DateTime.now(),
      );
      if (pickedDate != null) {
        setState(() {
          dobController.text = DateFormat('dd MMM yyyy').format(pickedDate);
        });
      }
    },
    ),
            SizedBox(height: 20),
            ElevatedButton(onPressed: _saveProfile, child: Text('Save')),
          ],
        ),
      ),
    );
  }
}


