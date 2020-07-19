import 'package:cloudmusic/utils/HexColor.dart';
import 'package:flutter/material.dart';

import 'page/HomePage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      theme: ThemeData(

        primaryColor: HexColor.fromHex("#FF1F14"),

      ),
      home: Scaffold(
        body: HomePage(),
      ),
    );
  }
}


