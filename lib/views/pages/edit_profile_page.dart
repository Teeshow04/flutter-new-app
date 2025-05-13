// import 'dart:io';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class EditProfilePage extends StatefulWidget {
//   const EditProfilePage({super.key});
//
//   @override
//   State<EditProfilePage> createState() => _State();
// }
//
// class _State extends State<EditProfilePage> {
//   File? _imageFile;
//   final picker = imagePicker  ();
//
//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController phoneController = TextEditingController();
//   final TextEditingController usernameController = TextEditingController();
//   final TextEditingController dobController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//
//
//   @override
//   void initState() {
//     super.initState();
//     _loadProfileData();
//   }
//
//   Future<void> _loadProfileData() async {
//     final prefs = await SharedPreferences.getInstance();
//     nameController.text = prefs.getString('name') ?? 'Timi Show';
//     emailController.text = prefs.getString('email') ?? 'timi@example.com';
//     usernameController.text = prefs.getString('username') ?? 'user123';
//     phoneController.text = prefs.getString('phone') ?? '+234-123-4567-890';
//     dobController.text = prefs.getString('dob') ?? '1990-01-01';
//     passwordController.text = prefs.getString('password') ?? '********';
//
//     @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Edit Profile'),
//       )
//       body: Padding(
//     padding: const EdgeInsets.all(20.0),
//         child: SingleChildScrollView(
//
//         )
//           child: Column(
//             children: [
//               TextField(
//                 controller: nameController,
//                 decoration: InputDecoration(
//                   labelText: 'Username',
//                 ),
//               ),
//               SizedBox(height: 20.0),
//               TextField(
//           controller: nameController,
//       decoration: InputDecoration(
//       labelText: 'Full Name',
//       ),
//       ),
//       SizedBox(height: 20.0),
//       TextField(
//       controller: emailController,
//       decoration: InputDecoration(
//       labelText: 'Email'
//       ),
//       keyboardType: TextInputType.emailAddress ,
//       ),
//       SizedBox(height: 20.0),
//       TextField(
//       controller: phoneController,
//       decoration: InputDecoration(labelText: 'Phone Number'),
//       keyboardType: TextInputType.datetime,
//       ),
//       SizedBox( height: 20.0,),
//       TextField(
//       controller: dobController,
//       decoration: InputDecoration(labelText: 'Date of Birth'),
//       readOnly: true,
//       onTap: () async{
//       DateTime? pickedDate =await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime(1900),
//       lastDate: DateTime(2100)
//       );
//       if (pickedDate != null) {
//       setState(() {
//       dobController.text = pickedDate.toLocal().toString().split(' ')[0];
//       });
//       }
//       },
//       ),
//       SizedBox(height: 20.0,),
//       // ElevatedButton(
//       //     onPressed: _saveChanges,
//       //     child: Text('Save')
//       // ),
//       //
//       );
//             ],
//           ),
//         ),
//       ),
//
//   }
// }
//
//   static imagePicker() {}
//
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     throw UnimplementedError();
//   }
