import 'package:flutter/material.dart';
import 'package:from_android/appbar_view.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

import 'backend.dart';

class GroupChat extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomizedAppBar(),
      body: ChatScreen(),
    );
  }
}

class ChatScreen extends StatelessWidget {
  const ChatScreen();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ParseObject>>(
        future: Backend.readAllMails(),
        builder: (context, snapshot) {
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
          return ListView.builder(
            padding: EdgeInsets.all(10.0),
            physics: BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics()
            ),
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final data = snapshot.data![index];
              final String name = data.get<String>('name')!;
              final String mail = data.get<String>('message')!;

              return buildItem(name, mail, "", context);
            }
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
