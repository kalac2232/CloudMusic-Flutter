import 'dart:async';

import 'package:cloudmusic/commen/net/http_request.dart';
import 'package:cloudmusic/commen/utils/hex_color.dart';
import 'package:cloudmusic/discovery/bean/banner_bean.dart';
import 'package:cloudmusic/discovery/bloc/cubit/banner_cubit.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BannerWidget extends StatefulWidget {
  @override
  _BannerWidgetState createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> {
  PageController _pageController;
  Timer _timer;
  int _currIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.width / 360 * 134,
      child: BlocBuilder<BannerCubit, List<BannerBean>>(
        builder: (BuildContext context, List<BannerBean> banners) {
          if (banners.isEmpty) {
            return Container();
          }

          //初始化定时器
          _setTimer();

          _pageController = PageController(initialPage: banners.length);

          return Stack(
            alignment: Alignment.center,
            children: <Widget>[
              //banner图
              NotificationListener(
                onNotification: (Notification notification) {
                  if (notification.runtimeType == ScrollStartNotification) {
                    //当滚动开始时，停止定时器
                    _timer.cancel();
                  } else if (notification.runtimeType ==
                      ScrollEndNotification) {
                    _setTimer();
                  }
                  return false;
                },
                child: PageView.builder(
                  controller: _pageController,
                  physics: BouncingScrollPhysics(),
                  onPageChanged: (page) {
                    _currIndex = page % banners.length;

                    setState(() {});
                  },
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.only(left: 16, right: 16),
                      child: AspectRatio(
                          aspectRatio: 343 / 134,
                          child: Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(banners[index % banners.length].pic),
                                    fit: BoxFit.cover,
                                  ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8.0),
                                ),
                              ),
                              //child: Image.network(banners[index % banners.length].pic)
                          )
                      ),
                    );
                  },
                ),
              ),
              //指示器
              Positioned(
                bottom: 6,
                child: Row(
                  children: banners.map((e) {
                    var isSelected = banners.indexOf(e) == _currIndex;

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
          );
        },
      ),
    );
  }

  _setTimer() {
    if (_timer != null) {
      _timer.cancel();
    }

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
