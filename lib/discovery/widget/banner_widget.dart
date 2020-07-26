import 'dart:async';

import 'package:cloudmusic/commen/net/http_request.dart';
import 'package:cloudmusic/commen/utils/hex_color.dart';
import 'package:cloudmusic/discovery/bean/banner_bean.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class BannerWidget extends StatefulWidget {
  @override
  _BannerWidgetState createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> {
  List<BannerBean> _bannerBeans = List();
  PageController _pageController;
  Timer _timer;
  int _currIndex = 0;

  @override
  void initState() {
    super.initState();
    //初始化定时器
    _setTimer();

    httpRequest.get(path: "/banner", parameters: {"type": 2}).then((response) {
      response.data["banners"].map((banner) {
        _bannerBeans.add(BannerBean.fromJson(banner));
      }).toList();

      setState(() {
        _pageController = PageController(initialPage: _bannerBeans.length);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return _bannerBeans.isEmpty
        ? Container()
        : Container(
            height: MediaQuery.of(context).size.width / 360 * 134,
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                //banner图
                NotificationListener(
                  onNotification: (Notification notification){
                    if (notification.runtimeType == ScrollStartNotification) {
                      //当滚动开始时，停止定时器
                      _timer.cancel();

                    } else if(notification.runtimeType == ScrollEndNotification){
                      _setTimer();
                    }
                    return false;
                  },
                  child: PageView.builder(
                    controller: _pageController,
                    physics: BouncingScrollPhysics(),
                    onPageChanged: (page) {
                      _currIndex = page % _bannerBeans.length;

                      setState(() {});
                    },
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.only(left: 16, right: 16),
                        child: AspectRatio(
                            aspectRatio: 343 / 134,
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: Image.network(
                                    _bannerBeans[index % _bannerBeans.length]
                                        .pic))),
                      );
                    },
                  ),
                ),
                //指示器
                Positioned(
                  bottom: 6,
                  child: Row(
                    children: _bannerBeans.map((e) {
                      var isSelected = _bannerBeans.indexOf(e) == _currIndex;

                      return Container(
                        width: 6,
                        height: 6,
                        margin: EdgeInsets.only(left: 2, right: 2),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: isSelected
                                ? Theme.of(context).primaryColor
                                : HexColor.fromHex("#80ECECEC")),
                      );
                    }).toList(),
                  ),
                )
              ],
            ),
          );
  }

  _setTimer(){
    _timer = Timer.periodic(Duration(seconds: 5), (t) {
      _pageController?.nextPage(
          duration: Duration(milliseconds: 300), curve: Curves.linear);
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _pageController?.dispose();
    _timer?.cancel();
  }
}
