import 'package:cloudmusic/commen/utils/hex_color.dart';
import 'package:cloudmusic/discovery/widget/calendar_ring_widget.dart';
import 'package:cloudmusic/generated/r.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'dart:math' as math;

class DailyRecommendPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        color: Colors.white,
        child: SafeArea(
          top: false,
          child: CustomScrollView(
            slivers: <Widget>[
              SliverPersistentHeader(
                pinned: true,
                delegate: SliverCustomHeaderDelegate(
                    topBarHeight: 44.h,
                    buttonBarHeight: 50.h,
                    expandedHeight: 188.h,
                    paddingTop: MediaQuery.of(context).padding.top,
                    coverImgUrl: R.images_cm6_daily_banner),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                  return Container(
                    height: 40,
                    color: Colors.blue,
                    alignment: Alignment.center,
                    child: Text(index.toString()),
                  );
                }, childCount: 20),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class SliverCustomHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double topBarHeight;
  final double buttonBarHeight;
  final double expandedHeight;
  final double paddingTop;
  final String coverImgUrl;

  SliverCustomHeaderDelegate({
    this.topBarHeight,
    this.buttonBarHeight,
    this.expandedHeight,
    this.paddingTop,
    this.coverImgUrl,
  });

  @override
  double get minExtent =>
      this.topBarHeight + this.buttonBarHeight + this.paddingTop;

  @override
  double get maxExtent => this.expandedHeight + this.buttonBarHeight - 19.h;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      height: this.maxExtent,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Positioned(
              left: 0,
              right: 0,
              top: 0,
              height: this.expandedHeight,
              child: Container(
                  child: Image.asset(this.coverImgUrl, fit: BoxFit.cover))),
          Positioned(
            left: 16.w,
            right: 0,
            bottom: 70.h,

            child: Container(
                height: 82.h,
                width: 109.w,
                child: _Calendar(
              opacity: calculateRingOpacity(shrinkOffset * 2),
            )),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: this.paddingTop,
            height: this.topBarHeight,
            child: _TopBar(
              maxExtent: this.maxExtent,
              minExtent: this.minExtent,
              shrinkOffset: shrinkOffset,
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: -1,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)), //3像素圆角
              ),
              height: buttonBarHeight,
            ),
          ),
          Positioned(
            bottom: 0,
            left: 70.w,
            child: Container(
                margin: EdgeInsets.only(bottom: buttonBarHeight - 11.h),
                child: CalendarRingWidget(
                  width: 8.w,
                  height: 16.h,
                  opacity: calculateRingOpacity(shrinkOffset),
                )),
          ),
          Positioned(
            bottom: 0,
            left: 297.w,
            child: Container(
                margin: EdgeInsets.only(bottom: buttonBarHeight - 11.h),
                child: CalendarRingWidget(
                    width: 8.w,
                    height: 16.h,
                    opacity: calculateRingOpacity(shrinkOffset))),
          )
        ],
      ),
    );
  }

  double calculateRingOpacity(shrinkOffset) {
    double opacity = 1 - shrinkOffset / (this.maxExtent - this.minExtent);

    if (opacity > 1) {
      return 1;
    } else if (opacity < 0) {
      return 0;
    }

    return opacity;
  }
}

class _TopBar extends StatelessWidget {
  final double maxExtent;
  final double minExtent;
  final double shrinkOffset;

  _TopBar({this.maxExtent, this.minExtent, this.shrinkOffset});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Positioned(
          left: 20.w,
          top: 11.h,
          width: 12.w,
          height: 22.h,
          child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Image.asset(R.images_act_view_btn_back)),
        ),
        Positioned(
          child: Text(
            "每日推荐",
            style: TextStyle(
              fontSize: 18,
              color: this.makeStickyHeaderTextColor(shrinkOffset),
            ),
          ),
        ),
        Positioned(
          width: 24.w,
          height: 24.h,
          left: 290.w,
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.white),
                shape: BoxShape.circle),
            child: Image.asset(R.images_rcd_qmark),
          ),
        )
      ],
    );
  }

  Color makeStickyHeaderTextColor(shrinkOffset) {
    final int alpha = (shrinkOffset / (this.maxExtent - this.minExtent) * 255)
        .clamp(0, 255)
        .toInt();
    return Color.fromARGB(alpha, 255, 255, 255);
  }
}

class _Calendar extends StatelessWidget {
  final double opacity;

  _Calendar({this.opacity});

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: opacity,
      child: Stack(
        children: <Widget>[
          Positioned(
              bottom: 0,
              child: Container(
                width: 109.w,
                height: 28.h,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(14.h),
                ),
              )),
          Positioned(
              left: 12.w,
              bottom: 31.h,
              child: Text(
                "22",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 44,
                    fontFamily: "Mittelschrift"),
              )),
          Positioned(
              left: 59.w,
              bottom: 35.h,
              child: Text(
                "/  09",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 21,
                    fontFamily: "Mittelschrift"),
              )),
        ],
      ),
    );
  }
}
