import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/constants.dart';
import '../../data/notifiers.dart';
import '../widgets/logout_widget.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key, required this.title});

  final String title;

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        leading: BackButton(
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              'Account', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0) ,
            )
      ),
          ListTile(
            leading:Icon(Icons.lock),
            title: Text('Privacy & Policy'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.notifications),
            title: Text('Notifcation'),
            
          ),
          ValueListenableBuilder<bool>(
            valueListenable: isDarkModeNotifier,
            builder: (context, isDarkMode, _) {
              return ListTile(
                leading: Icon(Icons.apartment),
                title: Text('Appearance'),
                trailing: Switch.adaptive(
                  value: isDarkMode,
                  onChanged: (bool value) async {
                    isDarkModeNotifier.value = !isDarkModeNotifier.value;
                    final prefs = await SharedPreferences.getInstance();
                    await prefs.setBool(KConstant.themeModeKey, value);
                  },
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.rate_review),
            title: Text('Rate Us'),
          ),
          SizedBox(height: 10),
          LogoutTile()
            ],
      ),
    );
  }
}
