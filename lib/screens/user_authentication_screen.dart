import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:zartech_machine_test/authentication.dart';
import 'package:zartech_machine_test/components/button.dart';
import 'package:zartech_machine_test/screens/home_screen.dart';
import 'package:zartech_machine_test/screens/phone_login.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  User? result = FirebaseAuth.instance.currentUser;
  void showMessage(String message) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Error"),
            content: Text(message),
            actions: [
              TextButton(
                child: Text("Ok"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
          child: Container(
        height: 550,
        margin: EdgeInsets.only(left: 40, right: 40),
        child: Column(
          children: [
            Image.asset("assets/firebaselogo.png"),
            SizedBox(
              height: 80,
            ),
            Button('Google', () async {
              FirebaseService service = new FirebaseService();
              try {
                await service.signInwithGoogle();
                //print(result);
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                    (Route<dynamic> route) => false);

                print('ok');
              } catch (e) {
                if (e is FirebaseAuthException) {
                  showMessage(e.message!);
                }
              }
            }, Colors.blue, "assets/google.png", Colors.white),
            SizedBox(
              height: 20,
            ),
            Button('Phone', () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PhoneAuthForm()),
              );
            }, Colors.green, "assets/phone1.png", Colors.transparent),
            //Text(result != null ? result!.emailVerified.toString() : '')
          ],
        ),
      )),
    );
  }
}
