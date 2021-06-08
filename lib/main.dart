import 'package:from_android/home_page.dart';
import 'package:from_android/staggered_grid_view.dart';
import 'package:flutter/material.dart';

import 'chat_view_new.dart';

void main() => runApp(new MyTestApp());

class MyTestApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'SF Pro Display'),
      title: 'Buy Tickets',
      //home: HomePage(),
      //home: StaggeredView(),
      home: Chat(),
    );
  }
}
