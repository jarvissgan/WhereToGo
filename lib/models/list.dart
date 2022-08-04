
class Lists{
  String id, listName;
  Lists({required this.id ,required this.listName});

  Lists.fromMap(Map<String, dynamic> snapshot, String id) :
    id = id,
    listName = snapshot['listName'];
}