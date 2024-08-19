import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:project2/main.dart';

class RefreshTokenService {
  Future<void> refreshToken() async {
    String? response = await api.getRequest("auth/jwt/refresh/");
    if (response == null) return;
    String accessToken = jsonDecode(response)["access"];
    GetStorage().write("access_token", accessToken);
  }
}
