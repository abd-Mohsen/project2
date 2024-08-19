import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:project2/main.dart';

class RefreshTokenService {
  final GetStorage _getStorage = GetStorage();
  Future<void> refreshToken() async {
    Map<String, String> body = {
      "refresh": _getStorage.read("refresh_token"),
    };
    String? response = await api.postRequest("auth/jwt/refresh/", body, canRefresh: false);
    if (response == null) return;
    String accessToken = jsonDecode(response)["access"];
    _getStorage.write("access_token", accessToken);
  }
}
