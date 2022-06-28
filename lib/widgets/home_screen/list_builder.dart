import 'package:flutter/material.dart';
import 'package:jarlist/all_places.dart';
import 'package:jarlist/alll_entry.dart';
import 'package:jarlist/size_config.dart';

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

  void saveForm(AllLists listList) async {
    bool isValid = _formKey.currentState!.validate();

    if (isValid) {
      _formKey.currentState!.save();
      print(listName);
      setState(() {
        listList.addList(
          listName,
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
    AllEntries placeList = Provider.of<AllEntries>(context);

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
                              width: SizeConfig.blockSizeHorizontal * 80,
                              margin: const EdgeInsets.only(top: 10, left: 15),
                              child: Card(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: TextButton(
                                        //todo: include onPressed
                                          onPressed: () {},
                                          child: Text(listList.getAllLists()[i].listName)),
                                    ),
                                    //delete button
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: IconButton(
                                          onPressed: () {
                                            setState(() {
                                              //removes entries with that list name
                                              placeList.removePlace(listList.getAllLists()[i].listName);
                                              listList.removeList(listList.getAllLists()[i].listName);


                                              //show snackbar
                                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                                content: Text('Deleted!'),
                                                duration: Duration(seconds: 1),
                                              ));
                                            });
                                          },
                                          icon: Icon(Icons.delete)),
                                    ),
                                  ],
                                ),
                              ),
                              padding: EdgeInsets.only(left: 10))),
                    );
                  },
                  //tells the listview how many items to display
                  itemCount: listList.getAllLists().length),
              //adds a create button
              //TODO: route to create list page
              if(listList.getAllLists().length < 7)
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
                                        } else {
                                          //checks if list name already exists
                                          for(var list in listList.getAllLists()){
                                            if(list.listName == value){
                                              return 'List already exists';
                                            }
                                          }
                                          return null;
                                        }
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
                                    TextButton(
                                      child: const Text('Cancel'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    TextButton(
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
