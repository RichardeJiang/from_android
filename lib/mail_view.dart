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
                  '致孩子们：',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
                centerTitle: true,
              ),
              body: Padding(
                padding: EdgeInsets.all(12.0),
                child: Column(
                    mainAxisSize: MainAxisSize.max,
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: TextField(
                          controller: TextEditingController(text: 'The subject'),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Recipient',
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: TextField(
                            controller: TextEditingController(text: 'The body'),
                            maxLines: null,
                            expands: true,
                            textAlignVertical: TextAlignVertical.top,
                            decoration: InputDecoration(
                                labelText: 'Body', border: OutlineInputBorder()),
                          ),
                        ),
                      ),
                      Icon(
                        Icons.send,
                        color: Colors.black,
                        size: 30,
                      )
                    ]
                )
              )
            );
          } else {
            return CircularProgressIndicator();
          }
        }
    );
  }
}
