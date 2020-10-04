import 'package:cloudmusic/generated/r.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';

class BackBtn extends Positioned{
  BackBtn(BuildContext context) : super(
    left: 15.w,
    top: 11.w,
    width: 22.w,
    height: 22.w,
    child: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Image.asset(R.images_act_view_btn_back,width: 12.w,
            height: 22.w)),
  );
}