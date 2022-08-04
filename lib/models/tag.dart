import 'package:flutter/material.dart';

class Tag{
  String name;
  MaterialColor color;
  Tag({required this.name, required this.color});

  Tag.fromMap(Map<String, dynamic> snapshot, String id) :
        name = snapshot['name'] ?? '',
        color = snapshot['color'] ?? '';
}