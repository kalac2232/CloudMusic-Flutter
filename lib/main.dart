
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/screenutil.dart';

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

    return MaterialApp(
      initialRoute:"/", //名为"/"的路由作为应用的home(首页)

      theme: ThemeData(
        primaryColor: HexColor.fromHex("#FF1F14"),
      ),
      //注册路由表
      routes:{
        "/":(context) => Scaffold(
          body: HomePage(),
        ),
        "daily_recommend_page":(context) => Scaffold(
          body: DailyRecommendPage(),
        ),
      },
//      home: Scaffold(
//        body: HomePage(),
//      ),
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
