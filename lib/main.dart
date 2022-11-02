import 'package:flutter/material.dart';

import 'dart:html' as html;

import 'package:flutterweb/mousetrack/mousetrack.dart';
import 'package:flutterweb/share_button/sharebutton.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mouse Magnetic Tracker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ShareButton(),
    );
  }
}
