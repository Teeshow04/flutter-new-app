import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:quoteflow_app/data/constants.dart';
import 'package:quoteflow_app/views/pages/register_page.dart';
import 'package:quoteflow_app/views/pages/welcome_page.dart';

import 'login_page.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return WelcomePage();
                },
              ),
            );
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset('assets/lotties/welcome_back.json'),

            SizedBox(height: 20.0),
            Text(
              'We are a community that shows your uniqueness',
              style: KTextStyle.descriptionText,
              textAlign: TextAlign.justify,
            ),

            SizedBox(height: 20.0),
            OutlinedButton(
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
              style: ElevatedButton.styleFrom(
                textStyle: TextStyle(fontSize: 20.0),
                minimumSize: Size(double.infinity, 60.0),
              ),

              child: Text('Sign In'),
            ),

            SizedBox(height: 50.0),
            FilledButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return RegisterPage();
                    },
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                textStyle: TextStyle(fontSize: 20.0),
                minimumSize: Size(double.infinity, 60.0),
              ),

              child: Text('Sign Up'),
            ),
          ],
        ),
      ),
    );
  }
}
