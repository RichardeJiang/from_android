import 'dart:convert';

import 'package:flutter/material.dart';

class Mail extends StatefulWidget {
  Mail();

  @override
  _MailState createState() => _MailState();
}

class _MailState extends State<Mail> {
  String mailSender = '';
  String mailContent = '';

  TextEditingController mailSenderController = TextEditingController();
  TextEditingController mailContentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                  controller: mailSenderController,
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
                  controller: mailContentController,
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
  }
}
