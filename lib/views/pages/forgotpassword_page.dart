import 'package:flutter/material.dart';
import 'package:new_app/views/pages/login_page.dart';

class ForgotpasswordPage extends StatelessWidget {
  const ForgotpasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('ForgotPassword'),
        leading: BackButton(
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
        ),
      ),
    );
  }
}
