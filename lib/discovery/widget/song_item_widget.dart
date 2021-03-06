import 'dart:math';

import 'package:cloudmusic/commen/utils/hex_color.dart';
import 'package:cloudmusic/discovery/bean/song_bean.dart';
import 'package:cloudmusic/generated/r.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SongItemWidget extends StatelessWidget {
  SongBean bean;


  SongItemWidget({this.bean});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.w,
      width: 341.w,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            left: 0,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(bean.picUrl+"?param=160y160"),
                    fit: BoxFit.cover),
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                //color: Colors.red
              ),
              width: 60.w,
              height: 60.w,
            ),
          ),
          Positioned(
            right: 22.w,
            child: Container(
              width: 25.w,
              height: 25.w,
              decoration: BoxDecoration(
                  border:
                  Border.all(color: HexColor.fromHex("#E6E6E6"), width: 1),
                  shape: BoxShape.circle),
              child: Image.asset(
                R.images_cm6_play_icon_red_play,
                width: 25.w,
                height: 25.w,
              ),
            ),
          ),
          Positioned(
            width: 210.w,
            left: 71.w,
            top: 7.w,
            child: Row(
              children: <Widget>[
                Container(
                  constraints: BoxConstraints(
                    maxWidth: 130.w,
                  ),
                  child: Text(
                    bean.name,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                        color: HexColor.fromHex("#333333"), fontSize: 15.sp),
                  ),
                ),
                Expanded(
                  child: Text(
                    " - " + bean.getArtistsStr(),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                        color: HexColor.fromHex("#999999"), fontSize: 12.sp),
                  ),
                )
              ],
            ),
          ),
          Positioned(
            bottom: 10.w,
            left: 70.w,
            child: _getSubtitle(Random().nextInt(4)),
          )
        ],
      ),
    );
  }
}

Widget _getSubtitle(int type) {
  //
  if(type == 0) {
    return Container(
      padding: EdgeInsets.only(left: 6.w,right: 6.w),
      decoration: BoxDecoration(
        color: HexColor.fromHex("#FFE1E1"),
        borderRadius: BorderRadius.circular(3),
      ),
      child: Text("超"+ (60+Random().nextInt(40)).toString() +"%人播放",style: TextStyle(
        color: HexColor.fromHex("#FF3A3A"),
        fontSize: 9.sp,
      ),),
    );
  }

  if(type == 1) {
    return Container(
      child: Row(
        children: <Widget>[
          Image.asset(R.images_cm2_icn_sq_15,width: 18.w,height: 14.w,color: HexColor.fromHex("#FF3A3A"),),
          Padding(
            padding: EdgeInsets.only(left: 4.w),
            child: Text("有心栽花花不开 无心插柳柳成荫",style: TextStyle(
                color: HexColor.fromHex("#999999"),
                fontSize: 12.sp
            ),),
          )
        ],
      ),
    );
  }

  if(type == 2) {
    return Container(
      child: Row(
        children: <Widget>[
          Image.asset(R.images_cm5_list_icn_exclusive,width: 22.w,height: 11.w,color: HexColor.fromHex("#FF3A3A"),),
          Padding(
            padding: EdgeInsets.only(left: 4.w,bottom: 1.h),
            child: Text("有心栽花花不开 无心插柳柳成荫",style: TextStyle(
                color: HexColor.fromHex("#999999"),
                fontSize: 12.sp
            ),),
          )
        ],
      ),
    );
  }

  if(type == 3) {
    return Container(
      child: Text("有心栽花花不开 无心插柳柳成荫",style: TextStyle(
          color: HexColor.fromHex("#999999"),
          fontSize: 12.sp
      ),),
    );
  }
}