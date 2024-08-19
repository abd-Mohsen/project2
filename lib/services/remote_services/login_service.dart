//
import 'dart:convert';

import 'package:get_storage/get_storage.dart';

import '../../main.dart';

class LoginService {
  final GetStorage _getStorage = GetStorage();

  Future<bool> login(username, password) async {
    Map<String, String> body = {
      "username": username,
      "password": password,
    };
    String? json = await api.postRequest("auth/login", body, canRefresh: false);
    if (json == null) return false;
    Map<String, dynamic> response = jsonDecode(json);
    _getStorage.write("access_token", response["access"]);
    _getStorage.write("refresh_token", response["refresh"]);
    return true;
  }
}
