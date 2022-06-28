import 'package:flutter/material.dart';
import 'package:jarlist/widgets/home_screen/list_builder.dart';
import 'package:jarlist/widgets/home_screen/recommended_list.dart';

class HomeWidget extends StatefulWidget {
  static const String routeName = '/home';

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {

  List<String> items = List.generate(
    10,
        (i) => "List $i",
  );

  @override
  Widget build(BuildContext context) {
    return Column(
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
                        print(value);
                      },
                      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
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
                    // CircleAvatar(
                    //   backgroundColor: Colors.transparent,
                    //   radius: 20,
                    //   child: IconButton(
                    //     icon: Icon(Icons.settings, color: Colors.black,),
                    //     onPressed: () {
                    //     },
                    //   ),
                    // ),
                    // TextButton.icon(
                    //   onPressed: () {},
                    //   icon: Icon(Icons.settings),
                    //   label: Text(
                    //     "Settings",
                    //     style: TextStyle(
                    //         fontSize: 20,
                    //         fontWeight: FontWeight.normal,
                    //         color: Colors.black),
                    //   ),
                    // ),
                  ],
                ))),
        ListBuilder(items),
        Spacer(),
        RecommendedList(),
      ],
    );
  }
}