import 'dart:ui';

import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:cloudmusic/commen/bloc/event/player_event.dart';
import 'package:cloudmusic/commen/bloc/player_bloc.dart';
import 'package:cloudmusic/commen/bloc/state/player_state.dart';
import 'package:cloudmusic/commen/only_text_pager.dart';
import 'package:cloudmusic/commen/widget/click_widget.dart';
import 'package:cloudmusic/discovery/bloc/cubit/mini_player_bloc.dart';
import 'package:cloudmusic/commen/bloc/event/commen_event.dart';
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
            height: 60.w,
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
      margin: EdgeInsets.only(left: 16.w, right: 16.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Image.asset(
            R.images_play_icn_love,
            width: 28.w,
            height: 28.w,
          ),
          Image.asset(
            R.images_play_icn_dld,
            width: 28.w,
            height: 28.w,
          ),
          Image.asset(
            R.images_topbar_icn_karaoke2,
            width: 28.w,
            height: 28.w,
          ),
          Image.asset(
            R.images_play_icn_cmt_num,
            width: 28.w,
            height: 28.w,
          ),
          Image.asset(
            R.images_play_icn_more,
            width: 28.w,
            height: 28.w,
          ),
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
          child: Container(
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
          child: Text(
            "00:00",
            style: TextStyle(color: Colors.white, fontSize: 9),
          ),
        ),
        Positioned(
          width: 280.w,
          height: 8.w,
          child: SliderTheme(
            //自定义风格
            data: SliderTheme.of(context).copyWith(
                activeTrackColor: Colors.white.withOpacity(0.5),
                //进度条滑块左边颜色
                inactiveTrackColor: Colors.white.withOpacity(0.15),
                //进度条滑块右边颜色
                //trackShape: RoundSliderTrackShape(radius: 10),//进度条形状,这边自定义两头显示圆角
                thumbColor: Colors.white,
                //滑块颜色
                overlayColor: Colors.white,
                //滑块拖拽时外圈的颜色
                overlayShape: RoundSliderOverlayShape(
                  //可继承SliderComponentShape自定义形状
                  overlayRadius: 6.w, //滑块外圈大小
                ),
                thumbShape: RoundSliderThumbShape(
                  //可继承SliderComponentShape自定义形状
                  disabledThumbRadius: 2.w, //禁用是滑块大小
                  enabledThumbRadius: 4.w, //滑块大小
                ),
                trackHeight: 2.w //进度条宽度

                ),
            child: Slider(
              value: value ?? 0,
              onChanged: (v) {
                setState(() => value = v);
              },
              max: 100,
              min: 0,
            ),
          ),
        ),
        Positioned(
          right: 15.w,
          child: Text(
            "03:59",
            style: TextStyle(color: Colors.white, fontSize: 9),
          ),
        )
      ],
    );
  }
}

class _RecordWidget extends StatefulWidget {
  @override
  _RecordWidgetState createState() => _RecordWidgetState();
}


