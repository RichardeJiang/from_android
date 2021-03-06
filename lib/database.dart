// import 'dart:developer';
//
// import 'package:cloud_firestore/cloud_firestore.dart';
//
// final FirebaseFirestore _firestore = FirebaseFirestore.instance;
// final CollectionReference _mainCollection = _firestore.collection('Messages');
//
// class Database {
//   static String? userUid;
//
//   static Future<void> addNewMail({
//     required String mailSender,
//     required String mailContent
//   }) async {
//     final Map<String, dynamic> newMail = <String, dynamic>{
//       "name": mailSender,
//       "message": mailContent,
//       "date": DateTime.now().toString().substring(0, 10).replaceAll("-", ":"),
//     };
//     await _mainCollection.doc()
//         .set(newMail)
//         .whenComplete(() => log("Added new mail to database"))
//         .catchError((e) => log(e));
//   }
//
//   static Future<void> updateItem({
//     required String title,
//     required String description,
//     required String docId,
//   }) async {
//     DocumentReference documentReferencer =
//     _mainCollection.doc(userUid).collection('items').doc(docId);
//
//     Map<String, dynamic> data = <String, dynamic>{
//       "title": title,
//       "description": description,
//     };
//
//     await documentReferencer
//         .update(data)
//         .whenComplete(() => print("Note item updated in the database"))
//         .catchError((e) => print(e));
//   }
//
//   static Stream<QuerySnapshot> readAllMails() {
//     return _mainCollection.snapshots();
//   }
//
//   static Future<void> deleteItem({
//     required String docId,
//   }) async {
//     DocumentReference documentReferencer =
//     _mainCollection.doc(userUid).collection('items').doc(docId);
//
//     await documentReferencer
//         .delete()
//         .whenComplete(() => print('Note item deleted from the database'))
//         .catchError((e) => print(e));
//   }
// }