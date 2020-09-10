import 'dart:math';

import 'package:cloudmusic/commen/utils/hex_color.dart';
import 'package:cloudmusic/discovery/bean/song_bean.dart';
import 'package:cloudmusic/generated/r.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DailySongItemWidget extends StatelessWidget {
  SongBean bean;


  DailySongItemWidget({this.bean});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.w,
      width: 333.w,
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
                borderRadius: BorderRadius.all(Radius.circular(4.0)),
                //color: Colors.red
              ),
              width: 40.w,
              height: 40.w,
            ),
          ),
          Positioned(
            right: 0,
            width: 20.w,
            height: 20.h,
            child: Image.asset(R.images_rcd_icn_more,color: HexColor.fromHex("#B3B3B3"),),
          ),
          Positioned(
            width: 20.w,
            height: 20.h,
            right: 37.w,
            child: Visibility(
              visible: this.bean.mvId > 0,
              child: Image.asset(R.images_list_tag_mv,color: HexColor.fromHex("#B3B3B3"),),
            ),
          ),
          Positioned(
            width: 202.w,
            left: 50.w,
            top: 10.w,
            child: Text(
              bean.name,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: TextStyle(
                  color: HexColor.fromHex("#333333"), fontSize: 16.sp),
            ),
          ),
          Positioned(
            width: 202.w,
            left: 50.w,
            top: 34.w,
            child: Row(
              children: <Widget>[
                Offstage(
                  offstage: this.bean.isSole,
                  child:Padding(
                    padding: const EdgeInsets.only(right: 3,top: 1),
                    child: Image.asset(R.images_list_icn_solo,width: 20.w,height: 11.w,color: HexColor.fromHex("#FF3A3A"),),
                  ),
                ),
                Offstage(
                  offstage: this.bean.isSQ,
                  child:Padding(
                    padding: const EdgeInsets.only(right: 3),
                    child: Image.asset(R.images_cm2_icn_sq_15,width: 18.w,height: 14.w,color: HexColor.fromHex("#FF3A3A"),),
                  ),
                ),
                Text(
                  bean.getArtistsStr(),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(
                      color: HexColor.fromHex("#808080"), fontSize: 12.sp),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