class _RecordWidgetState extends State<_RecordWidget>
    with TickerProviderStateMixin {
  PageController _pageController;
  AnimationController _animationController;
  Animation _animation;

  double _lastPageIndex;

  bool _buttonTriggerEvent = false;

  PlayerState _currentState = PlayerInitialState();
  List _albumItemWidgetKeyList;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _animationController = AnimationController(
        duration: const Duration(milliseconds: 300), vsync: this);
    _animation =
        new Tween(begin: -0.083, end: 0.0).animate(_animationController);

    _pageController.addListener(() {
      //print(_controller.);
    });
    _lastPageIndex = 0;

    _albumItemWidgetKeyList = List();

    for(int i = 0; i < 10; i++) {
      _albumItemWidgetKeyList.add(GlobalKey());
    }

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
          child: BlocListener<PlayerBloc, PlayerState>(
            listener: (context,state){
              _currentState = state;
              _handleStateChangeEvent(context,state);

              if(state is! PlayerPauseState && state is! PlayerInitialState){
                _animationController.forward();
              }

              if (state is PlayerRunInProgressState) {
                _albumItemWidgetKeyList[_pageController.page.toInt()].currentState.startRotation();
              } else {
                _albumItemWidgetKeyList[_pageController.page.toInt()].currentState.stopRotation();
              }

            },
            child: NotificationListener(
              onNotification: (Notification notification) {
                if (notification.runtimeType == ScrollStartNotification) {
                  //当滚动开始时，
                  print("滚动开始");
                  if(_currentState is! PlayerPauseState) {
                    _animationController.reverse();
                    _albumItemWidgetKeyList[_pageController.page.toInt()].currentState.stopRotation();
                  }


                } else if (notification.runtimeType == ScrollEndNotification) {
                  print("滚动结束");

                  if (_pageController.page > _lastPageIndex) {
                    print("向右滚");

                    if (!_buttonTriggerEvent) {

                      context.bloc<PlayerBloc>().add(PlayerNextEvent()..isChangePageView = false);
                    }


                  } else if(_pageController.page < _lastPageIndex){
                    print("向左滚");
                    if (!_buttonTriggerEvent) {

                      context.bloc<PlayerBloc>().add(PlayerPreviousEvent()..isChangePageView = false);
                    }
                  } else {
                    print("没动");
                    if(_currentState is! PlayerPauseState) {
                      _animationController?.forward();
                      _albumItemWidgetKeyList[_pageController.page.toInt()].currentState.startRotation();
                    }

                  }

                  _buttonTriggerEvent = false;

                  _lastPageIndex = _pageController.page;
                }
                return false;
              },
              child: PageView.builder(
                  controller: _pageController,
                  itemCount: 10,
                  itemBuilder: (context, index) {

                    return _AlbumItemWidget(key: _albumItemWidgetKeyList[index],);
                  }),
            ),
          ),
        ),
        Positioned(
          top: -83.w - 44.w,
          width: 298.w,
          height: 298.w,
          child: RotationTransition(
              turns: _animation, child: Image.asset(R.images_play_needle_play)),
        ),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
    _pageController?.dispose();
    _animationController?.dispose();
  }

  void _handleStateChangeEvent(BuildContext context, PlayerState state) {
    print("listener收到事件" + state.toString());
    if (state is PlayerInitialState) {
      _handlePageViewChangeState(state);

    } else if(state is PlayerRunInProgressState) {
      _animationController.forward();
    } else if(state is PlayerPauseState) {
      _animationController.reverse();
    }
  }

  ///
  /// 处理下一首后viewpage的切换动作
  ///
  void _handlePageViewChangeState(PlayerInitialState state) {
    //如果状态改为了初始状态，则判断下是不是因切换歌曲而进行的状态改变，进而改变动画
    if (state.event is PlayerNextEvent) {

      PlayerNextEvent e = state.event;
      if (e.isChangePageView) {
        _pageController?.nextPage(
            duration: Duration(milliseconds: 300),
            curve: Curves.linear);
        _buttonTriggerEvent = true;
      }


    } else if (state.event is PlayerPreviousEvent) {
      PlayerPreviousEvent e = state.event;
      if (e.isChangePageView) {
        _pageController?.previousPage(
            duration: Duration(milliseconds: 300),
            curve: Curves.linear);
        _buttonTriggerEvent = true;
      }


    }
  }
}

class _AlbumItemWidget extends StatefulWidget {

  _AlbumItemWidget({Key key}) : super(key:key);
  @override
  _AlbumItemWidgetState createState() => _AlbumItemWidgetState();
}

class _AlbumItemWidgetState extends State<_AlbumItemWidget> with TickerProviderStateMixin {

  AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        duration: const Duration(seconds: 20), vsync: this);

    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        //动画从 controller.forward() 正向执行 结束时会回调此方法
        //重置起点
        _animationController.reset();
        //开启
        _animationController.forward();
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      //设置动画的旋转中心
      alignment: Alignment.center,
      turns: _animationController,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Container(
            width: 194.w,
            height: 194.w,
            child: Image.network(
                "http://p3.music.126.net/mwCUI0iL3xEC2a4WVICHlA==/109951163115369030.jpg?param=500y500"),
          ),
          Container(
            width: 326.w,
            height: 326.w,
            child: Image.asset(R.images_play_disc),
          )
        ],
      ),

    );
  }

  void stopRotation(){
    _animationController.stop();
  }

  void startRotation() {

    new Future.delayed(Duration(milliseconds: 300)).then((value) {
      _animationController.forward();
    });
  }

  @override
  void dispose() {

    _animationController?.dispose();
    super.dispose();
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
    return BlocBuilder<PlayerBloc,PlayerState>(
      builder: (BuildContext context, PlayerState state) {

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
              child: ClickWidget(
                  onClick: () {
                    context.bloc<PlayerBloc>().add(PlayerPreviousEvent());
                  },
                  child: Transform.rotate(
                      angle: math.pi, child: Image.asset(R.images_fm_btn_next))),
            ),
            Positioned(
              width: 60.w,
              height: 60.w,
              child: ClickWidget(onClick:(){
                if (state is PlayerInitialState){
                  context.bloc<PlayerBloc>().add(PlayerStartedEvent());
                } else if(state is PlayerRunInProgressState) {
                  context.bloc<PlayerBloc>().add(PlayerPausedEvent());
                } else if(state is PlayerPauseState) {
                  context.bloc<PlayerBloc>().add(PlayerResumedEvent());
                }

              },child: Image.asset(state is PlayerRunInProgressState ? R.images_fm_btn_pause : R.images_fm_btn_play )),
            ),
            Positioned(
              width: 28.w,
              height: 28.w,
              right: 100.w,
              child: ClickWidget(
                  onClick: () {
                    print("点击了");
                    context.bloc<PlayerBloc>().add(PlayerNextEvent());
                  },
                  child: Image.asset(R.images_fm_btn_next)),
            ),
            Positioned(
              width: 28.w,
              height: 28.w,
              right: 25.w,
              child: Image.asset(R.images_icn_list),
            ),
          ],
        );
      },
    );
  }
}
