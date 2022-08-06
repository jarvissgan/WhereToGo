import 'package:flutter/material.dart';
import 'package:jarlist/all_tags.dart';
import 'package:jarlist/models/tag.dart';
import 'package:jarlist/services/firestore_service.dart';
import 'package:jarlist/size_config.dart';
import 'package:provider/provider.dart';

class TagDialog extends StatefulWidget {
  @override
  State<TagDialog> createState() => _TagDialogState();
}

class _TagDialogState extends State<TagDialog>
    with AutomaticKeepAliveClientMixin<TagDialog> {
  final _formKey2 = GlobalKey<FormState>();

  String tagName = '';
  List<Widget> tagWidgets = [];
  var _selected = false;

  //TODO: Make Dynamic
  // nothing is as permanent as a temporary solution
  List<bool> _isSelected = List.generate(
    50,
    (i) => false,
  );

  FirestoreService fsService = FirestoreService();

  void saveTag() async {
    bool isValid = _formKey2.currentState!.validate();
    if (isValid) {
      _formKey2.currentState!.save();
      setState(() {
        // tagList.addTag(
        //   tagName,
        // );
        fsService.createTag(
          tagName,
        );

        _formKey2.currentState!.reset();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Saved!'),
          duration: Duration(seconds: 1),
        ));
        // print(tagList.getAllTags()[tagList.getAllTags().length - 1].name);
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
              } else {
                tagList.removeSelectedTags(tagName);
              }
              _isSelected[index] = value;
            });
          },
          label: Text(tagName));
    }

    return StreamBuilder<List<Tag>>(
      stream: fsService.getTags(),
      builder: (context, snapshot) {
        return Form(
          key: _formKey2,
          child: Dialog(
            //TODO: make the dialog curved
            child: Container(
              margin: const EdgeInsets.all(10),
              child: SizedBox(
                width: SizeConfig.blockSizeHorizontal * 60,
                height: SizeConfig.blockSizeVertical * 40,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
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
                                    snapshot.data![index].name,
                                    index /*tagList.getAllTags()[index].color as String*/);
                              },
                              itemCount: snapshot.data!.length,
                            ),
                          ),
                        ],
                      ),
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
                              saveTag();
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
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
