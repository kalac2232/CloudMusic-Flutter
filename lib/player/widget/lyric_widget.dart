import 'dart:async';

import 'package:cloudmusic/commen/utils/lyric_utils.dart';
import 'package:cloudmusic/player/bean/lyric.dart';
import 'package:flutter/material.dart';

class LyricWidget extends StatefulWidget {
  @override
  _LyricWidgetState createState() => _LyricWidgetState();
}

class _LyricWidgetState extends State<LyricWidget> {
  int currentIndex = -1;
  double offsetY = 0;

  @override
  void initState() {
    super.initState();

    new Timer.periodic(Duration(milliseconds: 1000), (Timer t) {
      print('hi!');
      setState(() {
        currentIndex++;
        print(currentIndex);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragUpdate: (DragUpdateDetails details) {
        //print(details.localPosition);

        offsetY += details.delta.dy;

        setState(() {});
      },
      child: CustomPaint(
        size: MediaQuery.of(context).size,
        painter: LyricPainter(
            lyricList: LyricUtils.formatLyric(LyricUtils.tempLyric),
            offsetY: offsetY,
            currentIndex: currentIndex),
      ),
    );
  }
}

class LyricPainter extends CustomPainter {
  List<Lyric> lyricList;
  double startY = 50;
  double offsetY = 0;

  int currentIndex = -1;

  LyricPainter({this.lyricList, this.offsetY, this.currentIndex});

  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 0; i < lyricList.length; i++) {
      var color = i == currentIndex ? Colors.red : Colors.black;

      var textPainter = TextPainter(
          text: TextSpan(
              text: lyricList[i].lyricStr,
              style: TextStyle(fontSize: 14, color: color)),
          textDirection: TextDirection.ltr);

      textPainter.layout();
      textPainter.paint(
          canvas,
          Offset((size.width - textPainter.width) / 2,
              (startY + offsetY + 35 * i).toDouble()));
    }
  }

  @override
  bool shouldRepaint(LyricPainter oldDelegate) {
    //print("old" + oldDelegate.offsetY.toString());
    //print(offsetY);

    return oldDelegate.offsetY != offsetY || oldDelegate.currentIndex != currentIndex ;
    //return true;
  }
}
