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
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 30.w,
                    width: 30.w,
                    child: CircularProgressIndicator(
                      backgroundColor: HexColor.fromHex("#E7E7E7"),
                      valueColor: AlwaysStoppedAnimation(Theme.of(context).primaryColor),
                      value: .7,
                      strokeWidth: 1.w,
                    ),
                  ),
                  ClipOval(
                    child: Image.network("http://p3.music.126.net/mwCUI0iL3xEC2a4WVICHlA==/109951163115369030.jpg?param=50y50",width: 24.w,height: 24.w,),
                  )
                ],
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
            ) {
              animation.addListener(() {
                rad = max_Radius * (1 - animation.value);
              });
              return page;
              },
            transitionsBuilder: (
              context,
              animation,
              secondaryAnimation,
              child,
            ) {


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
