import 'package:flutter/material.dart';

import '../widget_tree.dart';

class LoginWidget extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final String savedEmail;
  final String savedPassword;

  const LoginWidget({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.savedEmail,
    required this.savedPassword,
  });

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: () => onLoginPressed(context),
      style: ElevatedButton.styleFrom(
        minimumSize: Size(double.infinity, 40.0),
      ),
      child: Text('Login'),
    );
  }


  void onLoginPressed(BuildContext context) {

   if (emailController.text.isEmpty) {
     ScaffoldMessenger.of(context).showSnackBar(
       SnackBar(content: Text('Please enter email')),
     );
     return;
   }

   if (passwordController.text.isEmpty) {
     ScaffoldMessenger.of(context).showSnackBar(
       SnackBar(content: Text('Please enter password')),
     );
     return;
   }

   if (emailController.text.isEmpty || passwordController.text.isEmpty) {
     ScaffoldMessenger.of(context).showSnackBar(
       SnackBar(content: Text('Please enter both email and password')),
     );
     return;
   }


   if (savedEmail == emailController.text &&
       savedPassword == passwordController.text) {
     ('Login Success');
     Navigator.pushAndRemoveUntil(
       context,
       MaterialPageRoute(
         builder: (context) {
           return WidgetTree();
         },
       ),
           (route) => false,
     );
   } else {
     ScaffoldMessenger.of(context).showSnackBar(
       SnackBar(content: Text('Invalid credentials')),
     );
   }
 }
 }