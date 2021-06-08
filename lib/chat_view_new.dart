import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'dart:async';

class Chat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '致孩子们：',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: ChatScreen(),
    );
  }
}

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Map textInputMap = {
      0 : "text 1 text 1 text 1 text 1 text 1 text 1",
      1 : "text 1 text 1 text 1 text 1 text 1 text 1",
      2 : "text 2 text 2 text 2 text 2 text 2 text 2",
      3 : "text 3 text 3 text 3 text 3 text 3 text 3",
      4 : "text 4 text 4 text 4 text 4 text 4 text 4"
    };
    return Scaffold(
      body: buildListMessage(textInputMap),
    );
  }

  Widget buildListMessage(Map textInputMap) {
    return ListView.builder(
      padding: EdgeInsets.all(10.0),
      itemBuilder: (context, index) =>
          buildItem(index, textInputMap[index]),
      itemCount: textInputMap.length,
      reverse: true,
    );
  }

  Widget buildItem(int index, String text) {
    final Image teacherAvatar = Image.asset('assets/efe-kurnaz.jpg');
    return Container(
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              // Avatar
              Container(
                width: 36,
                height: 36,
                alignment: Alignment.center,
                decoration: new BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/efe-kurnaz.jpg'),
                      fit: BoxFit.fill
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(18.0),
                  ),
                ),

                // borderRadius: BorderRadius.all(
                //   Radius.circular(18.0),
                // ),
                // clipBehavior: Clip.hardEdge,
              ),

              // Text message
              Container(
                child: Text(
                  text,
                  style: TextStyle(color: Colors.white),
                ),
                padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
                width: 200.0,
                decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(8.0)),
                margin: EdgeInsets.only(left: 10.0),
              )
            ],
          ),

          SizedBox(height: 10),
        ],
      ),
    );
  }
}
