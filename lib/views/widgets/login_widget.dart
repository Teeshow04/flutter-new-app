import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../widget_tree.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({super.key});
  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String email = '';
  String password = '';

  final _formkey = GlobalKey<FormState>();
  bool _isLoading = false;
  bool _obscurePassword = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  onLoginPressed() async {
    if (!_formkey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
            email: emailController.text,
            password: passwordController.text,
          );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.green,
            content: Text('Login Successful', style: TextStyle(fontSize: 20.0)),
          ),
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => WidgetTree()),
        );
      }
    } on FirebaseAuthException catch (e) {
      if (mounted) {
        if (e.code == 'user-not-found') {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.teal,
              content: Text(
                'No user found for that email',
                style: TextStyle(fontSize: 18.0),
              ),
            ),
          );
        } else if (e.code == 'wrong-password') {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.teal,
              content: Text('Wrong password provided'),
            ),
          );
        } else if (e.code == 'invalid-email') {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.red,
              content: Text(
                'Invalid email address',
                style: TextStyle(fontSize: 18.0),
              ),
            ),
          );
        } else if (e.code == 'too-many-request') {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.orangeAccent,
              content: Text(
                'Too many attempt Please try again',
                style: TextStyle(fontSize: 18.0),
              ),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.red,
              content: Text(
                'Login failed. Please try again',
                style: TextStyle(fontSize: 18.0),
              ),
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            content: Text('An error occured: $e'),
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 35.0),
      child: Form(
        key: _formkey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Text('Email', style: TextStyle(fontSize: 15.0)),
            ),
            SizedBox(height: 10.0),
            Container(
              margin: EdgeInsets.only(left: 10.0, right: 10.0),
              child: TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please Enter Email';
                  }
                  return null;
                },
                controller: emailController,
                decoration: InputDecoration(
                  hintText: 'Enter Email` ',
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                ),
              ),
            ),

            SizedBox(height: 15.0),
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Text('Password', style: TextStyle(fontSize: 15.0)),
            ),
            SizedBox(height: 10.0),
            Container(
              margin: EdgeInsets.only(left: 10.0, right: 10.0),
              child: TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please Enter Password';
                  }
                  return null;
                },
                controller: passwordController,
                obscureText: _obscurePassword,
                decoration: InputDecoration(
                  hintText: 'Enter Password',
                  prefixIcon: Icon(Icons.lock),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                ),
              ),
            ),

            // SizedBox(height: 15.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) {
                    //       return ForgotpasswordPage();
                    //     },
                    //   ),
                    // );
                  },
                  child: Text('Forgot Password'),
                ),
              ],
            ),

            SizedBox(height: 10.0),

            GestureDetector(
              onTap: () {
                if (_formkey.currentState!.validate()) {
                  setState(() {
                    email = emailController.text;
                    password = passwordController.text;
                  });
                }
                onLoginPressed();
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 15.0),
                child: FilledButton(
                  onPressed: _isLoading ? null : onLoginPressed,
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 50.0),
                  ),
                  child:
                      _isLoading
                          ? CircularProgressIndicator(color: Colors.white70)
                          : Text('Login'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
