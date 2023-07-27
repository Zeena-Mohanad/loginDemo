class User {
  final String email;
  final String userName;
  final String password;

  User({
    this.email = '',
    this.userName = '',
    this.password = '',
  });

  factory User.json(Map<String, dynamic> json) {
    return User(
      email: json['email'],
      userName: json['userName'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['email'] = this.email;
    data['userName'] = this.userName;
    data['password'] = this.password;
    return data;
  }
}
