import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'dart:async';

class Mail extends StatelessWidget {

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
                  '家书：',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
                centerTitle: true,
              ),
              body: Column(
                    //mainAxisSize: MainAxisSize.max,
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width * 0.7,
                        margin: EdgeInsets.all(20),
                        child: TextField(
                          controller: TextEditingController(text: 'The subject'),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Recipient',
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.7,
                        height: MediaQuery.of(context).size.height * 0.3,
                        margin: EdgeInsets.all(20),
                        child: TextField(
                          controller: TextEditingController(text: 'The body'),
                          maxLines: null,
                          expands: true,
                          textAlignVertical: TextAlignVertical.top,
                          decoration: InputDecoration(
                              labelText: 'Body', border: OutlineInputBorder()),
                        ),
                      ),

                      Icon(
                        Icons.send,
                        color: Colors.black,
                        size: 30,
                      )
                    ]
                )
              );
          } else {
            return CircularProgressIndicator();
          }
        }
    );
  }
}
