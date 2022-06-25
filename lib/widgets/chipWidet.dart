import 'package:flutter/material.dart';
import 'package:jarlist/all_tags.dart';
import 'package:provider/provider.dart';

class filterChipGenerate extends StatefulWidget {
  const filterChipGenerate({Key? key}) : super(key: key);

  @override
  State<filterChipGenerate> createState() => _filterChipGenerateState();
}

class _filterChipGenerateState extends State<filterChipGenerate> {

  var _selected = false;
  @override
  Widget build(BuildContext context) {
    AllTags tagList = Provider.of<AllTags>(context);

    return FilterChip(
        selected: _selected,
        onSelected: (value) {
          setState(() {
            _selected = value;
            print(_selected);
          });
        },
        label: Text(tagList.getAllTags()[0].name));
  }
}
