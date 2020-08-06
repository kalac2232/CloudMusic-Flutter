
import 'package:flutter_screenutil/screenutil.dart';

import 'commen/utils/hex_color.dart';
import 'package:flutter/material.dart';
import 'generated/r.dart';
import 'discovery/discover_page.dart';
import 'page/only_text_pager.dart';
import 'switch_anim_bottom_navi_bar.dart';

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    print("HomePage");
    ScreenUtil.init(context, width: 375, height: 667);
    return Container(
      child: SwitchAnimBottomNaviBarWidget(
        pagers: <Widget>[
          DisCoverPage(),
          OnlyTextPage(text: "页面1",),
          OnlyTextPage(text: "页面2",),
          OnlyTextPage(text: "页面3",),
          OnlyTextPage(text: "页面4",),
          //OnlyTextPage(text: "页面5",),
        ],
        naviItems: <NaviItemWidget>[
          NetNaviItemWidget(
            text: "发现",
              selectedImage: R.images_cm6_btm_icn_discovery_prs,
              normalImage: R.images_cm6_btm_icn_discovery,

          ),
          NetNaviItemWidget(
            text: "视频",
            selectedImage: R.images_cm6_btm_icn_video_prs,
            normalImage: R.images_cm6_btm_icn_video,

          ),
          NetNaviItemWidget(
            text: "我的",
            selectedImage: R.images_cm6_btm_icn_music_prs,
            normalImage: R.images_cm6_btm_icn_music,

          ),
          NetNaviItemWidget(
            text: "云村",
            selectedImage: R.images_cm6_btm_icn_friend_prs,
            normalImage: R.images_cm6_btm_icn_friend,

          ),
          NetNaviItemWidget(
            text: "账号",
            selectedImage: R.images_cm6_btm_icn_account_prs,
            normalImage: R.images_cm6_btm_icn_account,

          ),
        ],
        barHeight: 50,
      ),
    );
  }
}


class NetNaviItemWidget extends NaviItemWidget {

  String text;
  String normalImage;
  String selectedImage;

  NetNaviItemWidget(
      {@required this.text, @required this.normalImage, this.selectedImage})
      :super(
    selectedIcon: Stack(
      children: <Widget>[
        Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                HexColor.fromHex("#FE5749"),
                HexColor.fromHex("#FF1F14")
              ]), //背景渐变
              shape: BoxShape.circle
          ),
        //color: Colors.red,
        ),
        Image.asset(selectedImage, width: 28, height: 28,)
      ],),
    selectedText: Text(
      text,
      style: TextStyle(
          fontSize: 9,
          color: HexColor.fromHex("#FF2318")
      ),
    ),

    normalIcon: Image.asset(
        normalImage, width: 28, height: 28, color: HexColor.fromHex("#969696")),
    normalText: Text(
      text,
      style: TextStyle(
          fontSize: 9,
          color: HexColor.fromHex("#969696")
      ),
    ),

  );


  @override
  Widget getNormalWidget() {
    return Container(
      //color: Colors.blue,
      width: 28,
      height: 43,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            top: 0,
            width: 28,
            height: 28,
            child: this.normalIcon,
          ),
          Positioned(
            bottom: 0,
            child: this.normalText,
          )
        ],
      ),
    );
  }

  @override
  Widget getSelectWidget() {
    return Container(
      width: 28,
      height: 43,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            top: 0,
            child: this.selectedIcon,
          ),
          Positioned(
            bottom: 0,
            child: this.selectedText,
          )
        ],
      ),
    );
  }

}