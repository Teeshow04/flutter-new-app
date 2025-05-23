import 'package:flutter/material.dart';
import 'package:new_app/views/pages/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterWidget extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final String savedName;
  final String savedEmail;
  final String savedPassword;

  const RegisterWidget({
    super.key,
    required this.nameController,
    required this.emailController,
    required this.passwordController,
    required this.savedName,
    required this.savedEmail,
    required this.savedPassword,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15.0),
       child:  FilledButton(
          onPressed: () => onRegisterPressed(context),
          style: ElevatedButton.styleFrom(
            minimumSize: Size(double.infinity, 50.0),
          ),
          child: Text('Sign Up'),
        ),
    );
  }

   Future<void>onRegisterPressed(BuildContext context)  async{


    String email = emailController.text.trim();
    bool isEmailValid= RegExp(
        r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$"
    ).hasMatch(email);

    if (nameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter name')),
      );
      return;
    }

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
        SnackBar(content: Text('Please enter password')),
      );
      return;
    }

    if (passwordController.text.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Password must be at least 6 characters')),
      );
      return;
    }

    if (nameController.text.isEmpty || emailController.text.isEmpty || passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill in all field')),
      );
      return;
    }

    if (savedEmail.isNotEmpty && savedEmail == emailController.text.trim()){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('User already exists! Please log in.'))
      );
      return;
    }


   try {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', nameController.text.trim());
    await prefs.setString('email', emailController.text.trim());
    await prefs.setString('password', passwordController.text);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Registration Successful! Please log in.')),
      );

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) {
            return LoginPage();
          },
        ),
            (route) => false,
      );
    } catch (e){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Registration not successful')),
      );
    }
  }
}



