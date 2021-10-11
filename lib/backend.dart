import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class Backend {
  /// Send the input message to the Back4App DB entitled "Messages".
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

  /// Retrieve the messages in Back4App DB entitled "Messages".
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

  /// Retrieve the image list in Back4App DB given the gallery name.
  /// Note: the gallery name should only be one of ["origin", "fly", "life"].
  static Future<List<ParseObject>> getGalleryList(final String galleryName) async {
    QueryBuilder<ParseObject> queryPublisher =
    QueryBuilder<ParseObject>(ParseObject(galleryName))
      ..orderByAscending('createdAt');
    final ParseResponse apiResponse = await queryPublisher.query();

    if (apiResponse.success && apiResponse.results != null) {
      return apiResponse.results as List<ParseObject>;
    } else {
      return [];
    }
  }
}