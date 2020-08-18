import 'package:cloudmusic/commen/utils/hex_color.dart';
import 'package:cloudmusic/discovery/bloc/cubit/bottom_refresh_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:math';

class BottomRefreshWidget extends StatefulWidget {
  @override
  _BottomRefreshWidgetState createState() => _BottomRefreshWidgetState();
}

class _BottomRefreshWidgetState extends State<BottomRefreshWidget> with TickerProviderStateMixin{
  double rotate;
  @override
  Widget build(BuildContext context) {
    AnimationController _animationController = AnimationController(duration: const Duration(milliseconds: 6000), vsync: this);
    _animationController.forward();

    _animationController.addListener(() {
//      setState(() {
//        rotate = pi * 2 * _animationController.value;
//        //print(rotate);
//      });
    });

    return Container(
      height: 100.h,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            top: 55.h,
            child: Text("到底了，上拉换一批新内容",style: TextStyle(
              color: HexColor.fromHex("#999999"),
              fontSize: 12.sp
            ),),
          ),
          Positioned(
            top: 23.h,
            child: BlocBuilder<BottomRefreshCubit,double>(
              builder: (BuildContext context, double offset) {
                //print(offset); //打印滚动位置
                return CustomPaint(
                  size: Size(28.w, 28.h), //指定画布大小
                  painter: MyPainter(rotate ,offset),
                );
              }
            ),
          )
        ],
      ),
    );
  }
}

class MyPainter extends CustomPainter {
  double offset;
  double rotate;

  //小箭头上边的透明距离限制
  static const double alphaLimit = 15;

  //最大滑动距离
  static const double maxOffsetLimit = 70;


  MyPainter(this.rotate,this.offset);

  @override
  void paint(Canvas canvas, Size size) {


    canvas.translate(size.width / 2, size.height / 2);

    if (this.offset >= maxOffsetLimit) {
      this.offset = maxOffsetLimit;

      //print(rotate);
      canvas.rotate(rotate);
    }


    double startX = 5.w - size.width / 2 - 0.3.h;
    double startY = size.height / 2 - 14.h - 3.2.h;

    if (this.offset <= alphaLimit) {
      //画小箭头的上边部分
      var topArrowPaint = Paint()
        ..isAntiAlias = true
        ..strokeWidth = 1.w
        ..strokeCap = StrokeCap.round //画笔笔头类型
        ..style = PaintingStyle.fill //填充
        ..color = HexColor.fromHex("#979797").withOpacity(1 - this.offset / alphaLimit);

      canvas.drawLine(Offset(0.w + startX,2.h + startY), Offset(3.w + startX,0.h + startY), topArrowPaint);
      canvas.drawLine(Offset(3.w + startX,0.h + startY), Offset(6.w + startX,2.h + startY), topArrowPaint);
    }


    //绘制圆弧
    //画小箭头的下边部分
    var arcPaint = Paint()
      ..isAntiAlias = true
      ..strokeWidth = 1.w
      ..strokeCap = StrokeCap.round //画笔笔头类型
      ..style = PaintingStyle.stroke //填充
      ..color = HexColor.fromHex("#979797").withOpacity(this.offset / alphaLimit > 1 ? 1 : this.offset / alphaLimit);

    var rect = Rect.fromCircle(center: Offset(0, 0), radius: 6.0.w);

    canvas.drawArc(rect, -pi,  pi * 1.65 * (offset / maxOffsetLimit) , false, arcPaint);

    canvas.rotate(pi * 1.65 * (offset / maxOffsetLimit));

    //画小箭头的下边部分
    var bottomArrowPaint = Paint()
      ..isAntiAlias = true
      ..strokeWidth = 1.w
      ..strokeCap = StrokeCap.round //画笔笔头类型
      ..style = PaintingStyle.fill //填充
      ..color = HexColor.fromHex("#979797");


    canvas.drawLine(Offset(3.w + startX,3.h + startY), Offset(0.w + startX,5.h + startY), bottomArrowPaint);
    canvas.drawLine(Offset(3.w + startX,3.h + startY), Offset(6.w + startX,5.h + startY), bottomArrowPaint);

  }

  //在实际场景中正确利用此回调可以避免重绘开销，本示例我们简单的返回true
  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
