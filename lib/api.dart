import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:project2/constants.dart';
import 'package:project2/services/remote_services/refresh_token_service.dart';

class Api {
  var client = http.Client();
  final String _hostIP = "$kHostIP";
  final _getStorage = GetStorage();
  String get accessToken => _getStorage.read("access_token");
  String get refreshToken => _getStorage.read("refresh_token");

  Map<String, String> headers = {
    "accept": "application/json",
  };

  Future<String> getRequest(String endPoint, {bool auth = false, bool canRefresh = true}) async {
    var response = await client.get(
      Uri.parse("$_hostIP/$endPoint"),
      headers: !auth ? headers : {...headers, "authorization": "JWT $accessToken"},
    );
    if (canRefresh && response.statusCode == 401) {
      RefreshTokenService().refreshToken();
      return getRequest(endPoint, auth: auth);
    }
    return response.body;
  }

  Future<String> postRequest(
    String endPoint,
    Map<String, dynamic> body, {
    bool auth = false,
    bool canRefresh = true,
  }) async {
    var response = await client.post(
      Uri.parse("$_hostIP/$endPoint"),
      headers: !auth ? headers : {...headers, "authorization": "JWT $accessToken"},
      body: jsonEncode(body),
    );
    if (canRefresh && response.statusCode == 401) {
      RefreshTokenService().refreshToken();
      return postRequest(endPoint, body, auth: auth);
    }
    return response.body;
  }
}
