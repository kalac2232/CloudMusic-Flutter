import 'dart:async';

import 'package:cloudmusic/commen/utils/lyric_utils.dart';
import 'package:cloudmusic/player/bean/lyric.dart';
import 'package:flutter/material.dart';

class LyricWidget extends StatefulWidget {
  Duration currentDuration;

  List<Lyric> lyricList;

  _LyricWidgetState _state;
  LyricWidget({this.lyricList});


  @override
  _LyricWidgetState createState() {
    _state = _LyricWidgetState();
    return _state;
  }

  void setDuration(Duration duration) {
    currentDuration = duration;
    //print('duration: ' + duration.toString());

    _state.addIndex();
  }
}

class _LyricWidgetState extends State<LyricWidget> {

  double offsetY = 0;
  int currentIndex = 0;

  LyricPainter _lyricPainter;

  @override
  void initState() {
    super.initState();


  }

  @override
  Widget build(BuildContext context) {

    _lyricPainter = LyricPainter(
        lyricList: widget.lyricList,
        offsetY: offsetY,
        currentIndex: currentIndex
    );

    return GestureDetector(
      onVerticalDragUpdate: (DragUpdateDetails details) {
        //print(details.localPosition);

        setState(() {
          offsetY += details.delta.dy;
        });
      },
      child: CustomPaint(
        size: MediaQuery.of(context).size,
        painter: _lyricPainter,
      )
    );
  }

  void addIndex() {

    //offsetY -= 25;
    scrollToIndex(currentIndex + 1);

  }

  void scrollToIndex(int index){


    print("startY: " + _lyricPainter.startY.toString());
    print("dy1 :" + _lyricPainter.offsetMap[currentIndex].dy.toString());
    print("dy2 :" + _lyricPainter.offsetMap[index].dy.toString());

    offsetY = offsetY - (_lyricPainter.offsetMap[index].dy - _lyricPainter.offsetMap[currentIndex].dy);
    print("offsetY :" + offsetY.toString());
    print("----------");
    //offsetY -= 40;
    currentIndex = index;
    setState(() {

    });
  }
}

class LyricPainter extends CustomPainter {
  List<Lyric> lyricList;
  double startY = 0;
  double offsetY = 0;

  int currentIndex = -1;
  /// 歌词透明距离
  double _maxOpacityOffset = 100;

  List<TextPainter> textPainters;

  /// 默认歌词颜色
  Color _defaultColor = Colors.black;

  /// 高亮字体颜色
  Color _highLightColor = Colors.red;

  Map<int,Offset> offsetMap = Map();

  LyricPainter({this.lyricList, this.offsetY, this.currentIndex}) {
    textPainters = initTextPainters(lyricList);
  }

  @override
  void paint(Canvas canvas, Size size) {
    // 当第一行的开始位置为正中间
    startY = size.height / 2;


    for (int i = 0; i < lyricList.length; i++) {
      // 从之前创建好的列表中取，减少反复创建
      var textPainter = textPainters[i];

      double lastDy = 0;
      if (i != 0) {
        lastDy = offsetMap[i - 1].dy;
      }

      var dy = (startY + offsetY + lastDy + textPainter.size.height + 20).toDouble();


      // 根据歌词接近边界的距离设置透明度
      if (dy > size.height - _maxOpacityOffset) {
        // 因为TextPainter内部将color等属性设置为了final，无法修改，只能重新创建对象
        textPainter = _createTextPainter(
            lyricStr:lyricList[i].lyricStr,
            color:_defaultColor.withOpacity(calculateTextOpacity(size.height - dy)));

      } else if (dy < _maxOpacityOffset) {

        textPainter = _createTextPainter(
            lyricStr:lyricList[i].lyricStr,
            color:_defaultColor.withOpacity(calculateTextOpacity(dy)));
      } else if (i == currentIndex) {
        //
        textPainter = _createTextPainter(
            lyricStr:lyricList[i].lyricStr,
            color:_highLightColor);
      }


      // 将歌词位置设置为居中
      var offset = Offset((size.width - textPainter.width) / 2, dy);
      offsetMap[i] = offset;

      textPainter.paint(canvas, offset);
    }
  }

  @override
  bool shouldRepaint(LyricPainter oldDelegate) {
//    print("old" + oldDelegate.currentIndex.toString());
//    print(currentIndex);

    return oldDelegate.currentIndex != currentIndex
        || oldDelegate.offsetY != offsetY;

  }

  ///
  /// 计算歌词的透明度
  ///
  double calculateTextOpacity(double d) {
    if (d <= 0) {
      return 0;
    } else if (d > _maxOpacityOffset) {
      return 0;
    }

    return d / _maxOpacityOffset;
  }

  List<TextPainter> initTextPainters(List<Lyric> lyricList) {
    List<TextPainter> list = new List();

    for (var lyric in lyricList) {
      var textPainter =
      _createTextPainter(lyricStr: lyric.lyricStr, color: _defaultColor);
      list.add(textPainter);
    }

    return list;
  }

  TextPainter _createTextPainter({@required String lyricStr,@required Color color}) {
    var textPainter = TextPainter(
        text: TextSpan(
            text: lyricStr,
            style: TextStyle(
                fontSize: 14,
                color: color)),
        textDirection: TextDirection.ltr);
    textPainter.layout();

    return textPainter;
  }



}


