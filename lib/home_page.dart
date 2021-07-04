import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:from_android/exhibition_bottom_sheet.dart';
import 'package:from_android/mail_view.dart';
import 'package:from_android/scrollable_exhibition_bottom_sheet.dart';
import 'package:from_android/sliding_cards.dart';
import 'package:from_android/tabs.dart';
import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';

import 'chat_view.dart';
import 'exhibition_bottom_sheet.dart';

class HomePage extends StatelessWidget {
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
                SizedBox(height: 8),
                Header(),
                SizedBox(height: 40),
                Tabs(),
                SizedBox(height: 8),
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
                      '家书',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(width: 20),
                    Spacer(),
                    Icon(
                      FontAwesomeIcons.envelope,
                      color: Colors.white,
                      size: 28,
                    )
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
