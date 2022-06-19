import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jarlist/screens/landing.dart';
import 'package:jarlist/screens/add_screen.dart';
import 'package:jarlist/screens/login_screen.dart';
import 'package:jarlist/widgets/home_widget.dart';


import 'screens/list_screen.dart';

void main() {
  runApp(MyApp());
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
}
List<String> items = List.generate(
  50,
      (i) => "List $i",
);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginScreen(),
      // initialRoute: HomeWidget.routeName,
      routes: {
        LandingScreen.routeName: (_) => LandingScreen(),
        ListScreen.routeName: (_) => ListScreen(),
      },
    );
  }
}

class MainScreen extends StatefulWidget {
  static String routeName = '/';

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  PageController _pageController = PageController();
  List<Widget> _screens = [HomeWidget(), AddScreen(), ListScreen()];

  void _onPageChanged(int index) {}

  int selectedIndex = 0;

  // note: entry = list view but its misleading to call it list_view
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        toolbarHeight: -20,
      ),
      body: PageView(
        controller: _pageController,
        children: _screens,
        onPageChanged: _onPageChanged,
        physics: const NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Add',
          ),
          BottomNavigationBarItem(
            //TODO: change list icon when change to expanded LMAOOO
            icon: Icon(Icons.format_list_bulleted),
            label: 'List',
          ),
        ],
        currentIndex: selectedIndex,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
          _pageController.jumpToPage(index);
            //TODO: gestures
            // duration: const Duration(milliseconds: 300),
            // curve: Curves.linear,
        },
      ),
    );
  }
}
