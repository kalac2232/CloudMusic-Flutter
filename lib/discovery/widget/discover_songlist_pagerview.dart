import 'dart:math';

import 'package:cloudmusic/commen/utils/hex_color.dart';
import 'package:cloudmusic/discovery/bean/song_list_item_bean.dart';
import 'package:cloudmusic/discovery/widget/song_item_widget.dart';
import 'package:cloudmusic/generated/r.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

typedef ItemBuilder<B> = Widget Function(BuildContext context, B bean);

class DiscoverSongListPageView<B> extends StatelessWidget {

  List<B> list;

  ItemBuilder<B> itemBuilder;

  DiscoverSongListPageView({@required this.list,@required this.itemBuilder});

  @override
  Widget build(BuildContext context) {
    return this.list == null || list.isEmpty ? Container() : PageView.builder(
        controller: PageController(
          viewportFraction: 341 / 375,
        ),
        physics: BouncingScrollPhysics(),
        itemCount: list.length ~/ 3,
        itemBuilder: (context, index) {
          return Container(
            //height: 200.h,
            //color: Colors.black,
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Positioned(
                  top: 0,
                  //left: 0,
                  child: itemBuilder(context,list[index * 3 + 0]),
                ),
                Positioned(
                  child: itemBuilder(context,list[index * 3 + 1]),
                ),
                Positioned(
                  bottom: 0,
                  child: itemBuilder(context,list[index * 3 + 2]),
                ),
              ],
            ),
          );
        });
  }
}

