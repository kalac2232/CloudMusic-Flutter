
import 'package:cloudmusic/player/player_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/screenutil.dart';

import 'discovery/bloc/cubit/mini_player_bloc.dart';
import 'discovery/bloc/event/commen_event.dart';
import 'discovery/daily_recommend_page.dart';
import 'home_page.dart';
import 'commen/utils/hex_color.dart';


void main() {
  //Bloc.observer = SimpleBlocObserver();
  print("main");

  runApp( MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // 因为MiniPlayer是使用Overlay添加到屏幕上的，而Overlay在MaterialApp创建时会自动创建一个默认的，
    // 所以在使用Overlay添加到的widget中的content是创建MaterialApp时的content，要想在MiniPlayer中
    // 接收bloc事件，必须在创建MaterialApp时传入Bloc的Content（以上均为猜测）
    // https://juejin.im/post/6844903749534810119#heading-7
    return BlocProvider<MiniPlayerBloc>(
      create: (BuildContext context) => MiniPlayerBloc(MiniPlayerWidgetControlEvent.visible),
      child: MaterialApp(

        //checkerboardRasterCacheImages: true,

        initialRoute:"/", //名为"/"的路由作为应用的home(首页)

        theme: ThemeData(
          primaryColor: HexColor.fromHex("#FF1F14"),
          platform: TargetPlatform.iOS,
        ),
        //注册路由表
        routes:{
          //主页
          "/":(context) => Scaffold(
            body: HomePage(),
          ),
          //每日日推
          "daily_recommend_page":(context) => Scaffold(
            body: DailyRecommendPage(),
          ),
          "player_page":(context) => PlayerPager(),
        },
//      home: Scaffold(
//        body: HomePage(),
//      ),
      ),
    );

  }

}

class SimpleBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object event) {
    print("onEvent"+event.toString());
    super.onEvent(bloc, event);
  }

  @override
  void onChange(Cubit cubit, Change change) {
    print("onChange"+change.toString());
    super.onChange(cubit, change);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    print(transition);
    super.onTransition(bloc, transition);
  }

  @override
  void onError(Cubit cubit, Object error, StackTrace stackTrace) {
    print(error);
    super.onError(cubit, error, stackTrace);
  }
}
