import 'dart:ui';

import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:cloudmusic/commen/only_text_pager.dart';
import 'package:cloudmusic/discovery/bloc/cubit/mini_player_bloc.dart';
import 'package:cloudmusic/discovery/bloc/event/commen_event.dart';
import 'package:cloudmusic/generated/r.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:math' as math;

class PlayerPager extends StatefulWidget {
  @override
  _PlayerPagerState createState() => _PlayerPagerState();
}

class _PlayerPagerState extends State<PlayerPager> {
  @override
  void initState() {
    super.initState();
    print("initState");
    context.bloc<MiniPlayerBloc>().add(MiniPlayerWidgetControlEvent.gone);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Image.network(
                "http://p3.music.126.net/mwCUI0iL3xEC2a4WVICHlA==/109951163115369030.jpg",
                fit: BoxFit.fitHeight,
              )),
          Positioned(
              child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
            child: new Container(
              color: Colors.black.withOpacity(0.5),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
            ),
          )),
          Positioned(
            top: MediaQuery.of(context).padding.top,
            height: 44.w,
            width: 375.w,
            child: _TopBar(),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void deactivate() {
    context.bloc<MiniPlayerBloc>().add(MiniPlayerWidgetControlEvent.visible);
    print("deactivate");
    super.deactivate();
  }
}

class _TopBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Positioned(
          left: 20.w,
          top: 11.w,
          width: 12.w,
          height: 22.w,
          child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Image.asset(R.images_act_view_btn_back)),
        ),
        Positioned(
          top: 4.w,
          child: Text(
            "Diamond Heart",
            style: TextStyle(
              fontSize: 17.sp,
              color: Colors.white,
            ),
          ),
        ),
        Positioned(
          top: 25.w,
          child: Row(
            children: <Widget>[
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: 152.w,
                ),
                child: TextOneLine(
                  "Alan Walker/SophiaSoasdaaaaaa",
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(
                width: 3.w,
              ),
              Transform.rotate(
                  angle: math.pi,
                  child: Image.asset(
                    R.images_act_view_btn_back,
                    width: 5.w,
                    height: 10.h,
                  ))
            ],
          ),
        ),
        Positioned(
          width: 28.w,
          height: 28.w,
          right: 16.w,
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.white),
                shape: BoxShape.circle),
            child: Image.asset(R.images_rcd_qmark),
          ),
        )
      ],
    );
  }
}
