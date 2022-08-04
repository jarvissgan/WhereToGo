
class Lists{
  String listName;
  Lists({required this.listName});

  Lists.fromMap(Map<String, dynamic> snapshot, String id) :
        listName = snapshot['listName'] ?? '';
}