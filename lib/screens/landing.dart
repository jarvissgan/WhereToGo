import 'package:flutter/material.dart';
import 'package:jarlist/widgets/bottom_navbar.dart';
import 'package:jarlist/widgets/home_widget.dart';

class LandingScreen extends StatefulWidget {
  static const String routeName = '/landing';

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  int selectedIndex = 0;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Landing'),
      ),
    );
  }
}
