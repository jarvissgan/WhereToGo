import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:jarlist/main.dart';
import 'package:jarlist/screens/register_screen.dart';
import 'package:jarlist/services/auth_service.dart';

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
                margin: EdgeInsets.only(right: 50, left: 50),
                child: const Align(
                  alignment: Alignment.bottomLeft,
                  //TODO: lower the text
                  child: Text('JarList',
                      style:
                          TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 100 * 50,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 30, right: 30),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('Email: \t\t\t\t\t\t\t\t'),
                            SizedBox(
                              width:
                                  MediaQuery.of(context).size.width / 100 * 50,
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
                                  isDense: true,
                                  contentPadding: EdgeInsets.all(8),
                                ),
                              ),
                            ),
                          ]),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 30, right: 30, top: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('Password: '),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 100 * 50,
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
                                isDense: true,
                                contentPadding: EdgeInsets.all(8),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 50, right: 50, top: 10),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            RichText(
                              text: TextSpan(
                                  text: 'Forgot Password? ',
                                  style: TextStyle(
                                      color: Colors.blue,
                                      decoration: TextDecoration.underline),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      //dialog box to reset password
                                      showDialog(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                                title: Text('Reset Password'),
                                                content: TextField(
                                                  decoration: InputDecoration(
                                                    labelText: 'Email',
                                                  ),
                                                ),
                                                actions: [
                                                  TextButton(
                                                    child: Text('Reset'),
                                                    onPressed: () {
                                                      //dialog to inform user that password has been reset
                                                      showDialog(
                                                          context: context,
                                                          builder: (context) =>
                                                              AlertDialog(
                                                                title: Text(
                                                                    'Password Reset'),
                                                                content: Text(
                                                                    'Password reset email sent'),
                                                                actions: [
                                                                  TextButton(
                                                                    child: Text(
                                                                        'Ok'),
                                                                    onPressed:
                                                                        () {
                                                                      Navigator.pop(
                                                                          context);
                                                                      Navigator.pop(
                                                                          context);
                                                                    },
                                                                  )
                                                                ],
                                                              ));
                                                    },
                                                  )
                                                ],
                                              ));
                                    }),
                            ),
                          ]),
                    ),
                    //TODO: Login with Google
                    //TODO: register button
                    Container(
                      margin: EdgeInsets.only(left: 30, right: 30, top: 30),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width / 100 * 30,
                        height: MediaQuery.of(context).size.width / 100 * 10,
                        child: ElevatedButton(
                          child: Text('Login'),
                          onPressed: () {
                            Navigator.of(context)
                                .pushNamed(MainScreen.routeName);
                          },
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 30, right: 30, top: 30),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width / 100 * 30,
                        height: MediaQuery.of(context).size.width / 100 * 10,
                        child: ElevatedButton(
                          child: Text('Register'),
                          onPressed: () {
                            Navigator.of(context)
                                .pushNamed(RegisterScreen.routeName);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
