// import 'dart:async';
// import 'dart:io';
//
// import 'package:flutter/material.dart';
//
// class Chat extends StatelessWidget {
//   final String peerId;
//   final String peerAvatar;
//
//   Chat({Key? key, required this.peerId, required this.peerAvatar}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           '致孩子们：',
//           style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//         ),
//         centerTitle: true,
//       ),
//       body: ChatScreen(
//         peerId: peerId,
//         peerAvatar: peerAvatar,
//       ),
//     );
//   }
// }
//
// class ChatScreen extends StatefulWidget {
//   final String peerId;
//   final String peerAvatar;
//
//   ChatScreen({Key? key, required this.peerId, required this.peerAvatar}) : super(key: key);
//
//   @override
//   State createState() => ChatScreenState(peerId: peerId, peerAvatar: peerAvatar);
// }
//
// class ChatScreenState extends State<ChatScreen> {
//   ChatScreenState({Key? key, required this.peerId, required this.peerAvatar});
//
//   String peerId;
//   String peerAvatar;
//   String? id;
//
//   List<QueryDocumentSnapshot> listMessage = new List.from([]);
//   int _limit = 20;
//   int _limitIncrement = 20;
//   String groupChatId = "";
//   SharedPreferences? prefs;
//
//   File? imageFile;
//   bool isLoading = false;
//   bool isShowSticker = false;
//   String imageUrl = "";
//
//   final TextEditingController textEditingController = TextEditingController();
//   final ScrollController listScrollController = ScrollController();
//   final FocusNode focusNode = FocusNode();
//
//   _scrollListener() {
//     if (listScrollController.offset >= listScrollController.position.maxScrollExtent &&
//         !listScrollController.position.outOfRange) {
//       setState(() {
//         _limit += _limitIncrement;
//       });
//     }
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     focusNode.addListener(onFocusChange);
//     listScrollController.addListener(_scrollListener);
//     readLocal();
//   }
//
//   void onFocusChange() {
//     if (focusNode.hasFocus) {
//       // Hide sticker when keyboard appear
//       setState(() {
//         isShowSticker = false;
//       });
//     }
//   }
//
//   readLocal() async {
//     prefs = await SharedPreferences.getInstance();
//     id = prefs?.getString('id') ?? '';
//     if (id.hashCode <= peerId.hashCode) {
//       groupChatId = '$id-$peerId';
//     } else {
//       groupChatId = '$peerId-$id';
//     }
//
//     FirebaseFirestore.instance.collection('users').doc(id).update({'chattingWith': peerId});
//
//     setState(() {});
//   }
//
//   Future getImage() async {
//     ImagePicker imagePicker = ImagePicker();
//     PickedFile? pickedFile;
//
//     pickedFile = await imagePicker.getImage(source: ImageSource.gallery);
//     if (pickedFile != null) {
//       imageFile = File(pickedFile.path);
//       if (imageFile != null) {
//         setState(() {
//           isLoading = true;
//         });
//         uploadFile();
//       }
//     }
//   }
//
//   void getSticker() {
//     // Hide keyboard when sticker appear
//     focusNode.unfocus();
//     setState(() {
//       isShowSticker = !isShowSticker;
//     });
//   }
//
//   Future uploadFile() async {
//     String fileName = DateTime.now().millisecondsSinceEpoch.toString();
//     Reference reference = FirebaseStorage.instance.ref().child(fileName);
//     UploadTask uploadTask = reference.putFile(imageFile!);
//
//     try {
//       TaskSnapshot snapshot = await uploadTask;
//       imageUrl = await snapshot.ref.getDownloadURL();
//       setState(() {
//         isLoading = false;
//         onSendMessage(imageUrl, 1);
//       });
//     } on FirebaseException catch (e) {
//       setState(() {
//         isLoading = false;
//       });
//       Fluttertoast.showToast(msg: e.message ?? e.toString());
//     }
//   }
//
//   void onSendMessage(String content, int type) {
//     // type: 0 = text, 1 = image, 2 = sticker
//     if (content.trim() != '') {
//       textEditingController.clear();
//
//       var documentReference = FirebaseFirestore.instance
//           .collection('messages')
//           .doc(groupChatId)
//           .collection(groupChatId)
//           .doc(DateTime.now().millisecondsSinceEpoch.toString());
//
//       FirebaseFirestore.instance.runTransaction((transaction) async {
//         transaction.set(
//           documentReference,
//           {
//             'idFrom': id,
//             'idTo': peerId,
//             'timestamp': DateTime.now().millisecondsSinceEpoch.toString(),
//             'content': content,
//             'type': type
//           },
//         );
//       });
//       listScrollController.animateTo(0.0, duration: Duration(milliseconds: 300), curve: Curves.easeOut);
//     } else {
//       Fluttertoast.showToast(msg: 'Nothing to send', backgroundColor: Colors.black, textColor: Colors.red);
//     }
//   }
//
//   Widget buildItem(int index, DocumentSnapshot? document) {
//     if (document != null) {
//       if (document.get('idFrom') == id) {
//         // Right (my message)
//       //   return Row(
//       //     children: <Widget>[
//       //       document.get('type') == 0
//       //       // Text
//       //           ? Container(
//       //         child: Text(
//       //           document.get('content'),
//       //           style: TextStyle(color: primaryColor),
//       //         ),
//       //         padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
//       //         width: 200.0,
//       //         decoration: BoxDecoration(color: greyColor2, borderRadius: BorderRadius.circular(8.0)),
//       //         margin: EdgeInsets.only(bottom: isLastMessageRight(index) ? 20.0 : 10.0, right: 10.0),
//       //       )
//       //           : document.get('type') == 1
//       //       // Image
//       //           ? Container(
//       //         child: OutlinedButton(
//       //           child: Material(
//       //             child: Image.network(
//       //               document.get("content"),
//       //               loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
//       //                 if (loadingProgress == null) return child;
//       //                 return Container(
//       //                   decoration: BoxDecoration(
//       //                     color: greyColor2,
//       //                     borderRadius: BorderRadius.all(
//       //                       Radius.circular(8.0),
//       //                     ),
//       //                   ),
//       //                   width: 200.0,
//       //                   height: 200.0,
//       //                   child: Center(
//       //                     child: CircularProgressIndicator(
//       //                       color: primaryColor,
//       //                       value: loadingProgress.expectedTotalBytes != null &&
//       //                           loadingProgress.expectedTotalBytes != null
//       //                           ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
//       //                           : null,
//       //                     ),
//       //                   ),
//       //                 );
//       //               },
//       //               errorBuilder: (context, object, stackTrace) {
//       //                 return Material(
//       //                   child: Image.asset(
//       //                     'images/img_not_available.jpeg',
//       //                     width: 200.0,
//       //                     height: 200.0,
//       //                     fit: BoxFit.cover,
//       //                   ),
//       //                   borderRadius: BorderRadius.all(
//       //                     Radius.circular(8.0),
//       //                   ),
//       //                   clipBehavior: Clip.hardEdge,
//       //                 );
//       //               },
//       //               width: 200.0,
//       //               height: 200.0,
//       //               fit: BoxFit.cover,
//       //             ),
//       //             borderRadius: BorderRadius.all(Radius.circular(8.0)),
//       //             clipBehavior: Clip.hardEdge,
//       //           ),
//       //           onPressed: () {
//       //             Navigator.push(
//       //               context,
//       //               MaterialPageRoute(
//       //                 builder: (context) => FullPhoto(
//       //                   url: document.get('content'),
//       //                 ),
//       //               ),
//       //             );
//       //           },
//       //           style: ButtonStyle(padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(0))),
//       //         ),
//       //         margin: EdgeInsets.only(bottom: isLastMessageRight(index) ? 20.0 : 10.0, right: 10.0),
//       //       )
//       //       // Sticker
//       //           : Container(
//       //         child: Image.asset(
//       //           'images/${document.get('content')}.gif',
//       //           width: 100.0,
//       //           height: 100.0,
//       //           fit: BoxFit.cover,
//       //         ),
//       //         margin: EdgeInsets.only(bottom: isLastMessageRight(index) ? 20.0 : 10.0, right: 10.0),
//       //       ),
//       //     ],
//       //     mainAxisAlignment: MainAxisAlignment.end,
//       //   );
//       // } else {
//         // Left (peer message)
//         return Container(
//           child: Column(
//             children: <Widget>[
//               Row(
//                 children: <Widget>[
//                   isLastMessageLeft(index)
//                       ? Material(
//                     child: Image.network(
//                       peerAvatar,
//                       loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
//                         if (loadingProgress == null) return child;
//                         return Center(
//                           child: CircularProgressIndicator(
//                             color: primaryColor,
//                             value: loadingProgress.expectedTotalBytes != null &&
//                                 loadingProgress.expectedTotalBytes != null
//                                 ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
//                                 : null,
//                           ),
//                         );
//                       },
//                       errorBuilder: (context, object, stackTrace) {
//                         return Icon(
//                           Icons.account_circle,
//                           size: 35,
//                           color: greyColor,
//                         );
//                       },
//                       width: 35,
//                       height: 35,
//                       fit: BoxFit.cover,
//                     ),
//                     borderRadius: BorderRadius.all(
//                       Radius.circular(18.0),
//                     ),
//                     clipBehavior: Clip.hardEdge,
//                   )
//                       : Container(width: 35.0),
//                   document.get('type') == 0
//                       ? Container(
//                     child: Text(
//                       document.get('content'),
//                       style: TextStyle(color: Colors.white),
//                     ),
//                     padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
//                     width: 200.0,
//                     decoration: BoxDecoration(color: primaryColor, borderRadius: BorderRadius.circular(8.0)),
//                     margin: EdgeInsets.only(left: 10.0),
//                   )
//                       : document.get('type') == 1
//                       ? Container(
//                     child: TextButton(
//                       child: Material(
//                         child: Image.network(
//                           document.get('content'),
//                           loadingBuilder:
//                               (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
//                             if (loadingProgress == null) return child;
//                             return Container(
//                               decoration: BoxDecoration(
//                                 color: greyColor2,
//                                 borderRadius: BorderRadius.all(
//                                   Radius.circular(8.0),
//                                 ),
//                               ),
//                               width: 200.0,
//                               height: 200.0,
//                               child: Center(
//                                 child: CircularProgressIndicator(
//                                   color: primaryColor,
//                                   value: loadingProgress.expectedTotalBytes != null &&
//                                       loadingProgress.expectedTotalBytes != null
//                                       ? loadingProgress.cumulativeBytesLoaded /
//                                       loadingProgress.expectedTotalBytes!
//                                       : null,
//                                 ),
//                               ),
//                             );
//                           },
//                           errorBuilder: (context, object, stackTrace) => Material(
//                             child: Image.asset(
//                               'images/img_not_available.jpeg',
//                               width: 200.0,
//                               height: 200.0,
//                               fit: BoxFit.cover,
//                             ),
//                             borderRadius: BorderRadius.all(
//                               Radius.circular(8.0),
//                             ),
//                             clipBehavior: Clip.hardEdge,
//                           ),
//                           width: 200.0,
//                           height: 200.0,
//                           fit: BoxFit.cover,
//                         ),
//                         borderRadius: BorderRadius.all(Radius.circular(8.0)),
//                         clipBehavior: Clip.hardEdge,
//                       ),
//                       onPressed: () {
//                         Navigator.push(context,
//                             MaterialPageRoute(builder: (context) => FullPhoto(url: document.get('content'))));
//                       },
//                       style: ButtonStyle(padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(0))),
//                     ),
//                     margin: EdgeInsets.only(left: 10.0),
//                   )
//                       : Container(
//                     child: Image.asset(
//                       'images/${document.get('content')}.gif',
//                       width: 100.0,
//                       height: 100.0,
//                       fit: BoxFit.cover,
//                     ),
//                     margin: EdgeInsets.only(bottom: isLastMessageRight(index) ? 20.0 : 10.0, right: 10.0),
//                   ),
//                 ],
//               ),
//
//               // Time
//               isLastMessageLeft(index)
//                   ? Container(
//                 child: Text(
//                   DateFormat('dd MMM kk:mm')
//                       .format(DateTime.fromMillisecondsSinceEpoch(int.parse(document.get('timestamp')))),
//                   style: TextStyle(color: greyColor, fontSize: 12.0, fontStyle: FontStyle.italic),
//                 ),
//                 margin: EdgeInsets.only(left: 50.0, top: 5.0, bottom: 5.0),
//               )
//                   : Container()
//             ],
//             crossAxisAlignment: CrossAxisAlignment.start,
//           ),
//           margin: EdgeInsets.only(bottom: 10.0),
//         );
//       // }
//     } else {
//       return SizedBox.shrink();
//     }
//   }
//
//   bool isLastMessageLeft(int index) {
//     if ((index > 0 && listMessage[index - 1].get('idFrom') == id) || index == 0) {
//       return true;
//     } else {
//       return false;
//     }
//   }
//
//   bool isLastMessageRight(int index) {
//     if ((index > 0 && listMessage[index - 1].get('idFrom') != id) || index == 0) {
//       return true;
//     } else {
//       return false;
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     Map textInputMap = {
//       "Wang" : "text 1 text 1 text 1 text 1 text 1 text 1",
//       "Gu" : "text 2 text 2 text 2 text 2 text 2 text 2",
//       "Yin" : "text 3 text 3 text 3 text 3 text 3 text 3",
//       "Li" : "text 4 text 4 text 4 text 4 text 4 text 4"
//     };
//     return Scaffold(
//       body: Stack(
//         children: <Widget>[
//           Column(
//             children: <Widget>[
//               // List of messages
//               buildListMessage(textInputMap),
//
//               // Sticker
//               //isShowSticker ? buildSticker() : Container(),
//
//               // Input content
//               //buildInput(),
//             ],
//           ),
//
//           // Loading
//           buildLoading()
//         ],
//       ),
//     );
//   }
//
//   Widget buildLoading() {
//     return Positioned(
//       child: isLoading ? const Loading() : Container(),
//     );
//   }
//
//   Widget buildListMessage(Map textInputMap) {
//     return ListView.builder(
//       padding: EdgeInsets.all(10.0),
//       itemBuilder: (context, index) => buildItem(index, snapshot.data?.docs[index]),
//       itemCount: snapshot.data?.docs.length,
//       reverse: true,
//       controller: listScrollController,
//     );
//     // return Flexible(
//     //   child: groupChatId.isNotEmpty
//     //       ? StreamBuilder<QuerySnapshot>(
//     //     stream: FirebaseFirestore.instance
//     //         .collection('messages')
//     //         .doc(groupChatId)
//     //         .collection(groupChatId)
//     //         .orderBy('timestamp', descending: true)
//     //         .limit(_limit)
//     //         .snapshots(),
//     //     builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//     //       // if (snapshot.hasData) {
//     //       //   listMessage.addAll(snapshot.data!.docs);
//     //         return ListView.builder(
//     //           padding: EdgeInsets.all(10.0),
//     //           itemBuilder: (context, index) => buildItem(index, snapshot.data?.docs[index]),
//     //           itemCount: snapshot.data?.docs.length,
//     //           reverse: true,
//     //           controller: listScrollController,
//     //         );
//     //       // } else {
//     //       //   return Center(
//     //       //     child: CircularProgressIndicator(
//     //       //       valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
//     //       //     ),
//     //       //   );
//     //       // }
//     //     },
//     //   )
//     //       : Center(
//     //     child: CircularProgressIndicator(
//     //       valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
//     //     ),
//     //   ),
//     // );
//   }
// }