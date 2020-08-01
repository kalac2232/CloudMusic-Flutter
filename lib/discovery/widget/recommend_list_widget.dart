import 'package:cloudmusic/commen/utils/hex_color.dart';
import 'package:flutter/material.dart';

class RecommendListWidget extends StatelessWidget {


  ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {

    _scrollController.addListener(() {
      print(_scrollController.offset); //打印滚动位置

      if(_scrollController.offset > 400) {
        _scrollController.animateTo(400, duration: Duration(microseconds: 1000), curve:Curves.linear);
      }

    });
    return Container(
      height: 183,
      child: Stack(
        children: <Widget>[
          Positioned(
            left: 16,
            top: 0,
            child: Text(
              "人气歌单推荐",
              style: TextStyle(
                  fontSize: 18,
                  color: HexColor.fromHex("#000000"),
                  fontWeight: FontWeight.bold),
            ),
          ),
          //加载更多按钮
          Positioned(
            right: 16,
            top: 0,
            child: Container(
              width: 76,
              height: 25,
              decoration: BoxDecoration(
                  border:
                      Border.all(color: HexColor.fromHex("#E6E6E6"), width: 1),
                  borderRadius: BorderRadius.circular(12.5)),
              alignment: Alignment.center,
              child: Text(
                "查看更多",
                style:
                    TextStyle(color: HexColor.fromHex("#333333"), fontSize: 13),
              ),
            ),
          ),
          //歌单listview
          Positioned(
            top: 38,
            width: MediaQuery.of(context).size.width,
            height: 145,
            child: ListView.separated(
              padding: EdgeInsets.only(left: 16,right: 26),
              itemCount: 6,

              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                double witdh = (MediaQuery.of(context).size.width - 16 -26 - 9 * 2) / 3;

                return Container(
                  width: witdh,
                  height: 145,
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        top: 0,
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(
                                    "https://p1.music.126.net/qZ25SAx2rhH-Qpsb1DWZZg==/109951165188459074.jpg"),
                                fit: BoxFit.cover),
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0)),
                            //color: Colors.red
                          ),
                          width: witdh,
                          height: witdh,
                        ),
                      )
                    ],
                  ),
                );
              },
              separatorBuilder: (context,index){
                return SizedBox(
                  width: 9,
                  height: 1,
                );
              },

              //controller:_scrollController,
            ),
          )
        ],
      ),
    );
  }
}
