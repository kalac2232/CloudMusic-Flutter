import 'package:cloudmusic/commen/constant/color.dart';
import 'package:cloudmusic/commen/utils/hex_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class DragonBollWidget extends StatelessWidget {

  final String text;
  final String icon;

  Function onTap;

  DragonBollWidget({this.text, this.icon,this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: 46.w,
        height: 70.w,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Positioned(
              top: 0,
              child: Container(
                width: 46.w,
                height: 46.w,
                decoration: BoxDecoration(
                  gradient: mainGradientColor, //背景渐变
                  shape: BoxShape.circle,
                ),
                child: Image.asset(this.icon),
              ),
            ),
            Positioned(
              bottom: 0,
              child: Text(this.text,style: TextStyle(
                color: HexColor.fromHex("#666666"),
                fontSize: 12
              ),),
            )
          ],
        ),
      ),
      onTap: onTap,
    );
  }

}