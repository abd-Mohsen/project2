import 'dart:convert';

import 'package:get_storage/get_storage.dart';

import '../../main.dart';

class LogoutService {
  final GetStorage _getStorage = GetStorage();

  Future<bool> logout() async {
    String? json = await api.postRequest("auth/logout/", {}, auth: true);
    if (json == null) return false;
    _getStorage.remove("access_token");
    _getStorage.remove("refresh_token");
    return true;
  }
}
