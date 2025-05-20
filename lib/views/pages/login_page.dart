import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:new_app/views/pages/forgotpassword_page.dart';
import 'package:new_app/views/pages/Register_page.dart';
import 'package:new_app/views/pages/welcome_page.dart';
import 'package:new_app/views/widget_tree.dart';
import 'package:new_app/views/widgets/login_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'onboarding_page.dart';

TextEditingController controllerEmail = TextEditingController();
TextEditingController controllerPw = TextEditingController();
String confirmedEmail = '';
String confirmedPw = '';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController controllerEmail;
  late TextEditingController controllerPassword;
  bool _obsurePassword = true;
  String savedEmail = '';
  String savedPassword = '';

  @override
  void initState() {
    super.initState();
    controllerEmail = TextEditingController();
    controllerPassword = TextEditingController();
    _loadSavedCredentials();
  }


  Future<void> _loadSavedCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      savedEmail = prefs.getString('email') ?? '1234';
      savedPassword = prefs.getString('password') ?? '5678';
    });
  }


  @override
  void dispose() {
    controllerEmail.dispose();
    controllerPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return OnBoardingPage();
                },
              ),
            );
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: LayoutBuilder(builder: (context, BoxConstraints constraints) {
          return  FractionallySizedBox(
            widthFactor: widthScreen > 500 ? 0.5 : 1.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Hello\nSign in!',
                style: TextStyle(
                  color: Colors.teal,
                  fontSize: 32.0,
                ),
                ),
                // SizedBox(height: 10),

                // SizedBox(
                //   width: 500.0,
                //   height: 200.0,
                //
                //   child: Lottie.asset('assets/lotties/login.json'),
                // ),

                SizedBox(height: 50.0,),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.0),
                  child: Text('Email',
                    style: TextStyle(fontSize: 15.0),
                  ),
                ),

                SizedBox(height: 15.0,),
                TextField(
                  controller: controllerEmail,
                  decoration: InputDecoration(
                    hintText: 'Enter Email',
                    prefixIcon: Icon(Icons.email
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0)
                    ),
                  ),
                  onEditingComplete: () {
                    setState(() {});
                  },
                ),

                SizedBox(height: 20.0,),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.0),
                  child: Text('Password',
                    style: TextStyle(fontSize: 15.0),
                  ),
                ),

                SizedBox(height: 10.0),
                TextField(
                  controller: controllerPassword,
                  decoration: InputDecoration(
                    hintText: 'Enter Password',
                    prefixIcon: Icon(Icons.password),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0)
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(_obsurePassword ? Icons.visibility_off : Icons.visibility),
                      onPressed: () {
                        setState(() {
                          _obsurePassword = !_obsurePassword;
                        });
                      }),
                   ),
                  obscureText: _obsurePassword,
                  onEditingComplete: () {
                    setState(() {});
                  },
                ),

                // SizedBox(height: 5.0,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return ForgotpasswordPage();
                          },
                        ),
                      );
                    }, child: Text('Forgot Password')),
                  ],
                ),

                SizedBox(height: 10.0),
                LoginWidget(
                  emailController: controllerEmail,
                  passwordController: controllerPassword,
                 savedEmail: savedEmail,
                  savedPassword: savedPassword,
                ),

                SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,

                  children: [
                    TextButton(onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return RegisterPage();
                          },
                        ),
                      );
                    }, child: Text("Don't have an account? Sign up")

                    ),
                  ],
                ),
              ],
            ),
          );
        },),
      ),
    );
  }
}