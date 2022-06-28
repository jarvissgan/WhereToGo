import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  static const String routeName = '/settings';

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

bool _switchState = false;

class _SettingsScreenState extends State<SettingsScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 50, left: 50, right: 50),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Text('Settings',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Text('General',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w400)),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Text('Notifications',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w400)),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Text('Appearance',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w400)),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Row(
                children: [
                  Text('Dark Mode',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w400)),
                  Switch(
                    value: _switchState,
                    onChanged: (value) {
                      setState(() {
                        _switchState = value;
                      });
                      //TODO: switch dark mode
                      if (value) {
                        print('dark mode');
                      } else {
                        print('light mode');
                      }
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
