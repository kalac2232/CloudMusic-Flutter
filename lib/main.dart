
import 'package:flutter/material.dart';

import 'home_page.dart';
import 'commen/utils/hex_color.dart';

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


