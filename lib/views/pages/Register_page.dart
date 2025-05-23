import 'package:flutter/material.dart';
import 'package:new_app/views/pages/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/register_widget.dart';



class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late TextEditingController controllerName;
  late TextEditingController controllerEmail;
  late TextEditingController controllerPassword;

  String savedName = '';
  String savedEmail = '';
  String savedPassword = '';

  @override
  void initState() {
    super.initState();
    controllerName =  TextEditingController();
    controllerEmail = TextEditingController();
    controllerPassword = TextEditingController();
    _loadSavedCredentials();
  }

  Future<void> _loadSavedCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      savedName = prefs.getString('name') ?? '';
      savedEmail = prefs.getString('email') ?? '';
      savedPassword = prefs.getString('password') ?? '';

      controllerName.text = savedName;
      controllerEmail.text = savedEmail;
      controllerPassword.text = savedPassword;
    });
  }

  @override
  void dispose() {
    controllerName.dispose();
    controllerEmail.dispose();
    controllerPassword.dispose();
    super.dispose();
  }



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
                       bottomRight: Radius.circular(180.0)),
                   child: Image.asset('assets/images/wallpaper.png',
                     height: 270.0,
                     width: double.infinity,
                     fit: BoxFit.cover,
                   ),
                 ),
                 Positioned(
                   left: 20.0,
                   bottom: 130.0,
                   child: Text('Register to Explore More.',
                     style: TextStyle(color: Colors.white70,fontSize: 25.0, fontWeight: FontWeight.bold),
                   ),
                 )


               ],
             ),

            SizedBox(height: 30.0,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0),
              child: Text('Name',
                style: TextStyle(fontSize: 15.0),
              ),
            ),
            SizedBox(height: 10.0,),
            Container(
              margin: EdgeInsets.only(left: 15.0, right: 15.0),
              child: TextField(
                controller: controllerName,
              decoration: InputDecoration(
                hintText: 'Enter Name',
                prefixIcon: Icon(Icons.person
                ),
                border: OutlineInputBorder(
             borderRadius: BorderRadius.circular(15.0),),),
              ),
            ),
            SizedBox(height: 15.0,),
            Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0),
              child: Text('Email',
                style: TextStyle(fontSize: 15.0),
              ),
            ),
            SizedBox(height: 10.0,),
            Container(
              margin: EdgeInsets.only(left: 15.0, right: 15.0),
              child: TextField(
                controller: controllerEmail,
                decoration: InputDecoration(
                  hintText: 'Enter Email',
                  prefixIcon: Icon(Icons.email
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),),
              ),
            ),

            SizedBox(height: 15.0,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0),
              child: Text('Password',
                style: TextStyle(fontSize: 15.0),
              ),
            ),
            SizedBox(height: 10.0,),
            Container(
              margin: EdgeInsets.only(left: 15.0, right: 15.0),
              child: TextField(
                controller: controllerPassword,
                decoration: InputDecoration(
                  hintText: 'Enter Password',
                  prefixIcon: Icon(Icons.password
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),),
              ),
            ),

            SizedBox(height: 30.0),
            RegisterWidget(
              nameController: controllerName,
              emailController: controllerEmail,
              passwordController: controllerPassword,
              savedName: savedName,
              savedEmail: savedEmail,
              savedPassword: savedPassword,
            ),


            SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,

              children: [
                TextButton(onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return LoginPage();
                      },
                    ),
                  );
                }, child: Text("Already have an account? Sign In")

                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
