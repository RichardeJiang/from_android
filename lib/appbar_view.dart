import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

AppBar CustomizedAppBar() {
  final Color backgroundColor = Color(0xFF162A49);
  return AppBar(
    title: Container(
      width: 30,
      child: Image.asset('assets/icon/appbar.png'),
    ),
    backgroundColor: backgroundColor,
    centerTitle: true,
  );
}
