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
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final dobController = TextEditingController();

  String? imagePath;
  bool _obscurePassword = true;

  // Store original login credentials
  // String originalEmail = '';
  // String originalPassword = '';

  @override
  void initState() {
    _loadSavedData();
    super.initState();
  }

  Future<void> _loadSavedData() async {
    setState(() {});

    try {
      final prefs = await SharedPreferences.getInstance();
      setState(() {
        nameController.text = prefs.getString('name') ?? '';
        emailController.text = prefs.getString('email') ?? '';
        phoneController.text = prefs.getString('phone') ?? '';
        passwordController.text = prefs.getString('password') ?? '';
        dobController.text = prefs.getString('dob') ?? '';
        imagePath = prefs.getString('profileImage');
      });
    } catch (e) {
      setState(() {});

      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error loading profile data')));
      }
    }
  }

  Future<void> _pickImage() async {
    try {
      await Permission.photos.request();

      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
            child: Wrap(
              children: [
                ListTile(
                  leading: Icon(Icons.photo_album),
                  title: Text('Choose from Gallery'),
                  onTap: () async {
                    Navigator.pop(context);
                    await _getImage(ImageSource.gallery);
                  },
                ),

                ListTile(
                  leading: Icon(Icons.camera_alt),
                  title: Text('Take a Photo'),
                  onTap: () async {
                    Navigator.pop(context);
                    await _getImage(ImageSource.gallery);
                  },
                ),

                if (imagePath != null)
                  ListTile(
                    leading: Icon(Icons.delete, color: Colors.red),
                    title: Text(
                      'Remove Photo',
                      style: TextStyle(color: Colors.red),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      setState(() {
                        imagePath = null;
                      });
                    },
                  ),
              ],
            ),
          );
        },
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text('Error accessing camera/gallery'),
        ),
      );
    }
  }

  Future<void> _getImage(ImageSource source) async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? picked = await picker.pickImage(source: ImageSource.gallery);

      if (picked != null) {
        setState(() {
          imagePath = picked.path;
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error picking image')));
    }
  }

  Future<void> _saveProfile() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {});

    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('name', nameController.text.trim());
      await prefs.setString('email', emailController.text.trim());
      await prefs.setString('phone', phoneController.text.trim());
      await prefs.setString('password', passwordController.text);
      await prefs.setString('dob', dobController.text);

      if (imagePath != null) {
        await prefs.setString('profileImage', imagePath!);
      } else {
        await prefs.remove('profileImage');
      }

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(Icons.check_circle, color: Colors.white70),
              Text('Profile updated successfully!'),
            ],
          ),
          backgroundColor: Colors.green,
        ),
      );
      widget.onProfileUpdate(); // callback to refresh profile
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to update profile. Please try again.'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() {});
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
            Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage:
                        imagePath != null
                            ? FileImage(File(imagePath!))
                            : const AssetImage('assets/images/profile.png')
                                as ImageProvider,
                  ),

                  Positioned(
                    bottom: -5,
                    right: -5,
                    child: GestureDetector(
                      onTap: () => _pickImage(),
                      child: Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                        child: Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 20),
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Full Name'),
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: phoneController,
              decoration: InputDecoration(labelText: 'Phone'),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(
                labelText: 'Password',

                suffixIcon: IconButton(
                  icon: Icon(
                    _obscurePassword ? Icons.visibility_off : Icons.visibility,
                  ),
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
                  initialDate: DateTime(2025),
                  firstDate: DateTime(1900),
                  lastDate: DateTime.now(),
                );
                if (pickedDate != null) {
                  setState(() {
                    dobController.text = DateFormat(
                      'dd MMM yyyy',
                    ).format(pickedDate);
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
