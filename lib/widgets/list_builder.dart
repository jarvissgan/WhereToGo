import 'package:flutter/material.dart';
import 'package:jarlist/all_places.dart';
import 'package:jarlist/all_tags.dart';
import 'package:jarlist/alll_entry.dart';
import 'package:provider/provider.dart';

class ListBuilder extends StatefulWidget {
  List<String> items = List.generate(
    50,
    (i) => "List $i",
  );

  ListBuilder(this.items);

  @override
  State<ListBuilder> createState() => _ListBuilderState();
}


class _ListBuilderState extends State<ListBuilder> {
  final _formKey = GlobalKey<FormState>();
  String listName = '';
  List<AllTags> tagList = [];
  List<AllEntries> entryList = [];

  void saveForm(AllLists listList) async {
    bool isValid = _formKey.currentState!.validate();

    if (isValid) {
      _formKey.currentState!.save();
      print(listName);
      setState(() {
        listList.addList(
          listName,
          entryList,
          tagList,
        );
        Navigator.of(context).pop();
        _formKey.currentState!.reset();
        listName = '';
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Saved!'),
          duration: Duration(seconds: 1),
        ));

      });

    } else{
      print("invalid");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Please enter a name for your list'),
        duration: Duration(seconds: 1),
      ));
    }

  }

  @override
  Widget build(BuildContext context) {
    AllLists listList = Provider.of<AllLists>(context);

    // SizeConfig().init(context);
    return Flex(
      direction: Axis.vertical,
      children: [
        Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                      margin: const EdgeInsets.only(top: 15, left: 40),
                      child: const Text(
                    "Lists:",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                        color: Colors.black),
                  ))),
              ListView.builder(
                  //makes container unscrollable
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (cxt, i) {
                    return ListTile(
                      title: Align(
                          //aligns buttons to left
                          alignment: Alignment.centerLeft,
                          child: Container(
                              margin: const EdgeInsets.only(top: 10, left: 0),
                              child: TextButton(
                                  //todo: include onPressed
                                  onPressed: () {},
                                  child: Text(listList.getAllLists()[i].listName)),
                              padding: EdgeInsets.only(left: 10))),
                    );
                  },
                  //tells the listview how many items to display
                  itemCount: listList.getAllLists().length),
              //adds a create button
              //TODO: route to create list page
              Expanded(
                flex: 0,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.only(top: 15, left: 25),
                    child: TextButton.icon(
                        onPressed: () {
                          //dialog to create list
                          showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                    title: const Text('Create list'),
                                    content: Form(
                                      key: _formKey,
                                      child: TextFormField(
                                        controller: TextEditingController(
                                            text: listName),
                                        validator: (value) {
                                          print(value);
                                          if (value == null || value == "") {
                                            return 'Please enter some text';
                                          }
                                          return null;
                                        },
                                        onSaved: (value) {
                                          setState(() {
                                            listName = value!;
                                          });
                                        },
                                        decoration: InputDecoration(
                                          hintText: 'List name',
                                        ),
                                      ),
                                    ),
                                    actions: <Widget>[
                                      FlatButton(
                                        child: const Text('Cancel'),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                      FlatButton(
                                        child: const Text('Create'),
                                        onPressed: () {
                                          setState(() {
                                            //TODO: check for duplicate
                                            saveForm(listList);
                                          });
                                        },
                                      ),
                                    ],
                                  ));
                        },
                        icon: Icon(Icons.add),
                        label: Text("Create New List")),
                  ),
                ),
              ),
            ]),
      ],
    );
  }
}
