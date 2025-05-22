import 'package:flutter/material.dart';
import 'package:new_app/views/pages/login_page.dart';



class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
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
                decoration: InputDecoration(
                  hintText: 'Enter Password',
                  prefixIcon: Icon(Icons.password
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),),
              ),
            ),

           SizedBox(height: 20.0),
            Container(
              margin: EdgeInsets.only(left: 15.0, right: 15.0),
              child: FilledButton(
                onPressed: () {
                },
                style: FilledButton.styleFrom(
                  minimumSize: Size(double.infinity, 50.0),
                ),
                child: Text('Sign up'),
              ),
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
                }, child: Text("Don't have an account? Sign In")

                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
