import 'package:flutter/material.dart';
import 'package:jarlist/auth_service.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? _email;

  String? _password;

  var form = GlobalKey<FormState>();

  login(){
    bool isValid = form.currentState!.validate();
    if(isValid){
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
    return Scaffold(
      body: Form(
        key: form,
        child: Center(
          child: Column(
            //email and password
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null) {
                    return 'Please enter an email';
                  }
                  else if(!value.contains('@')) {
                    return 'Please enter a valid email';
                  } else {
                    return null;
                  }
                },
                onSaved: (value) {
                  _email = value;
                },
                decoration: InputDecoration(
                  labelText: 'Email',
                ),
              ),
              TextFormField(
                obscureText: true,
                validator: (value) {
                  if (value == null) {
                    return 'Please enter a password';
                  }
                  else if(value.length < 6) {
                    return 'Please enter a password with at least 6 characters';
                  } else {
                    return null;
                  }
                },
                onSaved: (value) {
                  _password = value;
                },
                decoration: InputDecoration(
                  labelText: 'Password',
                ),
              ),
              ElevatedButton(
                child: Text('Login'),
                onPressed: () {
                  login();
                },
              ),
            ],
          )
        ),
      ),
    );
  }
}
