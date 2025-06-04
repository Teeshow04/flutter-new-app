import 'package:flutter/material.dart';
import 'package:quoteflow_app/service/auth.dart';
import 'package:quoteflow_app/views/pages/register_page.dart';
import 'package:quoteflow_app/views/widgets/login_widget.dart';
import 'onboarding_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

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
        child: LayoutBuilder(
          builder: (context, BoxConstraints constraints) {
            return FractionallySizedBox(
              widthFactor: widthScreen > 500 ? 0.5 : 1.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hello\nSign in!',
                    style: TextStyle(color: Colors.teal, fontSize: 40.0),
                  ),

                  SizedBox(height: 50.0),
                  LoginWidget(),

                  SizedBox(height: 10.0),
                  Center(
                    child: Text(
                      'or Login with',
                      style: TextStyle(fontSize: 25.0),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          AuthMethods().signInWithGoogle(context);
                        },
                        child: Image.asset(
                          'assets/images/google.png',
                          height: 40.0,
                        ),
                      ),

                      SizedBox(width: 30.0),

                      GestureDetector(
                        onTap: () {},
                        child: Image.asset(
                          'assets/images/apple.png',
                          height: 40.0,
                          color: Colors.teal,
                        ),
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
                                return RegisterPage();
                              },
                            ),
                          );
                        },
                        child: Text("Don't have an account? Sign up"),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
