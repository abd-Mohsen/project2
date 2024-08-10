import 'package:get_storage/get_storage.dart';

class ExamSelectionService {
  static const String _keySelectedExamId = 'selected_exam_id';
  final GetStorage _storage = GetStorage();

  void saveSelectedExamId(int examId) {
    _storage.write(_keySelectedExamId, examId);
  }

  int loadSelectedExamId() {
    return _storage.read<int?>(_keySelectedExamId) ?? -1;
  }

  void clearSelectedExamId() {
    _storage.remove(_keySelectedExamId);
  }
}
