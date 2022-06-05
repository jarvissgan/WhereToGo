import 'package:flutter/material.dart';
import 'package:jarlist/widgets/header_column.dart';
import 'package:jarlist/widgets/list_builder.dart';
import 'package:jarlist/widgets/recommended_list.dart';

class HomeWidgetTest extends StatefulWidget {
  @override
  State<HomeWidgetTest> createState() => _HomeWidgetTestState();
}

class _HomeWidgetTestState extends State<HomeWidgetTest> {
  List<String> items = List.generate(
    3,
        (i) => "List $i",
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListBuilder(items),
        RecommendedList(),
      ],
    );
  }
}
