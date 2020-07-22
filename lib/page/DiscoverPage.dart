import 'package:cloudmusic/utils/HexColor.dart';
import 'package:flutter/material.dart';

class DisCoverPage extends StatefulWidget {
  @override
  _DisCoverPageState createState() => _DisCoverPageState();
}

class _DisCoverPageState extends State<DisCoverPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            MainTopBar(),
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
      height: 44,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            left: 16,
            top: 8,
            width: 28,
            height: 28,
            child: Image.asset("images/cm6_nav_icn_mic_28x28_@3x.png"),
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
                    child: Image.asset("images/3dTouchSearch_35x35_@3x.png",width: 22.5,height: 22.5,color: HexColor.fromHex("#949595"),),
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
