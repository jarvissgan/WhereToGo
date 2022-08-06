import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:jarlist/services/auth_service.dart';

class ForgetPassword extends StatefulWidget {
  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

var _formKey = GlobalKey<FormState>();
String email = '';

class _ForgetPasswordState extends State<ForgetPassword> {
  @override
  Widget build(BuildContext context) {

    resetPassword() {

      if (_formKey.currentState!.validate()) {
        FocusScope.of(context).unfocus();

        _formKey.currentState!.save();
        AuthService authService = AuthService();
        authService.forgotPassword(email).then((value) => {

          //creates dialog if email is sent
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Email Sent'),
                content: Text('Check your email for a reset link'),
                actions: <Widget>[
                  FlatButton(
                    child: Text('OK'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          ),

          //if email doesn't exist, creates dialog
          ScaffoldMessenger.of(context).hideCurrentSnackBar(),
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Check your email for reset link'),
            duration: Duration(seconds: 1),
          ))
        }).catchError((error) => {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Error'),
                content: Text(error.toString()),
                actions: <Widget>[
                  FlatButton(
                    child: Text('OK'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          ),
        });
      } else {
        FocusScope.of(context).unfocus();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Please enter a valid email'),
          duration: Duration(seconds: 1),
        ));
      }
    }

    return Container(
      margin: EdgeInsets.only(left: 50, right: 50, top: 10),
      child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
        RichText(
          text: TextSpan(
              text: 'Forgot Password? ',
              style: TextStyle(
                  color: Colors.blue, decoration: TextDecoration.underline),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  //dialog box to reset password
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            title: Text('Reset Password'),
                            content: Form(
                              key: _formKey,
                              child: TextFormField(
                                decoration: InputDecoration(
                                  labelText: 'Email',
                                  //clear button
                                  suffixIcon: IconButton(
                                    icon: Icon(Icons.clear),
                                    onPressed: () {
                                      setState(() {
                                        _formKey.currentState!.reset();
                                      });
                                    },
                                  ),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter an email';
                                  } else if (!value.contains('@')) {
                                    return 'Please enter a valid email';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  email = value!;
                                },
                              ),
                            ),
                            actions: [
                              TextButton(
                                child: Text('Reset'),
                                onPressed: () {
                                  //dialog to inform user that password has been reset
                                  resetPassword();

                                  // showDialog(
                                  //     context: context,
                                  //     builder: (context) => AlertDialog(
                                  //           title: Text('Password Reset'),
                                  //           content: Text(
                                  //               'Password reset email sent'),
                                  //           actions: [
                                  //             TextButton(
                                  //               child: Text('Ok'),
                                  //               onPressed: () {
                                  //                 // Navigator.pop(context);
                                  //                 // Navigator.pop(context);
                                  //               },
                                  //             )
                                  //           ],
                                  //         ));
                                },
                              )
                            ],
                          ));
                }),
        ),
      ]),
    );
  }
}
