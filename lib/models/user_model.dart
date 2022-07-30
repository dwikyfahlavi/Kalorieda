class MyUser {
  final String? email;
  final String? name;
  final String? phone;

  MyUser({this.email, this.name, this.phone});

  factory MyUser.fromFirestore(Map<String, dynamic> json) => MyUser(
        email: json["email"],
        name: json["name"],
        phone: json["phone"],
      );

  static Map<String, dynamic> toMap(MyUser user) => {
        "email": user.email,
        "name": user.name,
        "phone": user.phone,
      };
}
