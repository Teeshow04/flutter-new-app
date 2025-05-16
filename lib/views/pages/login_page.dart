import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';
import 'package:new_app/views/widget_tree.dart';
import 'package:shared_preferences/shared_preferences.dart';

TextEditingController controllerEmail = TextEditingController();
TextEditingController controllerPw = TextEditingController();
String confirmedEmail = '';
String confirmedPw = '';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController controllerEmail;
  late TextEditingController controllerPw;
  bool _obsurePassword = true;
  String savedEmail = '1234';
  String savedPassword = '5678';

  @override
  void initState() {
    super.initState();
    controllerEmail = TextEditingController();
    controllerPw = TextEditingController();
    _loadSavedCredentials();
  }


  Future<void> _loadSavedCredentials() async {
    final prefs = await SharedPreferences.getInstance();

    final loginEmail = prefs.getString('login_email');
    final loginPassword = prefs.getString('login_password');
    final profileEmail = prefs.getString('email');
    final profilePassword = prefs.getString('password');
    setState(() {
      savedEmail = prefs.getString('email') ?? '1234';
      savedPassword = prefs.getString('password') ?? '5678';
    });
  }


  @override
  void dispose() {
    controllerEmail.dispose();
    controllerPw.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: LayoutBuilder(builder: (context, BoxConstraints constraints) {
          return  FractionallySizedBox(
            widthFactor: widthScreen > 500 ? 0.5 : 1.0,
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset('assets/lotties/login.json'),
                TextField(
                  controller: controllerEmail,
                  decoration: InputDecoration(
                    hintText: 'Email',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0)
                    ),
                  ),
                  onEditingComplete: () {
                    setState(() {});
                  },
                ),

                SizedBox(height: 10.0),
                TextField(
                  controller: controllerPw,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0)
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(_obsurePassword ? Icons.visibility_off : Icons.visibility),
                      onPressed: () {
                        setState(() {
                          _obsurePassword = !_obsurePassword;
                        });
                      }),
                   ),
                  obscureText: _obsurePassword,
                  onEditingComplete: () {
                    setState(() {});
                  },
                ),
                SizedBox(height: 20.0),
                FilledButton(
                  onPressed: () {
                    onLoginPressed();
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 40.0
                    ),
                  ),

                  child: Text('Login'),
                ),
                SizedBox(height: 10.0,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(onPressed: () {}, child: Text('Forgot Password?')),

                    TextButton(onPressed: () {}, child: Text('Sign Up')),
                  ],
                ),
              ],
            ),
          );
        },),
      ),
    );
  }



  void onLoginPressed() {
    if (controllerEmail.text.isEmpty || controllerPw.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter both email and password')),
      );
      return;
    }



    if (savedEmail == controllerEmail.text &&
        savedPassword == controllerPw.text) {
      ('Login Success');
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) {
            return WidgetTree();
          },
        ),
          (route) =>false,
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Invalid credentials')),
      );
    }
  }

}