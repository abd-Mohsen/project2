import 'dart:async';
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
    "Accept": "application/json",
    "content-type": "application/json",
  };

  Future<String?> getRequest(String endPoint, {bool auth = false, bool canRefresh = true}) async {
    try {
      var response = await client
          .get(
            Uri.parse("$_hostIP/$endPoint"),
            headers: !auth ? headers : {...headers, "Authorization": "JWT $accessToken"},
          )
          .timeout(kTimeOutDuration2);

      if (canRefresh && response.statusCode == 401) {
        RefreshTokenService().refreshToken();
        return getRequest(endPoint, auth: auth);
      }
      print(response.body + "===========" + response.statusCode.toString());
      return response.statusCode == 200 ? response.body : null;
    } on TimeoutException {
      kTimeOutDialog();
      return null;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<String?> postRequest(
    String endPoint,
    Map<String, String> body, {
    bool auth = false,
    bool canRefresh = true,
  }) async {
    try {
      var response = await client
          .post(
            Uri.parse("$_hostIP/$endPoint"),
            headers: !auth
                ? headers
                : {
                    ...headers,
                    "Authorization": "JWT $accessToken",
                  },
            body: jsonEncode(body),
          )
          .timeout(kTimeOutDuration2);
      if (canRefresh && response.statusCode == 401) {
        RefreshTokenService().refreshToken();
        return postRequest(endPoint, body, auth: auth, canRefresh: false);
      }
      print(response.body);
      return (response.statusCode == 200 || response.statusCode == 201) ? response.body : null;
    } on TimeoutException {
      kTimeOutDialog();
      return null;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
