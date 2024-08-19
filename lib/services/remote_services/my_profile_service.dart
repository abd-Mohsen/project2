import 'dart:convert';

import '../../main.dart';
import '../../models/user_model.dart';

class MyProfileService {
  Future<UserModel?> getCurrentUser() async {
    String? json = await api.getRequest("auth/users/me", auth: true);
    if (json == null) return null;
    return UserModel.fromJson(jsonDecode(json));
  }
}
