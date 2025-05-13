import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:new_app/views/widget_tree.dart';

TextEditingController controllerEmail = TextEditingController();
TextEditingController controllerPw = TextEditingController();
String confirmedEmail = '1234';
String confirmedPw = '5678';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController controllerEmail;
  late TextEditingController controllerPw;

  @override
  void initState() {
    controllerEmail = TextEditingController();
    controllerPw = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    controllerEmail.dispose();
    controllerPw.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
            children: [
            Lottie.asset('assets/lotties/login.json'),
            TextField(
              controller: controllerEmail,
              decoration: InputDecoration(
                hintText: 'Email',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0)
                ),
              ),
              onEditingComplete: () {
                setState(() {});
              },
            ),

            SizedBox(height: 10.0),
            TextField(
              controller: controllerPw,
              decoration: InputDecoration(
                hintText: 'Password',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0)
                ),
              ),
              onEditingComplete: () {
                setState(() {});
              },
            ),
            SizedBox(height: 20.0),
            FilledButton(
              onPressed: () {
                onLoginPressed();
              },
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 40.0
                ),
              ),

              child: Text('Login'),
            ),
            SizedBox(height: 10.0,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(onPressed: () {}, child: Text('Forgot Password?')),

                TextButton(onPressed: () {}, child: Text('Sign Up')),
              ],
            ),
          ],
        ),
      ),
    );
  }


  void onLoginPressed() {
    if (confirmedEmail == controllerEmail.text &&
        confirmedPw == controllerPw.text) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) {
            return WidgetTree();
          },
        ),
          (route) =>false,
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Invalid credentials')),
      );
    }
  }

}