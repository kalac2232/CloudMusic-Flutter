
import 'dart:ui';

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
  AnimationController _animationController;
  //页面切换控制器
  PageController _pageController;
  @override
  void initState() {
    super.initState();
    this._pageController = PageController(initialPage: this._currentPageIndex, keepPage: true);

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
            child: _KeepStateWidget(
              child: Container(
                color: Colors.white,
                child: PageView(
                  //禁用横向滑动切换
                  physics: NeverScrollableScrollPhysics(),
                  controller: _pageController,
                  children: widget.pagers.map((widget){
                    return _KeepStateWidget(
                      child: widget,
                    );
                  }).toList(),
                ),

              ),
            )
        ),
        //模糊效果
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          height: widget.barHeight,
          child: ClipRect(
            child: BackdropFilter(
              filter:  ImageFilter.blur(sigmaX: 2, sigmaY: 2),
              child: Container(
                color: HexColor.fromHex("#F8F8F8").withOpacity(0.8),
                //width: 100,
                //height: widget.barHeight,
              ),
            ),
          ),
        ),

        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          height: widget.barHeight,
          child: Container(
            color: HexColor.fromHex("#F8F8F8").withAlpha(225),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: widget.naviItems.map((e) {
                bool isSelected =
                    widget.naviItems.indexOf(e) == _currentPageIndex;

                if (isSelected && _animationController != null && e.selectedIcon is! ScaleTransition) {
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

        ),

      ],
    );
  }

  Widget _addClick(int index, Widget widget) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _currentPageIndex = index;
          _pageController.jumpToPage(_currentPageIndex);

          if(_animationController == null) {
            _animationController = AnimationController(duration: const Duration(milliseconds: 200), vsync: this,lowerBound: 0.7);
          }


          _animationController.reset();
          _animationController.forward();
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
      scale: _animationController,
      child: widget,
    );
  }


  @override
  void dispose() {
    super.dispose();

    _animationController?.dispose();
    _pageController?.dispose();

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


class _KeepStateWidget extends StatefulWidget {

  Widget child;


  _KeepStateWidget({@required this.child});

  @override
  __KeepStateWidgetState createState() => __KeepStateWidgetState();
}

class __KeepStateWidgetState extends State<_KeepStateWidget>  with AutomaticKeepAliveClientMixin {

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.child;
  }

  @override
  bool get wantKeepAlive => true;
}
