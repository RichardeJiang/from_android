import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'dart:async';

class Chat extends StatelessWidget {

  Future<Map> loadJson() async {
    Map imageTexts = await rootBundle
        .loadStructuredData('assets/text/home_letter.json', (String s) async {
      return json.decode(s);
    });

    return Future.value(imageTexts);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: loadJson(),
      builder: (context, AsyncSnapshot<Map> snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                '致孩子们：',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              centerTitle: true,
            ),
            body: ChatScreen(snapshot.data!),
          );
        } else {
          return CircularProgressIndicator();
        }
      }
    );
  }
}

class ChatScreen extends StatelessWidget {
  const ChatScreen(this.inpuMap);
  final Map inpuMap;

  @override
  Widget build(BuildContext context) {
    return buildListMessage(this.inpuMap);
  }

  Widget buildListMessage(Map textInputMap) {
    return ListView.builder(
      padding: EdgeInsets.all(10.0),
      itemBuilder: (context, index) {
        final name = this.inpuMap.keys.elementAt(index);
        return buildItem(index,
            name,
            this.inpuMap[name]["message"],
            this.inpuMap[name]["avatar"]);
      },
      itemCount: textInputMap.length,
      reverse: true,
    );
  }

  Widget buildItem(
      int index,
      String teacherName,
      String teacherMessage,
      String teacherAvatar) {
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
                      image: AssetImage('assets/$teacherAvatar'),
                      fit: BoxFit.fill
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(18.0),
                  ),
                ),
              ),

              // Text message
              Container(
                child: Text(
                  teacherMessage,
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
