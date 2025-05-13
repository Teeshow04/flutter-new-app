import 'package:flutter/material.dart';
import 'package:new_app/data/notifiers.dart';
import 'package:new_app/views/pages/welcome_page.dart';

class LogoutTile extends StatelessWidget {
  const LogoutTile({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.logout),
      title: Text('Logout'),
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Logout'),
              content: Text('Are you sure you want to logout?'),
              actions: [
                TextButton(
                  child: Text('Cancel'),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                TextButton(
                  child: Text('Logout'),
                  onPressed: () {
                    selectedPageNotifier.value = 0;
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => WelcomePage()),
                    );
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }
}
