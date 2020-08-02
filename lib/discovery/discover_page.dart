import 'package:cloudmusic/discovery/widget/category_song_widget.dart';
import 'package:cloudmusic/discovery/widget/discover_new_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cloudmusic/commen/net/http_request.dart';
import 'package:cloudmusic/commen/utils/hex_color.dart';
import 'package:cloudmusic/discovery/bean/banner_bean.dart';
import 'package:cloudmusic/discovery/bean/recommend_list_bean.dart';
import 'bloc/cubit/recommed_list_cubit.dart';
import 'package:cloudmusic/discovery/bloc/event/discovery_event.dart';
import 'package:cloudmusic/discovery/widget/banner_widget.dart';
import 'package:cloudmusic/discovery/widget/dragon_boll_widget.dart';
import 'package:cloudmusic/discovery/widget/recommend_list_widget.dart';
import 'package:cloudmusic/generated/r.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/cubit/banner_cubit.dart';

class DisCoverPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider(
      providers: [
        BlocProvider<BannerCubit>(
          create: (BuildContext context) => BannerCubit(),
        ),
        BlocProvider<RecommendListCubit>(
          create: (BuildContext context) => RecommendListCubit(),
        ),
//        BlocProvider<BlocC>(
//          create: (BuildContext context) => BlocC(),
//        ),
      ],
      child: _WrapDisCoverPage(),
    );
  }
}

class _WrapDisCoverPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    //获取banner
    getBannerFromNet(context);
    //获取推荐歌单
    getRecommendListFromNet(context);
    return SafeArea(
      child: Container(
        color: Colors.white,
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 0,
                left: 0,
                right: 0,
                child: MainTopBar()
            ),
            Positioned(
              top: 44.h,
              bottom: 0,
              width: MediaQuery.of(context).size.width,
              child: CustomScrollView(
                slivers: <Widget>[
                  SliverToBoxAdapter(
                    child: Column(
                      children: <Widget>[
                        Padding(child: BannerWidget(),padding: EdgeInsets.only(top:16.h),),
                        DragBollButtons(),
                        Padding(child: RecommendListWidget(),padding: EdgeInsets.only(top:27.h)),
                        Padding(child: CategorySongWidget(),padding: EdgeInsets.only(top:34.h)),
                        Padding(child: DiscoverNewWidget(),padding: EdgeInsets.only(top:34.h)),
                      ],
                    ),
                  )
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }

}


class MainTopBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44.h,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            left: 16.w,
            top: 8,
            width: 28,
            height: 28,
            child: Image.asset(R.images_cm6_nav_icn_mic),
          ),
          Positioned(
            //搜索框
            child: Container(
              width: 260,
              height: 36,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: HexColor.fromHex("#F7F7F7"),
                borderRadius: BorderRadius.circular(18.0), //3像素圆角
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0.0,0.0,1.0,0.0),
                    child: Image.asset(R.images_3dTouchSearch,width: 22.5,height: 22.5,color: HexColor.fromHex("#949595"),),
                  ),
                  Text(
                    "Collide - Jake Miller",
                    style: TextStyle(
                        color: HexColor.fromHex("#C6C6C6"),
                        fontSize: 14
                    ),
                  )
                ],
              ),
            ),
          ),
          Positioned(
            width: 30,
            height: 30,
            right: 12,
            child: Container(
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: HexColor.fromHex("#949595")
              ),
            ),
          )
        ],
      ),
    );
  }
}
///
/// 分类按钮组
///
class DragBollButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //获取当前日期
    var day = DateTime.now().day;
    print("day：$day");
    return Container(
      //color: Colors.red,
      padding: EdgeInsets.only(left: 16,right: 16,top: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Stack(
            alignment: Alignment.center,
            children: <Widget>[
              DragonBollWidget(text: "每日推荐",icon: R.images_cm6_disc_topbtn_daily,onTap: ()=>print("asdasdasd"),),
              Positioned(
                top: 19,
                child: Text(day.toString(),style: TextStyle(color: HexColor.fromHex("#FF3D3D"),fontSize: 10),),
              )
            ],
          ),
          DragonBollWidget(text: "歌单",icon: R.images_cm6_disc_topbtn_playlist,onTap: ()=>print("asdasdasd")),
          DragonBollWidget(text: "排行榜",icon: R.images_cm6_disc_topbtn_rank,onTap: ()=>print("asdasdasd")),
          DragonBollWidget(text: "电台",icon: R.images_cm6_disc_topbtn_radio,onTap: ()=>print("asdasdasd")),
          DragonBollWidget(text: "直播",icon: R.images_cm6_disc_topbtn_live,onTap: ()=>print("asdasdasd")),
        ],
      ),
    );
  }
}




void getBannerFromNet(BuildContext context){
  List<BannerBean> _bannerBeans = List();

  httpRequest.get(path: "/banner", parameters: {"type": 2}).then((response) {
    response.data["banners"].map((banner) {
      _bannerBeans.add(BannerBean.fromJson(banner));
    }).toList();

    //context.bloc<BannerBloc>().add(BannerEvent(_bannerBeans));
    context.bloc<BannerCubit>().setBanner(_bannerBeans);
  });
}

void getRecommendListFromNet(BuildContext context){
  List<RecommendListBean> _list = List();

  httpRequest.get(path: "/personalized", parameters: {"limit": 6}).then((response) {
    response.data["result"].map((banner) {
      _list.add(RecommendListBean.fromJson(banner));
    }).toList();

    //context.bloc<BannerBloc>().add(BannerEvent(_bannerBeans));
    context.bloc<RecommendListCubit>().setList(_list);
  });
}