import 'package:flutter/material.dart';
import 'package:jarlist/all_tags.dart';
import 'package:jarlist/models/tag.dart';
import 'package:jarlist/size_config.dart';
import 'package:multi_select_flutter/chip_display/multi_select_chip_display.dart';
import 'package:multi_select_flutter/chip_field/multi_select_chip_field.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:provider/provider.dart';

class TagDialog extends StatefulWidget {
  @override
  State<TagDialog> createState() => _TagDialogState();
}

class _TagDialogState extends State<TagDialog>
    with AutomaticKeepAliveClientMixin<TagDialog> {
  final _formKey2 = GlobalKey<FormState>();

  String tagName = '';
  MaterialColor tagColor = Colors.blue;
  List<Widget> tagWidgets = [];
  var _selected = false;

  //TODO: Make Dynamic
  // nothing is as permanent as a temporary solution
  List<bool> _isSelected = List.generate(
    50,
    (i) => false,
  );

  void saveTag(AllTags tagList) async {
    bool isValid = _formKey2.currentState!.validate();
    if (isValid) {
      _formKey2.currentState!.save();
      setState(() {
        tagList.addTag(
          tagName,
          tagColor as MaterialColor,
        );
        _formKey2.currentState!.reset();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Saved!'),
          duration: Duration(seconds: 1),
        ));
        print(tagList.getAllTags()[tagList.getAllTags().length - 1].name);
      });
    } else {
      FocusScope.of(context).unfocus();
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Please fill out all fields'),
        duration: Duration(seconds: 1),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    AllTags tagList = Provider.of<AllTags>(context);
    Widget filterChipDisplay(tagName, index) {
      print(tagList.getSelectedTags());
      //for loop to check if tag exists in getSelectedTags, if it does then it is selected
      for (var tag in tagList.getSelectedTags()) {
        if (tag['name'] == tagName) {
          _isSelected[index] = true;
        }
      }
      return FilterChip(
          selected: _isSelected[index],
          onSelected: (value) {
            setState(() {
              if (value) {
                tagList.addSelectedTags(tagName, value);
                print('added $tagName');
              } else {
                tagList.removeSelectedTags(tagName);
                print('removed $tagName');
              }
              _isSelected[index] = value;
            });
          },
          label: Text(tagName));
    }

    return Form(
      key: _formKey2,
      child: Dialog(
        //TODO: make the dialog curved
        child: Container(
          margin: const EdgeInsets.all(10),
          child: SizedBox(
            width: SizeConfig.blockSizeHorizontal * 60,
            height: SizeConfig.blockSizeVertical * 50,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Wrap(
                    direction: Axis.horizontal,
                    spacing: SizeConfig.safeBlockHorizontal * 2,
                    runSpacing: SizeConfig.safeBlockHorizontal * 2,
                    children: [
                      SizedBox(
                        height: SizeConfig.safeBlockVertical * 30,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return filterChipDisplay(
                                tagList.getAllTags()[index].name,
                                index /*tagList.getAllTags()[index].color as String*/);
                          },
                          itemCount: tagList.getAllTags().length,
                        ),
                      ),
                    ],
                  ),
                ),
                //textformfield for adding tags
                TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    isDense: true,
                    contentPadding: EdgeInsets.all(8),
                    hintText: 'Enter tag here',
                  ),
                  autovalidateMode: AutovalidateMode.always,
                  validator: (value) {
                    if (value == null) {
                      return 'Please enter a tag';
                    } else {
                      return null;
                    }
                  },
                  onSaved: (value) {
                    tagName = value!;
                  },
                ),
                //selector to select color of tag
                DropdownButtonFormField<String>(
                  value: null,
                  icon: Icon(Icons.arrow_downward),
                  onChanged: (value) {
                    setState(() {
                      //switch to set colors as string
                      switch (value) {
                        case 'Red':
                          tagColor = Colors.red;
                          saveTag(tagList);
                          break;
                        case 'Green':
                          tagColor = Colors.green;
                          break;
                        case 'Blue':
                          tagColor = Colors.blue;
                          break;
                        case 'Yellow':
                          tagColor = Colors.yellow;
                          break;
                        case 'Orange':
                          tagColor = Colors.orange;
                          break;
                        case 'Purple':
                          tagColor = Colors.purple;
                          break;
                        case 'Pink':
                          tagColor = Colors.pink;
                          break;
                        case 'Grey':
                          tagColor = Colors.grey;
                          break;
                        case 'Cyan':
                          tagColor = Colors.cyan;
                          break;
                      }
                      print(tagColor);
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Please select a color';
                    } else {
                      return null;
                    }
                  },
                  items: [
                    'Red',
                    'Orange',
                    'Yellow',
                    'Green',
                    'Blue',
                    'Purple',
                    'Grey',
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: OutlinedButton.icon(
                      //TODO: convert to chip and place above textformfield
                      label: Text('Add Tags'),
                      icon: Icon(Icons.add),
                      onPressed: () {
                        setState(() {
                          FocusScope.of(context).unfocus();
                          saveTag(tagList);
                        });
                      }),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      OutlinedButton.icon(
                          label: Text('Cancel'),
                          icon: Icon(Icons.cancel),
                          onPressed: () {
                            //TOOD: confirm with user to cancel
                            Navigator.of(context).pop();
                          }),
                      OutlinedButton.icon(
                          label: Text('Save'),
                          icon: Icon(Icons.cancel),
                          onPressed: () {
                            //TODO: add functionality to save tag
                            Navigator.of(context).pop();
                          }),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
