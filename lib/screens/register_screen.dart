import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = '/register';
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String email = '';
  String password = '';
  String confirmPassword = '';
  String firstName = '';
  String lastName = '';
  String error = '';
  final _formKey = GlobalKey<FormState>();


  void register(){
    bool isValid = _formKey.currentState!.validate();
    if(isValid){
      _formKey.currentState!.save();
    }
    if(password != confirmPassword){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Passwords do not match'),
        duration: Duration(seconds: 1),
      ));
    }
    FocusScope.of(context).unfocus();
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Registering...'),
      duration: Duration(seconds: 1),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Flex(
            direction: Axis.vertical,
            children: [Expanded(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 50, left: 50, right: 50),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: IconButton(
                        icon: Icon(Icons.arrow_back),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 50, left: 50, right: 50),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text('Settings',
                          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                    ),
                  ),
                  SizedBox(
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 30, right: 30, top: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text('First Name: '),
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 100 * 50,
                                child: TextFormField(
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter a first name';
                                    } else if (value.length < 3) {
                                      return 'Please enter a first name with at least 3 characters';
                                    } else {
                                      return null;
                                    }
                                  },
                                  onSaved: (value) {
                                    firstName = value!;
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
                          margin: EdgeInsets.only(left: 30, right: 30, top: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text('Last Name: '),
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 100 * 50,
                                child: TextFormField(
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter a last name';
                                    } else if (value.length < 3) {
                                      return 'Please enter a last name with at least 3 characters';
                                    } else {
                                      return null;
                                    }
                                  },
                                  onSaved: (value) {
                                    lastName = value!;
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
                          margin: EdgeInsets.only(left: 30, right: 30, top: 20),
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
                                      email = value!;
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
                                    password = value!;
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
                          margin: EdgeInsets.only(left: 30, right: 30, top: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text('Confirm Password: '),
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 100 * 50,
                                child: TextFormField(
                                  obscureText: true,
                                  validator: (value) {
                                    if (value == null) {
                                      return 'Please re-enter your password';
                                    } else if (password != value) {
                                      return 'Passwords do not match';
                                    } else {
                                      return null;
                                    }
                                  },
                                  onSaved: (value) {
                                    confirmPassword = value!;
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
                        //TODO: Login with Google
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
                        //textbutton to clear textformfields
                        Container(
                          margin: EdgeInsets.only(left: 30, right: 30, top: 30),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width / 100 * 30,
                            height: MediaQuery.of(context).size.width / 100 * 10,
                            child: ElevatedButton(
                              child: Text('Clear'),
                              onPressed: () {
                                setState(() {
                                  firstName = '';
                                  lastName = '';
                                  email = '';
                                  password = '';
                                  confirmPassword = '';
                                  _formKey.currentState!.reset();
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),]
          ),
        ));
  }
}
