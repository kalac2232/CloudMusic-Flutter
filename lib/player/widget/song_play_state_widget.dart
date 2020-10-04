import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cloudmusic/commen/bloc/event/player_event.dart';
import 'package:cloudmusic/commen/bloc/player_bloc.dart';
import 'package:cloudmusic/commen/bloc/state/player_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SongPlayStateWidget extends StatefulWidget {
  @override
  __SongPlayStateState createState() => __SongPlayStateState();
}

class __SongPlayStateState extends State<SongPlayStateWidget> {
  double value = 0;
  bool isSeeking = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Positioned(
          left: 15.w,
          child: BlocBuilder<PlayerBloc, PlayerState>(
            builder: (BuildContext context, PlayerState state) {
              return Text(
                state.currentDuration.toString().substring(2, 7),
                style: TextStyle(color: Colors.white, fontSize: 9),
              );
            },
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
            child: BlocBuilder<PlayerBloc, PlayerState>(

              buildWhen: (pre,currentState){
                return !isSeeking;
              },

              builder: (BuildContext context, PlayerState state) {

                if (!isSeeking) {
                  if (state.currentDuration.inMicroseconds == 0) {
                    value = 0;
                  } else {
                    value = state.currentDuration.inMicroseconds ~/
                        state.maxDuration.inMilliseconds /
                        10;
                  }
                }

                return Slider(
                  value: value,
                  onChanged: (v){

                    setState(() {
                      value = v;
                      print(value);
                    });
                  },
                  onChangeStart: (v){
                    isSeeking = true;
                  },
                  onChangeEnd: (v) {
                    isSeeking = false;
                    double seekTo = v / 100;
                    //print(seekTo);
                    context
                        .bloc<PlayerBloc>()
                        .add(PlayerSeekEvent(seekTo: seekTo));
                  },
                  max: 100,
                  min: 0,
                );
              },
            ),
          ),
        ),
        Positioned(
          right: 15.w,
          child: BlocBuilder<PlayerBloc, PlayerState>(

            builder: (BuildContext context, PlayerState state) {
              return Text(
                Duration(milliseconds: state.songBean.duration).toString().substring(2, 7),
                style: TextStyle(color: Colors.white, fontSize: 9),
              );
            },
          ),
        )
      ],
    );
  }
}