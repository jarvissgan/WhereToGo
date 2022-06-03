import 'package:flutter/material.dart';
import 'package:jarlist/widgets/header_column.dart';
import 'package:jarlist/widgets/list_builder.dart';
import 'package:jarlist/widgets/recommended_list.dart';

class HomeWidget extends StatelessWidget {
  List<String> items = List.generate(
    10,
        (i) => "List $i",
  );
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HeaderColumn(),
        ListBuilder(items),
        RecommendedList(),
      ],
    );
  }
}
