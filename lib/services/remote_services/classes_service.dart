import 'package:project2/models/class_model.dart';
import '../../main.dart';

class ClassesService {
  //
  Future<List<ClassModel>?> getAllClasses() async {
    String? json = await api.getRequest("api/classes", auth: true);
    if (json == null) return null;
    return classModelFromJson(json);
  }
}
