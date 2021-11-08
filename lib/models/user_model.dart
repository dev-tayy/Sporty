class UserModel {
  UserModel({
    this.id,
    this.email,
    this.phoneNumber,
    this.username,
    this.interests,
    this.createdAt,
    this.updatedAt,
    this.avatar,
  });

  String? id;
  String? username;
  String? email;
  String? phoneNumber;
  List<String>? interests;
  String? createdAt;
  String? updatedAt;
  String? avatar;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"] == null ? null : json["id"],
        email: json["email"] == null ? null : json["email"],
        phoneNumber: json["phoneNumber"] == null ? null : json["phoneNumber"],
        interests: List<String>.from(json["interests"].map((x) => x)),
        username: json["username"] == null ? null : json["username"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "email": email == null ? null : email,
        "phoneNumber": phoneNumber == null ? null : phoneNumber,
        "interests": List<dynamic>.from(interests!.map((x) => x)),
        "username": username == null ? null : username,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
      };
}
