import 'package:flutter/material.dart';
import 'package:jarlist/services/auth_service.dart';
import 'package:jarlist/services/firestore_service.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = '/register';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String email = '';
  String password = '';
  String confirmPassword = '';
  String error = '';
  final _formKey = GlobalKey<FormState>();

  register() {
    bool isValid = _formKey.currentState!.validate();
    if (isValid) {
      _formKey.currentState!.save();

      AuthService authService = AuthService();
      // print(email);
      // print(password);
      FocusScope.of(context).unfocus();
      return authService.register(email, password).then((value) {
        FirestoreService fsService = FirestoreService();

        //creates new collection for user
        fsService.createUser(value.user!.uid, email, '');
        // fsService.onUserCreated(value.user!.uid);
        // fsService.deleteCreated(value.user!.uid);
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Registered'),
          duration: Duration(seconds: 1),
        ));

        Navigator.of(context).pop();
      }).catchError((error) {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(error.message),
          duration: Duration(seconds: 1),
        ));
      });
    }
    if (password != confirmPassword) {
      _formKey.currentState!.reset();
      // print(password);
      // print(confirmPassword);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Passwords do not match'),
        duration: Duration(seconds: 1),
      ));
    }

    // FocusScope.of(context).unfocus();
    // ScaffoldMessenger.of(context).hideCurrentSnackBar();
    // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //   content: Text('Registering...'),
    //   duration: Duration(seconds: 1),
    // ));
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Flex(direction: Axis.vertical, children: [
            Expanded(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 50, left: 30, right: 50),
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
                    margin: EdgeInsets.only(top: 20, left: 30, right: 50),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text('Register',
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold)),
                    ),
                  ),
                  Column(
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
                            email = value!;
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            // isDense: true,
                            // contentPadding: EdgeInsets.all(8),
                            labelText: 'Enter your email',
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
                            password = value!;
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            // isDense: true,
                            // contentPadding: EdgeInsets.all(8),
                            hintText: 'Password',
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 30, right: 30, top: 20),
                        child: TextFormField(
                          obscureText: true,
                          validator: (value) {
                            if (value == null) {
                              return 'Please re-enter your password';
                            } else {
                              return null;
                            }
                          },
                          onSaved: (value) {
                            confirmPassword = value!;
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            // isDense: true,
                            // contentPadding: EdgeInsets.all(8),
                            hintText: 'Confirm Password',
                          ),
                        ),
                      ),
                      //TODO: Login with Google
                      Container(
                        margin: EdgeInsets.only(left: 30, right: 30, top: 30),
                        width: double.infinity,
                        child: ElevatedButton(
                          child: Text('Create Account'),
                          onPressed: () {
                            register();
                          },
                        ),
                      ),
                      Container(
                          margin: EdgeInsets.only(left: 30, right: 30, top: 20),
                          child: Text('OR')),

                      //login with google
                      Container(
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
                            // Navigator.of(context)
                            //     .pushNamed(RegisterScreen.routeName);
                          },
                        ),
                      ),
                      //anomymous login
                      Container(
                        margin: EdgeInsets.only(left: 30, right: 30, top: 20),
                        width: double.infinity,
                        child: ElevatedButton(
                          child: Text('Sign in as guest'),
                          onPressed: () {
                            Navigator.of(context)
                                .pushNamed(RegisterScreen.routeName);
                          },
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
                  )
                ],
              ),
            ),
          ]),
        ));
  }
}
