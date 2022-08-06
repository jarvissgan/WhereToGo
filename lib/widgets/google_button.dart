import 'package:flutter/material.dart';
import 'package:jarlist/services/auth_service.dart';
import 'package:jarlist/services/firestore_service.dart';

class GoogleButton extends StatefulWidget {

  @override
  State<GoogleButton> createState() => _GoogleButtonState();
}

class _GoogleButtonState extends State<GoogleButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 30, right: 30, top: 20),
      width: double.infinity,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          primary: const Color(0xff4285F4),
          textStyle: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w500,
            fontFamily: 'Roboto',
          ),
          padding: EdgeInsets.all(8),
        ),
        label: Text('Sign in with Google'),
        //uses the google icon
        icon: Icon(Icons.account_circle),
        /*Image.asset('assets/images/google_logo.png' , height: 20, width: 20,)*/
        onPressed: () {
          AuthService authService = AuthService();
          authService.signInWithGoogle().then((value) {
          FirestoreService fsService = FirestoreService();
          fsService.createUser(value.user!.uid, '', '');

          Navigator.of(context).pushReplacementNamed('/home');
    }).catchError((error) {
          print(error.message);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(error.message),
          duration: Duration(seconds: 10),
          ));
          });

          // Navigator.of(context)
          //     .pushNamed(RegisterScreen.routeName);
        },
      ),
    );
  }
}
