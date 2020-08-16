
import 'package:cloudmusic/commen/utils/hex_color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';

class DiscoverRankWidget extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 277.h,
      child: Stack(
        children: <Widget>[
          Positioned(
            left: 16.w,
            top: 0,
            child: Text(
              "热歌风向标",
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
              width: 76,
              height: 25,
              decoration: BoxDecoration(
                  border: Border.all(
                      color: HexColor.fromHex("#E6E6E6"), width: 1),
                  borderRadius: BorderRadius.circular(12.5)),
              alignment: Alignment.center,
              child: Text(
                "查看更多",
                style: TextStyle(
                    color: HexColor.fromHex("#333333"), fontSize: 13),
              ),
            ),
          ),
          Positioned(
            top: 38.h,
            height: 240.h,
            width: MediaQuery.of(context).size.width,
            child: PageView.builder(
                controller: PageController(
                  viewportFraction: 341 / 375,
                ),
                physics: BouncingScrollPhysics(),
                itemCount:  3,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.only(right: 16.w),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors:[Colors.grey.withAlpha(0),Colors.grey.withAlpha(255)],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,

                          ),
                        ),
                        position: DecorationPosition.foreground,
                        child: Container(
                          color: Colors.green,
                        ),
                      ),
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }

}