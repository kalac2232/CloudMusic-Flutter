import 'package:cloudmusic/page/OnlyTextPager.dart';
import 'package:cloudmusic/utils/HexColor.dart';
import 'package:cloudmusic/widget/SwitchAnimBottomNaviBar.dart';
import 'package:flutter/material.dart';

import 'DiscoverPage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SwitchAnimBottomNaviBarWidget(
        pagers: <Widget>[
          DisCoverPage(),
          OnlyTextPage(text: "页面1",),
          OnlyTextPage(text: "页面2",),
          OnlyTextPage(text: "页面3",),
          OnlyTextPage(text: "页面4",),
        ],
        naviItems: <NaviItemWidget>[
          NetNaviItemWidget(
            text: "发现",
              selectedImage: "images/cm6_btm_icn_discovery_prs_28x28_@3x.png",
              normalImage: "images/cm6_btm_icn_discovery_28x28_@3x.png",

          ),
          NetNaviItemWidget(
            text: "视频",
            selectedImage: "images/cm6_btm_icn_video_prs_28x28_@3x.png",
            normalImage: "images/cm6_btm_icn_video_28x28_@3x.png",

          ),
          NetNaviItemWidget(
            text: "我的",
            selectedImage: "images/cm6_btm_icn_music_prs_28x28_@3x.png",
            normalImage: "images/cm6_btm_icn_music_28x28_@3x.png",

          ),
          NetNaviItemWidget(
            text: "云村",
            selectedImage: "images/cm6_btm_icn_friend_prs_28x28_@3x.png",
            normalImage: "images/cm6_btm_icn_friend_28x28_@3x.png",

          ),
          NetNaviItemWidget(
            text: "账号",
            selectedImage: "images/cm6_btm_icn_account_prs_28x28_@3x.png",
            normalImage: "images/cm6_btm_icn_account_28x28_@3x.png",

          ),
        ],
        barHeight: 50,
      ),
    );
  }
}


Widget _createNormalItem(String image, String text) {
  return Container(
    width: 28,
    height: 43,
    child: Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Positioned(
          top: 0,
          child: Image.asset(
              image, width: 28, height: 28, color: HexColor.fromHex("#969696")),
        ),
        Positioned(
          bottom: 0,
          child: Text(
            text,
            style: TextStyle(
                fontSize: 9,
                color: HexColor.fromHex("#969696")
            ),
          ),
        )
      ],
    ),
  );
}

Widget _createSelectedItem(String image, String text) {
  return Container(
    width: 28,
    height: 43,
    child: Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Positioned(
          top: 0,
          width: 28,
          height: 28,
          child: Stack(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      HexColor.fromHex("#FE5749"),
                      HexColor.fromHex("#FF1F14")
                    ]), //背景渐变
                    shape: BoxShape.circle
                ),
              ),
              Image.asset(image, width: 28, height: 28)
            ],),
        ),
        Positioned(
          bottom: 0,
          child: Text(
            text,
            style: TextStyle(
                fontSize: 9,
                color: HexColor.fromHex("#FF2318")
            ),
          ),
        )
      ],
    ),
  );
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