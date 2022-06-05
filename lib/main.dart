import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jarlist/screens/landing.dart';
import 'package:jarlist/selectedIndex.dart';
import 'package:jarlist/widgets/bottom_navbar.dart';
import 'package:jarlist/widgets/home_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'screens/list_screen.dart';

void main() {
  runApp(MyApp());
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainScreen(),
      routes: {
        LandingScreen.routeName: (_) => LandingScreen(),
        ListScreen.routeName: (_) => ListScreen(),
      },
    );
  }
}

class MainScreen extends StatelessWidget {
  static String routeName = '/';
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    print(SelectedIndex().selectedIndex);

    //retrieve the selected index from shared preferences
    SharedPreferences.getInstance().then((prefs) {
      SelectedIndex().selectedIndex = prefs.getInt('selectedIndex') ?? 0;
    });
    // print(selectedIndex);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: -20,
      ),
      body: HomeWidget(),
      bottomNavigationBar: BottomNavBar(),
      );
  }
}
