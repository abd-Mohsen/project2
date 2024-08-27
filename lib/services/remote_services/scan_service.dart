import 'dart:convert';

import 'package:camera/camera.dart';

import '../../main.dart';

class ScanService {
  Future<int?> scanPaper(XFile imageFile, int examID) async {
    Map<String, String> body = {"exam_id": examID.toString()};
    String? json = await api.postRequestWithImage("api/images/", imageFile, body, auth: true);
    if (json == null) return null;
    return jsonDecode(json)["mark"];

    //todo: returning "200 ok" with mark 0 if paper is not aligned correctly
  }
}
