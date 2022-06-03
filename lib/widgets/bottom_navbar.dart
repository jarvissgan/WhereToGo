import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    //todo: check if working
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: 50,
      ),
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.home)),
                Tab(icon: Icon(Icons.format_list_bulleted)),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              Center(child: Text('Home')),
              Center(child: Text('List')),
            ],
          ),
        ),
      ),
    );
  }
}
