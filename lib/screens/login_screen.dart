import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:jarlist/main.dart';
import 'package:jarlist/screens/register_screen.dart';
import 'package:jarlist/services/auth_service.dart';
import 'package:jarlist/widgets/forget_password.dart';
import 'package:jarlist/widgets/google_button.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = '/login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? _email;

  String? _password;

  var form = GlobalKey<FormState>();

  login() {
    bool isValid = form.currentState!.validate();
    if (isValid) {
      form.currentState!.save();
    }

    AuthService authService = AuthService();

    return authService.login(_email, _password).then((value) {
      FocusScope.of(context).unfocus();
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Logged in successfully!'),
        duration: Duration(seconds: 1),
      ));
      Navigator.of(context).pushReplacementNamed(MainScreen.routeName);
    }).catchError((error) {
      FocusScope.of(context).unfocus();
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(error.toString()),
        duration: Duration(seconds: 1),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Form(
          key: form,
          child: Column(
            //email and password
            children: [
              Container(
                height: MediaQuery.of(context).size.height / 100 * 25,
                margin: EdgeInsets.only(right: 50, left: 30),
                child: const Align(
                  alignment: Alignment.bottomLeft,
                  //TODO: lower the text
                  child: Text('JarList',
                      style:
                          TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 30, right: 30, top: 20),
                    child: TextFormField(
                      //email
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null) {
                          return 'Please enter an email';
                        } else if (!value.contains('@')) {
                          return 'Please enter a valid email';
                        } else {
                          return null;
                        }
                      },
                      onSaved: (value) {
                        _email = value;
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Email',
                        // isDense: true,
                        // contentPadding: EdgeInsets.all(8),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 30, right: 30, top: 20),
                    child: TextFormField(
                      obscureText: true,
                      validator: (value) {
                        if (value == null) {
                          return 'Please enter a password';
                        } else if (value.length < 6) {
                          return 'Please enter a password with at least 6 characters';
                        } else {
                          return null;
                        }
                      },
                      onSaved: (value) {
                        _password = value;
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Password',
                        // isDense: true,
                        // contentPadding: EdgeInsets.all(8),
                      ),
                    ),
                  ),
                  ForgetPassword(),
                  //TODO: Login with Google
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(left: 30, right: 30, top: 30),
                    child: ElevatedButton(
                      child: Text('Login'),
                      onPressed: () {
                        login();
                      },
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(left: 30, right: 30, top: 10),
                    child: ElevatedButton(
                      child: Text('Register'),
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed(RegisterScreen.routeName);
                      },
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.only(left: 30, right: 30, top: 20),
                      child: Text('OR')),

                  //login with google
                  GoogleButton(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
