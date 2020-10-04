import 'package:cloudmusic/commen/bloc/event/player_event.dart';
import 'package:cloudmusic/commen/bloc/player_bloc.dart';
import 'package:cloudmusic/commen/bloc/state/player_state.dart';
import 'package:cloudmusic/discovery/bean/song_bean.dart';
import 'package:cloudmusic/generated/r.dart';
import 'package:cloudmusic/player/play_list_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RecordWidget extends StatefulWidget {
  @override
  _RecordWidgetState createState() => _RecordWidgetState();
}

class _RecordWidgetState extends State<RecordWidget>
    with TickerProviderStateMixin {
  PageController _pageController;
  AnimationController _animationController;
  Animation _animation;

  double _lastPageIndex;

  bool _buttonTriggerEvent = false;

  PlayerState _currentState = PlayerInitialState();
  List _albumItemWidgetKeyList;

  bool _isScrolling = false;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: PlayListManager.getInstance().currentIndex);
    _animationController = AnimationController(
        duration: const Duration(milliseconds: 300), vsync: this);
    _animation =
        new Tween(begin: -0.083, end: 0.0).animate(_animationController);

    _pageController.addListener(() {
      //print(_controller.);
    });
    _lastPageIndex = 0;

    _albumItemWidgetKeyList = List();

    for (int i = 0; i < PlayListManager.getInstance().list.length; i++) {
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
            listener: (context, state) {
              _currentState = state;

              if (_isScrolling) {
                return;
              }
              _handleStateChangeEvent(context, state);

//              if (state is! PlayerPauseState && state is! PlayerInitialState) {
//                _animationController.forward();
//              }
            },
            child: NotificationListener(
              onNotification: (Notification notification) {
                if (notification.runtimeType == ScrollStartNotification) {
                  //当滚动开始时，
                  print("滚动开始");

                  _isScrolling = true;

                  if (_currentState is! PlayerPauseState) {
                    _animationController.reverse();
                    _albumItemWidgetKeyList[_pageController.page.toInt()]
                        .currentState
                        .stopRotation();
                  }
                } else if (notification.runtimeType == ScrollEndNotification) {
                  print("滚动结束");
                  _isScrolling = false;

                  if (_pageController.page > _lastPageIndex) {
                    print("向右滚");

                    if (!_buttonTriggerEvent) {
                      context
                          .bloc<PlayerBloc>()
                          .add(PlayerNextEvent()..isChangePageView = false);
                    }
                  } else if (_pageController.page < _lastPageIndex) {
                    print("向左滚");
                    if (!_buttonTriggerEvent) {
                      context
                          .bloc<PlayerBloc>()
                          .add(PlayerPreviousEvent()..isChangePageView = false);
                    }
                  } else {
                    print("没动");
                    if (_currentState is! PlayerPauseState && _currentState is! PlayerInitialState) {
                      _animationController?.forward();
                      _albumItemWidgetKeyList[_pageController.page.toInt()]
                          .currentState
                          .startRotation();
                    }
                  }

                  _buttonTriggerEvent = false;

                  _lastPageIndex = _pageController.page;
                }
                return false;
              },
              child: PageView.builder(
                  controller: _pageController,
                  itemCount: PlayListManager.getInstance().list.length,
                  itemBuilder: (context, index) {
                    return _AlbumItemWidget(
                      songBean: PlayListManager.getInstance().list[index],
                      key: _albumItemWidgetKeyList[index],
                    );
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
    } else if (state is PlayerRunInProgressState) {
      _animationController.forward();
      _albumItemWidgetKeyList[_pageController.page.toInt()]
          .currentState
          .startRotation();
    } else if (state is PlayerPauseState || state is PlayerCompleteState) {
      _animationController.reverse();
      _albumItemWidgetKeyList[_pageController.page.toInt()]
          .currentState
          .stopRotation();
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
            duration: Duration(milliseconds: 300), curve: Curves.linear);
        _buttonTriggerEvent = true;
      }
    } else if (state.event is PlayerPreviousEvent) {
      PlayerPreviousEvent e = state.event;
      if (e.isChangePageView) {
        _pageController?.previousPage(
            duration: Duration(milliseconds: 300), curve: Curves.linear);
        _buttonTriggerEvent = true;
      }
    }
  }
}

class _AlbumItemWidget extends StatefulWidget {
  SongBean songBean;

  _AlbumItemWidget({this.songBean,Key key}) : super(key: key);

  @override
  _AlbumItemWidgetState createState() => _AlbumItemWidgetState();
}

class _AlbumItemWidgetState extends State<_AlbumItemWidget>
    with TickerProviderStateMixin {
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(duration: const Duration(seconds: 20), vsync: this);

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
                widget.songBean.picUrl+"?param=500y500"),
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

  void stopRotation() {
    _animationController.stop();
    print("stopRotation");
  }

  void startRotation() {
    if (_animationController.isAnimating) {
      return;
    }

    print("startRotation");
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