import 'package:flutter/material.dart';

class OnlyTextPage extends StatefulWidget {

  String text;

  OnlyTextPage({this.text = "空界面"});

  @override
  _OnlyTextPageState createState() => _OnlyTextPageState();
}

class _OnlyTextPageState extends State<OnlyTextPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Text(
          widget.text,
          style: TextStyle(
            fontSize: 20,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
