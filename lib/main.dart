import 'package:from_android/home_page.dart';
import 'package:flutter/material.dart';

import 'chat_view.dart';

void main() => runApp(new MainApp());

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'SF Pro Display'),
      title: 'Buy Tickets',
      home: HomePage(),
    );
  }
}
