import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'database.dart';

class GroupChat extends StatelessWidget {

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
      body: ChatScreen(),
    );
  }
}

class ChatScreen extends StatelessWidget {
  const ChatScreen();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: Database.readAllMails(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  Colors.orange,
                ),
              ),
            );
          }
          return new ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data = document.data() as Map<String,
                  dynamic>;
              String name = data['name'];
              String mail = data['message'];
              return buildItem(name, mail, "", context);
            }).toList(),
            padding: EdgeInsets.all(10.0),
            physics: BouncingScrollPhysics(),
          );
        }
        );
  }

  Widget buildItem(
      String teacherName,
      String teacherMessage,
      String teacherAvatar,
      BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Avatar
              Container(
                width: 36,
                height: 36,
                alignment: Alignment.center,
                decoration: new BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/rodion-kutsaev.jpeg'),
                      fit: BoxFit.fill
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(18.0),
                  ),
                ),
                //padding: EdgeInsets.only(top: 50),
                margin: EdgeInsets.only(top: 5.0),
              ),

              // Text message
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // Name
                  Container(
                    child: Text(
                      teacherName,
                      style: TextStyle(color: Colors.grey, fontSize: 10.0, fontStyle: FontStyle.italic),
                    ),
                    padding: EdgeInsets.only(left: 10.0),
                  ),

                  SizedBox(height: 1),

                  // Letter
                  Padding(
                    padding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 5.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: Card(
                        elevation: 8,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            teacherMessage,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),

          SizedBox(height: 7),
        ],
      ),
    );
  }
}
