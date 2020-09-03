import 'package:cloudmusic/generated/r.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DailyRecommendPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverPersistentHeader(
            pinned: true,
            delegate: SliverCustomHeaderDelegate(
                topBarHeight: 44.h,
                buttonBarHeight: 50.h,
                expandedHeight: 188.h,
                paddingTop: MediaQuery.of(context).padding.top,
                coverImgUrl: R.images_cm6_daily_banner
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index){
                  return Container(
                    height: 40,
                    alignment: Alignment.center,
                    child: Text(index.toString()),
                  );
                },
              childCount: 20
            ),
          )
        ],
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
  double get minExtent => this.topBarHeight + this.buttonBarHeight + this.paddingTop;

  @override
  double get maxExtent => this.expandedHeight + this.buttonBarHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
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
              child: Container(child: Image.asset(this.coverImgUrl, fit: BoxFit.cover))
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: SafeArea(
              child: Container(
                //margin: EdgeInsets.only(top: topBarHeight),
                color: Colors.grey,
                height: buttonBarHeight,
              ),
            ),
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
        ],
      ),
    );
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
            onTap: (){
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
        )
      ],

    );
  }

  Color makeStickyHeaderTextColor(shrinkOffset) {


    final int alpha = (shrinkOffset / (this.maxExtent - this.minExtent) * 255).clamp(0, 255).toInt();
    return Color.fromARGB(alpha, 255, 255, 255);
  }
}
