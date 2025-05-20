import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:new_app/data/notifiers.dart';
// import 'package:new_app/views/widget_tree.dart';
import 'package:new_app/views/pages/welcome_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

// Stateless

// material app
// scaffold
// App title
// Bottom navigation bar setState

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  get savedTheme => null;

  @override
  void initState() {
  initThemeMode();
    super.initState();
  }

  void initThemeMode() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool? _ = prefs.getBool('KConstant.themeModeKey');
    isDarkModeNotifier.value = savedTheme ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: isDarkModeNotifier,
      builder: (context, isDarkMode, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            // textTheme: GoogleFonts.soraTextTheme(),
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.teal,
              brightness: isDarkMode ? Brightness.dark : Brightness.light,
            ),
          ),
          home: WelcomePage(),
        );
      },
    );
  }
}
