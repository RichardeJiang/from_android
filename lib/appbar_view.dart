import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

AppBar CustomizedAppBar() {
  final Color backgroundColor = Color(0xFF162A49);
  return AppBar(
    title: Container(
      width: 20,
      child: Image.asset('assets/steve-johnson.jpeg'),
    ),
    backgroundColor: backgroundColor,
    centerTitle: true,
  );
}