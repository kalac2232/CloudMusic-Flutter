import 'package:cloudmusic/commen/utils/hex_color.dart';
import 'package:cloudmusic/discovery/widget/discover_songlist_pagerview.dart';
import 'package:cloudmusic/generated/r.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategorySongWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 238.h,
      child: Stack(
        children: <Widget>[
          Positioned(
            left: 16.w,
            top: 0,
            child: Text(
              "精选华语金曲",
              style: TextStyle(
                  fontSize: 18,
                  color: HexColor.fromHex("#000000"),
                  fontWeight: FontWeight.bold),
            ),
          ),
          //加载更多按钮
          Positioned(
            right: 16,
            top: 0,
            child: Container(
              width: 91.w,
              height: 25.h,
              decoration: BoxDecoration(
                  border:
                      Border.all(color: HexColor.fromHex("#E6E6E6"), width: 1),
                  borderRadius: BorderRadius.circular(12.5)),
              alignment: Alignment.center,
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Positioned(
                      left: 5.w,
                      child: Image.asset(
                        R.images_cm6_play_icon_red_play,
                        color: HexColor.fromHex("#333333"),
                        width: 25.w,
                        height: 25.h,
                      )),
                  Positioned(
                    left: 27.w,
                    child: Text(
                      "播放全部",
                      style: TextStyle(
                          color: HexColor.fromHex("#333333"), fontSize: 13),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 38.h,
            height: 200.h,
            width: MediaQuery.of(context).size.width,
            child: DiscoverSongListPageView(),
          )
        ],
      ),
    );
  }

}
