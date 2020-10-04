import 'dart:ui';

import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:cloudmusic/commen/bloc/event/player_event.dart';
import 'package:cloudmusic/commen/bloc/player_bloc.dart';
import 'package:cloudmusic/commen/bloc/state/player_state.dart';
import 'package:cloudmusic/commen/only_text_pager.dart';
import 'package:cloudmusic/commen/widget/back_btn.dart';
import 'package:cloudmusic/commen/widget/click_widget.dart';
import 'package:cloudmusic/discovery/bloc/cubit/mini_player_bloc.dart';
import 'package:cloudmusic/commen/bloc/event/commen_event.dart';
import 'package:cloudmusic/generated/r.dart';
import 'package:cloudmusic/player/widget/record_widget.dart';
import 'package:cloudmusic/player/widget/song_play_state_widget.dart';
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
            child: RecordWidget(),
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
            child: SongPlayStateWidget(),
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
    return BlocBuilder<PlayerBloc, PlayerState>(
      buildWhen: (previousState, state) {
        return state is PlayerInitialState;
      },
      builder: (BuildContext context, PlayerState state) {
        return Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Positioned(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Image.network(
                  state.songBean.picUrl + "?param=150y150",
                  gaplessPlayback: true,
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
      },
    );
  }
}


class _TopBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlayerBloc, PlayerState>(
      buildWhen: (previousState, state) {
        return state is PlayerInitialState;
      },
      builder: (BuildContext context, PlayerState state) {
        return Stack(
          alignment: Alignment.center,
          children: <Widget>[
            BackBtn(context),
            Positioned(
              top: 4.w,
              child: Text(
                state.songBean.name,
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
                      state.songBean.getArtistsStr(),
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
      },
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
            child: BlocBuilder<PlayerBloc, PlayerState>(
              builder: (BuildContext context, PlayerState state) {
                return ClickWidget(
                    onClick: () {
                      if (state is PlayerInitialState || state is PlayerCompleteState) {
                        context.bloc<PlayerBloc>().add(PlayerStartedEvent());
                      } else if (state is PlayerRunInProgressState) {
                        context.bloc<PlayerBloc>().add(PlayerPausedEvent());
                      } else if (state is PlayerPauseState) {
                        context.bloc<PlayerBloc>().add(PlayerResumedEvent());
                      }
                    },
                    child: Image.asset(state is PlayerRunInProgressState
                        ? R.images_fm_btn_pause
                        : R.images_fm_btn_play));
              },
            )),
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
  }
}
