import 'package:cloudmusic/commen/net/http_request.dart';
import 'package:cloudmusic/discovery/bean/banner_bean.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class BannerWidget extends StatefulWidget {
  @override
  _BannerWidgetState createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> {
  List<BannerBean> _banners = List();

  @override
  void initState() {
    super.initState();

    httpRequest.get(path: "/banner",parameters: {"type":2}).then((response)  {

      response.data["banners"].map((banner) {
        _banners.add(BannerBean.fromJson(banner));
      }).toList();

      print(_banners[1].pic);
    });

    
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 134,
      color: Colors.red,
    );
  }
}
