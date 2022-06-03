import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jarlist/widgets/bottom_navbar.dart';
import 'package:jarlist/widgets/home_widget.dart';

import 'screens/entry_screen.dart';

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
        EntryScreen.routeName: (_) {return EntryScreen();},
      },
    );
  }
}

class MainScreen extends StatelessWidget {
  static String routeName = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: -20,
      ),
      body: HomeWidget(),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
