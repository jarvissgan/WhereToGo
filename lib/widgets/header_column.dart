import 'dart:ui';

import 'package:flutter/material.dart';

class HeaderColumn extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Container(
              margin: const EdgeInsets.only(top: 15, left: 40),
              child: const Text(
                'JarList',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Container(
              margin: const EdgeInsets.only(left: 40),
              child: const Text(
                'Your Lists:',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
      // padding: EdgeInsets.all(40.0),
      alignment: Alignment.topLeft,
    );
  }
}
