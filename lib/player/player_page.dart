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
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            child: RepaintBoundary(child: _Background()),
          ),
          Positioned(
            //top: 0,
            width: 375.w,
            height: 516.w + MediaQuery.of(context).padding.top,
            child: _RecordWidget(),
          ),
          Positioned(
            top: MediaQuery.of(context).padding.top,
            height: 44.w,
            width: 375.w,
            child: _TopBar(),
          ),
          Positioned(
            width: 375.w,
            bottom: 122.h,
            child: _ExtraButtons(),
          ),
          Positioned(
            width: 375.w,
            height: 13.h,
            bottom: 85.h,
            child: _SongPlayState(),
          ),
          Positioned(
            width: 375.w,
            height: 60.h,
            bottom: 16.h,
            child: _ControllerButtons(),
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
class _ExtraButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 16.w,right: 16.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Image.asset(R.images_play_icn_love,width: 28.w,height: 28.w,),
          Image.asset(R.images_play_icn_dld,width: 28.w,height: 28.w,),
          Image.asset(R.images_topbar_icn_karaoke2,width: 28.w,height: 28.w,),
          Image.asset(R.images_play_icn_cmt_num,width: 28.w,height: 28.w,),
          Image.asset(R.images_play_icn_more,width: 28.w,height: 28.w,),
        ],
      ),
    );
  }
}



class _Background extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Positioned(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Image.network(
              "http://p3.music.126.net/mwCUI0iL3xEC2a4WVICHlA==/109951163115369030.jpg?param=150y150",
              fit: BoxFit.fitHeight,
            )),
        Positioned(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child:Container(
                color: Colors.black.withOpacity(0.5),

              ),
            )),
      ],
    );
  }
}

class _SongPlayState extends StatefulWidget {
  @override
  __SongPlayStateState createState() => __SongPlayStateState();
}

class __SongPlayStateState extends State<_SongPlayState> {

  double value = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Positioned(
          left: 15.w,
          child: Text("00:00",style: TextStyle(
              color: Colors.white,
              fontSize: 9
          ),),
        ),
        Positioned(
          width: 280.w,
          height: 8.w,
          child:  SliderTheme( //自定义风格
            data: SliderTheme.of(context).copyWith(
                activeTrackColor: Colors.white.withOpacity(0.5), //进度条滑块左边颜色
                inactiveTrackColor: Colors.white.withOpacity(0.15), //进度条滑块右边颜色
                //trackShape: RoundSliderTrackShape(radius: 10),//进度条形状,这边自定义两头显示圆角
                thumbColor: Colors.white, //滑块颜色
                overlayColor: Colors.white, //滑块拖拽时外圈的颜色
                overlayShape: RoundSliderOverlayShape(//可继承SliderComponentShape自定义形状
                  overlayRadius: 6.w, //滑块外圈大小
                ),
                thumbShape: RoundSliderThumbShape(//可继承SliderComponentShape自定义形状
                  disabledThumbRadius: 2.w, //禁用是滑块大小
                  enabledThumbRadius: 4.w, //滑块大小
                ),
                trackHeight: 2.w //进度条宽度

            ),
            child: Slider(
              value: value??0,
              onChanged: (v) {
                setState(() => value = v);
              },
              max: 100,
              min: 0,
            ),
          )
          ,
        ),
        Positioned(
          right: 15.w,
          child: Text("03:59",style: TextStyle(
              color: Colors.white,
              fontSize: 9
          ),),
        )
      ],
    );
  }
}

class _RecordWidget extends StatefulWidget {


  @override
  _RecordWidgetState createState() => _RecordWidgetState();
}

class _RecordWidgetState extends State<_RecordWidget> {

  PageController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PageController();

    _controller.addListener(() {
      //print(_controller.);
    });
  }

  @override
  Widget build(BuildContext context) {

    return Stack(
      alignment: Alignment.topCenter,
      children: <Widget>[
        Positioned(
          top: 137.w - 44.w,
          width: 306.w,
          height: 306.w,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.05),
              shape: BoxShape.circle,
            ),
          ),
        ),
        Positioned(
          top: 127.w - 44.w,
          width: 375.w,
          height: 326.w,
          child: NotificationListener(
            onNotification: (Notification notification){
              if (notification.runtimeType == ScrollStartNotification) {
                //当滚动开始时，停止定时器
                print("滚动开始");
              } else if (notification.runtimeType ==
                  ScrollEndNotification) {
                print("滚动结束");
              }
              return false;
            },
            child: PageView.builder(controller:_controller,itemBuilder: (context,index){
              return Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Container(
                    width: 194.w,
                    height: 194.w,
                    child: Image.network("http://p3.music.126.net/mwCUI0iL3xEC2a4WVICHlA==/109951163115369030.jpg?param=500y500"),
                  ),
                  Container(
                    width: 326.w,
                    height: 326.w,
                    child: Image.asset(R.images_play_disc),
                  )
                ],
              );
            }),
          ),
        ),
        Positioned(
          top: -83.w - 44.w,
          width: 298.w,
          height: 298.w,
          child: Transform.rotate(angle: -math.pi / 6,child: Image.asset(R.images_play_needle_play)),
        ),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller?.dispose();
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
          child: Image.asset(R.images_list_detail_icn_share),
        )
      ],
    );
  }
}

class _ControllerButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Positioned(
          width: 28.w,
          height: 28.w,
          left: 25.w,
          child: Image.asset(R.images_icn_loop),
        ),
        Positioned(
          width: 28.w,
          height: 28.w,
          left: 100.w,
          child: Transform.rotate(angle: math.pi,child: Image.asset(R.images_fm_btn_next)),
        ),
        Positioned(
          width: 60.w,
          height: 60.w,
          child: Image.asset(R.images_fm_btn_play),
        ),
        Positioned(
          width: 28.w,
          height: 28.w,
          right: 100.w,
          child: Image.asset(R.images_fm_btn_next),
        ),
        Positioned(
          width: 28.w,
          height: 28.w,
          right: 25.w,
          child: Image.asset(R.images_icn_list),
        ),
      ],
    );
  }
}

