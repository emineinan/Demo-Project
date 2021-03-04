class User {
  String username;
  String password;

  User.fromJson(Map json)
      : username = json['username'],
        password = json['password'];

  Map toJson() {
    return {'username': username, 'password': password};
  }
}
