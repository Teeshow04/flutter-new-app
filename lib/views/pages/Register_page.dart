import 'package:flutter/material.dart';
import 'package:quoteflow_app/views/pages/login_page.dart';
import 'package:quoteflow_app/views/widgets/register_widget.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(180.0),
                  ),
                  child: Image.asset(
                    'assets/images/wallpaper.png',
                    height: 270.0,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  left: 20.0,
                  bottom: 130.0,
                  child: Text(
                    'Register to Explore More.',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 30.0),
            RegisterWidget(),

            SizedBox(height: 20.0),
            Center(
              child: Text(
                'or Login with',
                style: TextStyle(fontSize: 25.0),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 18.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {},
                  child: Image.asset('assets/images/google.png', height: 40.0),
                ),

                SizedBox(width: 30.0),
                GestureDetector(
                  onTap: () {},
                  child: Image.asset('assets/images/apple.png', height: 40.0),
                ),
              ],
            ),
            SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,

              children: [
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return LoginPage();
                        },
                      ),
                    );
                  },
                  child: Text("Already have an account? Sign In"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
