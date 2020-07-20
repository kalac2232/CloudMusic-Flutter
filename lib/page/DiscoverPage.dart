import 'package:flutter/material.dart';

class DisCoverPage extends StatefulWidget {
  @override
  _DisCoverPageState createState() => _DisCoverPageState();
}

class _DisCoverPageState extends State<DisCoverPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.red,
        child: Center(
          child: Text(
            "发现页面",
            style: TextStyle(
              fontSize: 20,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
