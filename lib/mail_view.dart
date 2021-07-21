import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:from_android/appbar_view.dart';
import 'package:from_android/database.dart';

class Mail extends StatefulWidget {

  Mail();

  @override
  _MailState createState() => _MailState();
}

class _MailState extends State<Mail> {
  String mailSender = '';
  String mailContent = '';

  final double textFieldWidthPercentage = 0.75;

  TextEditingController mailSenderController = TextEditingController();
  TextEditingController mailContentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomizedAppBar(),
        body: Column(
            //mainAxisSize: MainAxisSize.max,
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width * this.textFieldWidthPercentage,
                //margin: EdgeInsets.all(20),
                child: TextField(
                  controller: mailSenderController,
                  decoration: InputDecoration(
                    //border: OutlineInputBorder(),
                    labelText: '某王家庄人',
                    icon: Icon(Icons.person),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF162A49)),
                    ),
                    labelStyle: TextStyle(
                      color: Color(0xFF162A49),
                    ),
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * this.textFieldWidthPercentage,
                height: MediaQuery.of(context).size.height * 0.3,
                margin: EdgeInsets.all(20),
                child: TextField(
                  controller: mailContentController,
                  maxLines: null,
                  expands: true,
                  textAlignVertical: TextAlignVertical.top,
                  decoration: InputDecoration(
                    labelText: '？',
                    //border: OutlineInputBorder()),
                    icon: Icon(FontAwesomeIcons.envelope),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF162A49)),
                    ),
                    labelStyle: TextStyle(
                      color: Color(0xFF162A49),
                    ),
                  ),
                ),
              ),
              IconButton(
                onPressed: () async {
                  await Database.addNewMail(
                    mailSender: mailSenderController.text,
                    mailContent: mailContentController.text);
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.send,
                  color: Colors.black,
                  size: 25,
                )
              )
            ]
        )
    );
  }
}
