import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:new_app/data/constants.dart';

import 'login_page.dart';


class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset('assets/lotties/welcome.json'),

            SizedBox(height: 20.0),
            Text('We are a community that shows your uniqueness',
            style: KTextStyle.descriptionText,
            textAlign: TextAlign.justify),

            FilledButton(
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
                minimumSize: Size(double.infinity, 40.0
                ),
              ),

              child: Text('Next'),
            ),

          ],
        ),
      ),
    );
  }
}