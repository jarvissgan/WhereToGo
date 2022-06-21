import 'package:flutter/material.dart';
import 'package:jarlist/all_tags.dart';
import 'package:jarlist/size_config.dart';
import 'package:provider/provider.dart';

class TagDialog extends StatefulWidget {
  @override
  State<TagDialog> createState() => _TagDialogState();
}

class _TagDialogState extends State<TagDialog> {
  final _formKey2 = GlobalKey<FormState>();

  String tagName = '';
  String tagColor = '';

  void saveTag(AllTags tagList) async {
    bool isValid = _formKey2.currentState!.validate();
    if (isValid) {
      _formKey2.currentState!.save();
      setState(() {
        tagList.addTag(tagName, tagColor);
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

    return Form(
      key: _formKey2,
      child: Dialog(
        //TODO: make the dialog curved
        child: Container(
          margin: const EdgeInsets.all(10),
          child: SizedBox(
            width: SizeConfig.blockSizeHorizontal * 60,
            height: SizeConfig.blockSizeVertical * 30,
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
                //selector to select color of tag
                DropdownButtonFormField<String>(
                  value: null,
                  icon: Icon(Icons.arrow_downward),
                  onChanged: (value) {
                    setState(() {
                      tagColor = value!;
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
                    'Black',
                    'White'
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
        // actions: <Widget>[
        //   ElevatedButton(
        //     child: const Text('Cancel'),
        //     onPressed: () {
        //       Navigator.pop(context);
        //     },
        //   ),
        //   ElevatedButton(
        //     child: const Text('Add'),
        //     onPressed: () {
        //       Navigator.pop(context);
        //     },
        //   ),
        // ],
      ),
    );
  }
}
