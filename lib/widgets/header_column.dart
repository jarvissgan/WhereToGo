import 'dart:ui';

import 'package:flutter/material.dart';

class HeaderColumn extends StatefulWidget {
  @override
  State<HeaderColumn> createState() => _HeaderColumnState();
}

class _HeaderColumnState extends State<HeaderColumn> {
  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.horizontal,
      children: [
        Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                      margin: const EdgeInsets.only(top: 15, left: 40),
                      child: const Text("JarList", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black),))),
            ]),
      ],
    );
  }
}
