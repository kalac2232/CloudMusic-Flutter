import 'package:flutter/material.dart';

class PlayerPager extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        color: Colors.greenAccent,
        child: GestureDetector(
            child: Text("播放器页"),
          onTap: (){
              Navigator.of(context).pop();
          },
        ),
      ),
    );
  }
}
