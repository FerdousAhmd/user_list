
class UserModel {
  final String name;
  final String email;
  final String picture;

  UserModel({
    required this.name,
    required this.email,
    required this.picture,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name']['first'] + ' ' + json['name']['last'],
      email: json['email'],
      picture: json['picture']['large'],
    );
  }
}
