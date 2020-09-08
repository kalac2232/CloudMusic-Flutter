import 'package:cloudmusic/commen/utils/hex_color.dart';
import 'package:flutter/material.dart';

class CalendarRingWidget extends StatelessWidget {

  final double width;
  final double height;
  final double opacity;


  CalendarRingWidget({this.width, this.height, this.opacity});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(this.width, this.height), //指定画布大小
      painter: Ring(opacity:opacity),
    );
  }
}


class Ring extends CustomPainter{

  final double opacity;


  Ring({this.opacity});

  @override
  void paint(Canvas canvas, Size size) {

    //获取宽
    double width = size.width;

    var paint = Paint()
      ..isAntiAlias = true
      ..strokeWidth = width/2
      ..strokeCap = StrokeCap.round //画笔笔头类型
      ..style = PaintingStyle.fill //填充
      ..color = HexColor.fromHex("#E6E6E6").withOpacity(this.opacity);


    //绘制底圆
    Rect rect = Rect.fromLTRB(0,size.height - size.width,size.width,size.height);
    canvas.drawOval(rect,paint);
    //绘制圆上面的竖条
    paint.color = Colors.white.withOpacity(this.opacity);
    canvas.drawLine(Offset(0 + width / 2,0 + width / 4),Offset(0 + width / 2,size.height - width / 2),paint);

  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {

    return false;
  }

}