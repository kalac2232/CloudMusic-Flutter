import 'dart:convert';

import 'package:cloudmusic/commen/net/http_request.dart';
import 'package:cloudmusic/commen/utils/hex_color.dart';
import 'package:cloudmusic/commen/widget/back_btn.dart';
import 'package:cloudmusic/discovery/bean/song_bean.dart';
import 'package:cloudmusic/discovery/widget/calendar_ring_widget.dart';
import 'package:cloudmusic/discovery/widget/daily_song_item_widget.dart';
import 'package:cloudmusic/discovery/widget/song_item_widget.dart';
import 'package:cloudmusic/generated/r.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DailyRecommendPage extends StatefulWidget {

  @override
  _DailyRecommendPageState createState() => _DailyRecommendPageState();
}

class _DailyRecommendPageState extends State<DailyRecommendPage> {

  List<SongBean> songBeanList = new List();

  @override
  void initState() {
    super.initState();
    _getRecommendList();
  }

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
                    topBarHeight: 44.w,
                    buttonBarHeight: 50.w,
                    expandedHeight: 188.h,
                    paddingTop: MediaQuery.of(context).padding.top,
                    coverImgUrl: R.images_cm6_daily_banner),
              ),
              (this.songBeanList.isEmpty) ? SliverToBoxAdapter(child: Container(height: 20,width: 20,)):SliverList(
                delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                  return Container(
                    height: 60.w,
                    margin: EdgeInsets.only(left: 16.w,right: 16.w),
                    child: DailySongItemWidget(bean:this.songBeanList[index]),
                  );
                }, childCount: 20),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _getRecommendList() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();

    var dateTime = DateTime.now();
    //当前年月日，当作key缓存日推数据
    var todayStr = dateTime.year.toString() + dateTime.month.toString() + dateTime.day.toString();

    String jsonStr = prefs.get("daily_date_" + todayStr);
    if (jsonStr == null || jsonStr.isEmpty)  {

      var response = await httpRequest.get(path: "/recommend/songs");
      jsonStr = json.encode(response.data["recommend"]);

      //缓存数据
      prefs.setString("daily_date_" + todayStr,jsonStr);
    }

    List list = json.decode(jsonStr);

    list.map((json) {
      this.songBeanList.add(SongBean.fromDailyRecommendJson(json));
    }).toList();



    setState(() {

    });
    //httpRequest.get(path: "/login/cellphone?phone=17684721017&password=qweasdzxc").then((value) => print(value));


  }
}
///
/// 滑动组件生成代理
///
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
  double get maxExtent => this.expandedHeight + this.buttonBarHeight - 19.w;

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
          //日历
          Positioned(
            left: 16.w,
            right: 0,
            bottom: 64.h,
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
              child: _Buttons(),
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
        BackBtn(context),
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

    var day = DateTime.now().day;
    var month = DateTime.now().month;

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
                child: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    Positioned(
                      left: 12.w,
                        child: Text("历史日推",style: TextStyle(
                      fontSize: 14.sp,
                      color: HexColor.fromHex("#333333"),
                    ),)),
                    Positioned(
                      right: 8.w,
                        width: 27.w,
                        height: 14.h,
                        child: Image.asset(R.images_icn_black_vip)
                    )
                  ],
                ),
              )),
          Positioned(
              left: 12.w,
              bottom: 31.h,
              child: Text(
                day < 10 ? "0$day":day.toString(),
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 44,
                    fontFamily: "Mittelschrift"),
              )),
          Positioned(
              left: 59.w,
              bottom: 35.h,
              child: Text(
                month < 10 ? "/  0$month" :"/  $month",
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

class _Buttons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Positioned(
          left: 11.w,
          width: 20.w,
          height: 21.h,
          child: Image.asset(R.images_list_icn_play),
        ),
        Positioned(
          top: 10.5.h,
          left: 42.w,
          child: Text(
            "播放全部",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize:17.sp,
              color: HexColor.fromHex("#333333")
            ),
          ),
        ),
        Positioned(

          right: 45.w,
          width: 18.w,
          height: 18.w,
          child: Image.asset(R.images_list_icn_multi),
        ),
        Positioned(
          top: 13.h,
          right: 17.w,
          child: Text(
            "多选",
            textAlign: TextAlign.center,

            style: TextStyle(
                fontSize:14.sp,
                color: HexColor.fromHex("#333333")
            ),
          ),
        ),
      ],
    );
  }
}