import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quoteflow_app/views/widget_tree.dart';

class RegisterWidget extends StatefulWidget {
  const RegisterWidget({super.key});

  @override
  State<RegisterWidget> createState() => _RegisterWidgetState();
}

class _RegisterWidgetState extends State<RegisterWidget> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String name = '';
  String email = '';
  String password = '';

  final _formkey = GlobalKey<FormState>();
  bool _isLoading = false;
  bool _obsurePassword = true;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  onRegisterPressed() async {
    if (!_formkey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: emailController.text,
            password: passwordController.text,
          );

      await userCredential.user?.updateDisplayName(nameController.text.trim());

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.green,
            content: Text(
              'Registered Successfully',
              style: TextStyle(fontSize: 20.0),
            ),
          ),
        );

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => WidgetTree()),
          (route) => false,
        );
      }
    } on FirebaseAuthException catch (e) {
      String message = '';
      if (e.code == 'weak-password') {
        message = 'Password provided is too weak';
      } else if (e.code == 'email-already-in-use') {
        message = 'Account already Exist';
      } else if (e.code == 'invalid-email') {
        message = ' Invalid email address';
      } else {
        message = 'An error occurred. Please try again.';
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(backgroundColor: Colors.red, content: Text(message)),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            content: Text('An error occurred: $e'),
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
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      child: AutofillGroup(
        child: Form(
          key: _formkey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Text('Name', style: TextStyle(fontSize: 15.0)),
              ),
              SizedBox(height: 10.0),
              Container(
                margin: EdgeInsets.only(left: 10.0, right: 10.0),
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Name';
                    }
                  },
                  controller: nameController,
                  autofillHints: [AutofillHints.name],
                  decoration: InputDecoration(
                    hintText: 'Enter Name',
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 10.0),
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
                    if (!RegExp(
                      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                    ).hasMatch(value)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                  controller: emailController,
                  autofillHints: [AutofillHints.email],
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
                  },
                  controller: passwordController,
                  autofillHints: [AutofillHints.name],
                  obscureText: _obsurePassword,
                  decoration: InputDecoration(
                    hintText: 'Enter Password',
                    prefixIcon: Icon(Icons.lock),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obsurePassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                      onPressed: () {
                        setState(() {
                          _obsurePassword = !_obsurePassword;
                        });
                      },
                    ),
                  ),
                ),
              ),

              SizedBox(height: 25.0),

              GestureDetector(
                onTap: () {
                  if (_formkey.currentState!.validate()) {
                    setState(() {
                      name = nameController.text;
                      email = emailController.text;
                      password = passwordController.text;
                    });
                  }
                  onRegisterPressed();
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 10.0),
                  child: FilledButton(
                    onPressed: _isLoading ? null : onRegisterPressed,
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.infinity, 50.0),
                    ),
                    child:
                        _isLoading
                            ? CircularProgressIndicator(color: Colors.white70)
                            : Text('Sign Up'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
