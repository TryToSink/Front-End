class User {
  late String id;
  late String name;
  late String username;
  late String email;
  late List<Amigos> amigos;

  User({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.amigos,
  });

  User.fromJson(Map<String, dynamic> json) {
    var friendList = json['amigos'] as List;
    List<Amigos> amigos = friendList.map((i) => Amigos.fromJson(i)).toList();
    id = json['id'];
    name = json['name'];
    username = json['username'];
    email = json['email'];
    if (json['amigos'] != null) {
      amigos = [];
      json['amigos'].forEach((i) {
        friendList.add(Amigos.fromJson(i));
      });
    }
  }
}

class Amigos {
  String friendId;
  String friendName;
  String online;
  String friendUsername;
  String friendFoto;

  Amigos({
    required this.friendId,
    required this.friendName,
    required this.online,
    required this.friendUsername,
    required this.friendFoto,
  });

  factory Amigos.fromJson(Map<String, dynamic> json) {
    return Amigos(
      friendId: json['id'],
      friendName: json['name'],
      online: json['online'],
      friendUsername: json['username'],
      friendFoto: json['foto'],
    );
  }
}
