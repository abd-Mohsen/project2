import 'package:project2/models/marking_scheme_model.dart';
import '../../main.dart';

class MarkingSchemeDeletionService {
  Future<bool> deleteMarkingScheme(MarkingSchemeModel markingScheme) async {
    return await api.deleteRequest("api/questionsExamForms/${markingScheme.id}/", auth: true);
  }
}
