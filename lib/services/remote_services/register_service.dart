import 'dart:convert';

import 'package:get_storage/get_storage.dart';

import '../../main.dart';

class RegisterService {
  final GetStorage _getStorage = GetStorage();

  Future<bool> register(String username, String email, String password, int roleID) async {
    Map<String, String> body = {
      "username": username,
      "email": email,
      "password": password,
      "role_id": roleID.toString(),
    };
    String? json = await api.postRequest("auth/users/", body, canRefresh: false);
    if (json == null) return false;
    Map<String, dynamic> response = jsonDecode(json);
    _getStorage.write("access_token", response["token"]["access"]);
    _getStorage.write("refresh_token", response["token"]["refresh"]);
    return true;
  }
}
