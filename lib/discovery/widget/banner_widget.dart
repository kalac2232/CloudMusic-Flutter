import 'package:cloudmusic/commen/net/http_request.dart';
import 'package:cloudmusic/discovery/bean/banner_bean.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class BannerWidget extends StatefulWidget {
  @override
  _BannerWidgetState createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> {
  
  @override
  void initState() {
    super.initState();

    httpRequest.get(path: "/banner",parameters: {"type":2}).then((response)  {

      List<BannerBean> banners = response.data["banners"].map((banner) =>BannerBean.fromJson(banner)).toList();
      print(banners[1].pic);
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
