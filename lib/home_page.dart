import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:from_android/mail_view.dart';
import 'package:from_android/secret_constants.dart';
import 'package:from_android/sliding_cards.dart';
import 'package:flutter/material.dart';

import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<Parse> _initializeBack4App() async {
    Parse back4App = await Parse().initialize(
        SecretConstant.BACK_FOUR_APP_APP_ID,
        SecretConstant.BACK_FOUR_APP_KEY_PARSE_SERVER_URL,
        clientKey: SecretConstant.BACK_FOUR_APP_CLIENT_KEY,
        debug: true);

    return back4App;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 22),
                IconHeader(),
                SizedBox(height: 35),
                //Tabs(),
                //SizedBox(height: 8),
                SlidingCardsView(),
              ],
            ),
          ),
          //ExhibitionBottomSheet(), //use this or ScrollableExhibitionSheet
          Positioned(
              height: 90,
              left: 0,
              right: 0,
              bottom: 0,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Mail()));
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  decoration: const BoxDecoration(
                    color: Color(0xFF162A49),
                    borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
                  ),
                  child: Row(
                    children: [
                      Text(
                        '好久不见',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(width: 20),
                      Spacer(),
                      FutureBuilder(
                        future: _initializeBack4App(),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return Text("ERROR CONNECTING TO BACK4APP");
                          } else if (snapshot.connectionState
                              == ConnectionState.done) {
                            return Icon(
                              FontAwesomeIcons.envelope,
                              color: Colors.white,
                              size: 28,
                            );
                          } else {
                            return CircularProgressIndicator(
                                color: Colors.white
                            );
                          }
                        }
                      ),
                    ],
                  ),
                ),
              )
          )
        ],
      ),
    );
  }
}

class Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Text(
        'Shenzhen',
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class IconHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 10),
        Image.asset(
          'assets/icon/entry.png',
          height: 70,
        ),
        Align(
          alignment: FractionalOffset.bottomCenter,
          child: Text(
            '周年快乐',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
