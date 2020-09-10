import 'package:cloudmusic/commen/utils/hex_color.dart';
import 'package:cloudmusic/player/player_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MiniPlayerWidget extends StatefulWidget {
  @override
  _MiniPlayerWidgetState createState() => _MiniPlayerWidgetState();
}

class _MiniPlayerWidgetState extends State<MiniPlayerWidget> {
  @override
  Widget build(BuildContext context) {

    Alignment alignment = Alignment(1 - 27.w / (MediaQuery.of(context).size.width / 2), (22.w + MediaQuery.of(context).padding.top) / (MediaQuery.of(context).size.height / 2) - 1);

    //外层使用Positioned进行定位，控制在Overlay中的位置
    return Positioned(
      width: 30.w,
      height: 30.w,
      right: 12.w,
      top: 7.w + MediaQuery.of(context).padding.top,
      child: GestureDetector(
        child: Container(
          decoration: BoxDecoration(
              shape: BoxShape.circle, color: HexColor.fromHex("#949595")),
        ),
        onTap: () {
          Navigator.push(context, CustomRoute(page: PlayerPager(),alignment: alignment));
          //Navigator.pushNamed(context, "player_page");
        },
      ),
    );
  }
}

class CustomRoute extends PageRouteBuilder {
  final Widget page;
  final Alignment alignment;

  static double max_Radius = 50;
  static double rad = max_Radius;

  CustomRoute({this.page,this.alignment})
      : super(
            transitionDuration: Duration(milliseconds: 500),
            pageBuilder: (
              context,
              animation,
              secondaryAnimation,
            ) =>
                page,
            transitionsBuilder: (
              context,
              animation,
              secondaryAnimation,
              child,
            ) {

              animation.addListener(() {
                rad = max_Radius * (1 - animation.value);
              });


              return ScaleTransition(
                alignment: alignment,
                scale: Tween<double>(
                  begin: 0.0,
                  end: 1.0,
                ).animate(
                  CurvedAnimation(parent: animation, curve: Curves.easeIn),
                ),
                child: SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0, 1),
                    end: const Offset(0, 0),
                  ).animate(
                    CurvedAnimation(
                      parent: animation,
                      curve: Curves.easeIn,
                    ),
                  ),
                  child: FadeTransition(
                    opacity: Tween<double>(
                      begin: 0.0,
                      end: 1.0,
                    ).animate(
                      CurvedAnimation(
                          parent: animation,
                          curve: Curves.fastLinearToSlowEaseIn),
                    ),
                    child: ClipRRect(
                      child: child,
                      borderRadius: BorderRadius.circular(rad),
                    ),
                  ),
                ),
              );
            });
}
