import 'package:flutter/material.dart';

class Tag{
  String name;
  Tag({required this.name});

  Tag.fromMap(Map<String, dynamic> snapshot, String id) :
        name = snapshot['tagName'] ?? '';
}