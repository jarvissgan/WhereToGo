class User{
  String email;
  String id;
  String name;

  User({required this.email, required this.id, required this.name});

  User.fromMap(Map<String, dynamic> snapshot, String id) :
        email = snapshot['email'] ?? '',
        id = snapshot['id'] ?? '',
        name = snapshot['name'] ?? '';
}