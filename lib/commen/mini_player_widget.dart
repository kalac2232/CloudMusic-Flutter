import 'package:cloudmusic/commen/utils/hex_color.dart';
import 'package:cloudmusic/discovery/bloc/cubit/mini_player_bloc.dart';
import 'package:cloudmusic/discovery/bloc/event/commen_event.dart';
import 'package:cloudmusic/player/player_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MiniPlayerWidget extends StatelessWidget {

  Widget build(BuildContext context) {
    //计算下widget的中心点，用于控制动画的初始位置
    Alignment alignment = Alignment(1 - 27.w / (MediaQuery.of(context).size.width / 2), (22.w + MediaQuery.of(context).padding.top) / (MediaQuery.of(context).size.height / 2) - 1);

    //外层使用Positioned进行定位，控制在Overlay中的位置
    return Positioned(
      width: 30.w,
      height: 30.w,
      right: 12.w,
      top: 7.w + MediaQuery.of(context).padding.top,
      child: BlocBuilder<MiniPlayerBloc,MiniPlayerWidgetControlEvent>(
        builder: (BuildContext context, MiniPlayerWidgetControlEvent state) {
          return Visibility(
            visible: state == MiniPlayerWidgetControlEvent.visible,
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

              animation.addStatusListener((status) {
                if (status == AnimationStatus.completed) {
                  print("动画完成了");
                }
              });

              secondaryAnimation.addStatusListener((status) {
                if (status == AnimationStatus.completed) {
                  print("动画完成了2");
                }
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
