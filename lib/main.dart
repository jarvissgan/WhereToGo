import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jarlist/all_entries.dart';
import 'package:jarlist/all_list.dart';
import 'package:jarlist/all_tags.dart';
import 'package:jarlist/screens/entry_view.dart';
import 'package:jarlist/screens/add_screen.dart';
import 'package:jarlist/screens/login_screen.dart';
import 'package:jarlist/screens/home_screen.dart';
import 'package:jarlist/screens/register_screen.dart';
import 'package:jarlist/screens/settings_screen.dart';
import 'package:jarlist/services/firestore_service.dart';
import 'package:provider/provider.dart';

import 'services/auth_service.dart';
import 'screens/list_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(MyApp());

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
}

class MyApp extends StatelessWidget {
  AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        //listens for changes in Entry class
        ChangeNotifierProvider<AllEntries>(
          create: (context) => AllEntries(),
        ),
        //listens for changes in AllTags class
        ChangeNotifierProvider<AllTags>(
          create: (context) => AllTags(),
        ),
        ChangeNotifierProvider<AllLists>(
          create: (context) => AllLists(),
        )
      ],
      child: FutureBuilder(
          future: Firebase.initializeApp(),
          builder: (context, snapshot) => snapshot.connectionState == ConnectionState.waiting ? Center(child: CircularProgressIndicator()) :
              StreamBuilder<User?>(
              stream: authService.getAuthUser(),
              builder: (context, snapshot) {
                // FirestoreService firestoreService = FirestoreService();
                // FirestoreService.uid = snapshot.data!.uid;

                return MaterialApp(
                  theme: ThemeData(
                    brightness: Brightness.light,
                    //TODO: dark mode (change text color)
                  ),
                  home: snapshot.connectionState == ConnectionState.waiting ? Center(child: CircularProgressIndicator()) :
                      snapshot.hasData ? MainScreen() : LoginScreen(),
                    // LoginScreen(),
                  // initialRoute: HomeWidget.routeName,
                  routes: {
                    ListScreen.routeName: (_) => ListScreen(),
                    EntryView.routeName: (_) => EntryView(),
                    MainScreen.routeName: (_) => MainScreen(),
                    SettingsScreen.routeName: (_) => SettingsScreen(),
                    LoginScreen.routeName: (_) => LoginScreen(),
                    RegisterScreen.routeName: (_) => RegisterScreen(),

                  },
                );
              })),
    );
  }
}

class MainScreen extends StatefulWidget {
  static String routeName = '/home';

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
    AllEntries placeList = Provider.of<AllEntries>(context);

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
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
              _pageController.jumpToPage(index);
            });
            //TODO: gestures
            // duration: const Duration(milliseconds: 300),
            // curve: Curves.linear,
          },
        ),
      ),
    );
  }
}
