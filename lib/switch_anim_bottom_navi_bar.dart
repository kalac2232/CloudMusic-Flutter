
import 'package:flutter/material.dart';

import 'commen/utils/hex_color.dart';

class SwitchAnimBottomNaviBarWidget extends StatefulWidget {
  //切换的界面
  List<Widget> pagers;

  //底部Item
  List<NaviItemWidget> naviItems;

  double barHeight;

  SwitchAnimBottomNaviBarWidget(
      {@required this.pagers, @required this.naviItems, this.barHeight = 40.0})
      : assert(pagers != null);

  @override
  _SwitchAnimBottomNaviBarWidgetState createState() =>
      _SwitchAnimBottomNaviBarWidgetState();
}

class _SwitchAnimBottomNaviBarWidgetState
    extends State<SwitchAnimBottomNaviBarWidget> with SingleTickerProviderStateMixin {
  int _currentPageIndex = 0;

  //动画控制器
  AnimationController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();


  }


  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: widget.barHeight,
            child: Container(
              color: Colors.white,
              child: IndexedStack(
                index: _currentPageIndex,
                children: widget.pagers,
              ),
            )),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          height: widget.barHeight,
          child: Container(
            color: HexColor.fromHex("#F8F8F8"),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: widget.naviItems.map((e) {
                bool isSelected =
                    widget.naviItems.indexOf(e) == _currentPageIndex;

                if (isSelected && controller != null && e.selectedIcon is! ScaleTransition) {
                  e.selectedIcon = _addScaleAnim(e.selectedIcon);
                  //print(""+e.selectedIcon.toString());
                }

                return Expanded(
                  child: _addClick(widget.naviItems.indexOf(e),
                      isSelected ? e.getSelectWidget() : e.getNormalWidget()),
                );
              }).toList(),
            ),
          ),
        )
      ],
    );
  }

  Widget _addClick(int index, Widget widget) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _currentPageIndex = index;

          if(controller == null) {
            controller = AnimationController(duration: const Duration(milliseconds: 200), vsync: this,lowerBound: 0.7);
          }


          controller.reset();
          controller.forward();
        });
      },
      child: Container(
        color: Colors.transparent,
          alignment: Alignment.center,
          constraints: BoxConstraints(
            minWidth: double.infinity,
            minHeight: double.infinity
          ),
          child: widget
      ),
    );
  }

  Widget _addScaleAnim(Widget widget) {
    return ScaleTransition(
      scale: controller,
      child: widget,
    );
  }


  @override
  void dispose() {
    super.dispose();

    controller?.dispose();

  }


}

abstract class NaviItemWidget {

  Widget normalIcon;
  Widget selectedIcon;
  Widget normalText;
  Widget selectedText;

  NaviItemWidget({
    @required this.normalIcon,
    @required this.normalText,
    @required this.selectedIcon,
    @required this.selectedText,
  }) : assert(normalIcon != null);

  Widget getNormalWidget();
  Widget getSelectWidget();

}
