import 'dart:convert';

//todo: this model if from another app, take the new model
List<UserModel> userModelFromJson(String str) =>
    List<UserModel>.from(json.decode(str).map((x) => UserModel.fromJson(x)));

String userModelToJson(List<UserModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserModel {
  final int id;
  final String userName;
  final String email;
  final String phone;
  final String role;
  final UserModel? supervisor;
  final bool isVerified;

  UserModel({
    required this.id,
    required this.userName,
    required this.email,
    required this.phone,
    required this.role,
    required this.supervisor,
    required this.isVerified,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        userName: json["user_name"],
        email: json["email"],
        phone: json["phone"],
        role: json["role"],
        supervisor: json["supervisor"] != null ? UserModel.fromJson(json["supervisor"]) : null,
        isVerified: json["is_verified"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_name": userName,
        "email": email,
        "phone": phone,
        "role": role,
        "supervisor": supervisor!.toJson(),
        "is_verified": isVerified,
      };

  @override
  String toString() {
    return userName;
  }
}
