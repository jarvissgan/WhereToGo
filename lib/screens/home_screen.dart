import 'package:flutter/material.dart';
import 'package:jarlist/screens/login_screen.dart';
import 'package:jarlist/screens/settings_screen.dart';
import 'package:jarlist/services/auth_service.dart';
import 'package:jarlist/widgets/home_screen/list_builder.dart';
import 'package:jarlist/widgets/home_screen/recommended_list.dart';

class HomeWidget extends StatefulWidget {
  static const String routeName = '/home';

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {

  logOut(){
    AuthService authService = AuthService();
    return authService.logout().then((value) {
      FocusScope.of(context).unfocus();
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Logged in successfully!'),
        duration: Duration(seconds: 1),
      ));
      Navigator.pushReplacementNamed(context, LoginScreen.routeName);
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
    return Expanded(
      child: Column(
        children: [
          Align(
              alignment: Alignment.topLeft,
              child: Container(
                  margin: const EdgeInsets.only(top: 15, left: 40, right: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "JarList",
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      //popup menu
                      PopupMenuButton<String>(
                        onSelected: (value) {
                          //checks for settings
                          if (value == "Settings") {
                            Navigator.pushNamed(context, SettingsScreen.routeName);
                          } else if (value == "Logout") {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                      title: Text('Logout'),
                                      content: Text(
                                          'Are you sure you want to logout?'),
                                      actions: [
                                        TextButton(
                                          child: Text('Cancel'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                        TextButton(
                                          child: Text('Logout'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                            logOut();
                                            Navigator.of(context)
                                                .pushNamed(LoginScreen.routeName);
                                          },
                                        )
                                      ]);
                                });
                          }
                          //logout
                        },
                        itemBuilder: (BuildContext context) =>
                            <PopupMenuEntry<String>>[
                          PopupMenuItem<String>(
                            value: 'Account',
                            child: Text('Account'),
                          ),
                          PopupMenuItem<String>(
                            value: 'Settings',
                            child: Text('Settings'),
                          ),
                          PopupMenuItem<String>(
                            value: 'Logout',
                            child: Text('Logout'),
                          ),
                        ],
                      ),
                    ],
                  ))),
          ListBuilder(),
          Spacer(),
          RecommendedList(),
        ],
      ),
    );
  }
}
