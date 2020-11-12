import 'dart:async';

import 'package:cloudmusic/player/widget/lyric_widget.dart';
import 'package:flutter/material.dart';

import 'utils/lyric_utils.dart';

class TestPager extends StatefulWidget {
  @override
  _TestPagerState createState() => _TestPagerState();
}

class _TestPagerState extends State<TestPager> {

  LyricWidget _lyricWidget;

  @override
  void initState() {
    super.initState();
    _lyricWidget = LyricWidget(lyricList: LyricUtils.formatLyric(LyricUtils.tempLyric),);

//    new Timer.periodic(Duration(milliseconds: 1000), (Timer t) {
//      _lyricWidget.setDuration(null);
//    });
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        height: 700,

        child: _lyricWidget,
      ),
    );
  }
}
