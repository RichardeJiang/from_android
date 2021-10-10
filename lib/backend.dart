import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class Backend {
  static Future<void> addNewMail({
    required String mailSender,
    required String mailContent
  }) async {
    final newMail = ParseObject('Messages')
        ..set('name', mailSender)
        ..set('message', mailContent)
        ..set('date', DateTime.now()
            .toString()
            .substring(0, 10)
            .replaceAll("-", ":"));
    await newMail.save();
  }

  static Future<List<ParseObject>> readAllMails() async {
    QueryBuilder<ParseObject> queryTodo =
      QueryBuilder<ParseObject>(ParseObject('Messages'));
    final ParseResponse apiResponse = await queryTodo.query();

    if (apiResponse.success && apiResponse.results != null) {
      return apiResponse.results as List<ParseObject>;
    } else {
      return [];
    }
  }
}