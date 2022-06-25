import 'package:flutter/material.dart';
import 'package:jarlist/all_tags.dart';
import 'package:jarlist/size_config.dart';
import 'package:jarlist/widgets/tag_dialog.dart';
import 'package:provider/provider.dart';

import '../models/tag.dart';

class TagListView extends StatefulWidget {

  @override
  State<TagListView> createState() => _TagListViewState();
}

class _TagListViewState extends State<TagListView> {
  @override
  Widget build(BuildContext context) {
    AllTags tagList = Provider.of<AllTags>(context);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AllTags>(
          create: (context) => AllTags(),
        ),
      ],
      child: Expanded(
        child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
          //TAGS
          //TODO: add horizontal listview of tags, and make it tappable
          //TODO: add tag dialog box, and scroll list of existing tags


          // SizedBox(
          //   width: SizeConfig.blockSizeHorizontal * 40,
          //   height: SizeConfig.blockSizeVertical * 20,
          //   child: ListView.builder(
          //     shrinkWrap: true,
          //       scrollDirection: Axis.horizontal,
          //       itemCount: tagList.getAllTags().length,
          //       itemBuilder: (context, index) => Wrap(
          //           direction: Axis.horizontal,
          //           spacing: 6,
          //           runSpacing: 6,
          //           children: [
          //
          //             InputChip(
          //               label: Text(
          //                 tagList.getAllTags()[index].name,
          //                 style: TextStyle(
          //                   fontSize: SizeConfig.blockSizeHorizontal * 5,
          //                 ),
          //               ),
          //             ),
          //           ])),
          // ),

        ]),
      ),
    );
  }
}
