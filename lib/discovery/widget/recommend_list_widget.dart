import 'package:cloudmusic/commen/utils/hex_color.dart';
import 'package:cloudmusic/discovery/bean/recommend_list_bean.dart';
import 'package:cloudmusic/discovery/bloc/cubit/recommed_list_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:math' as math;

import 'package:flutter_bloc/flutter_bloc.dart';

class RecommendListWidget extends StatelessWidget {
  ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    _scrollController.addListener(() {
      print(_scrollController.offset); //打印滚动位置
      //print(isScroll); //打印滚动位置

//      if (_scrollController.offset > 280) {
//        _scrollController.animateTo(280,
//            duration: Duration(microseconds: 1000), curve: Curves.linear);
//      }
    });
    return BlocBuilder<RecommendListCubit, List<RecommendListBean>>(
      builder: (BuildContext context, List<RecommendListBean> state) {

        List<String> titles = ["人气歌单推荐","你的歌单精选站","发现好歌单","懂你的精选歌单"];

        var randomTitle = titles[math.Random().nextInt(4)];

        return Container(
          height: 183.h,
          child: Stack(
            children: <Widget>[
              Positioned(
                left: 16.w,
                top: 0,
                child: Text(
                  randomTitle,
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
                      border: Border.all(
                          color: HexColor.fromHex("#E6E6E6"), width: 1),
                      borderRadius: BorderRadius.circular(12.5)),
                  alignment: Alignment.center,
                  child: Text(
                    "查看更多",
                    style: TextStyle(
                        color: HexColor.fromHex("#333333"), fontSize: 13),
                  ),
                ),
              ),
              //歌单listview
              Positioned(
                top: 38.h,
                width: MediaQuery.of(context).size.width,
                height: 146.h,
                child: state.isEmpty ? Container():ListView.separated(
                  padding: EdgeInsets.only(left: 16),
                  //6 + 1 多一个查看更多
                  itemCount: 7,
                  physics: BouncingScrollPhysics1(),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {

                    if (index == 6) {
                      return _moreWidget();
                    }


                    return Container(
                      //color: Colors.red,
                      width: 105.w,
                      height: 145.h,
                      child: Stack(
                        children: <Widget>[
                          Positioned(
                            top: 0,
                            child: Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(state[index].picUrl),
                                    fit: BoxFit.cover),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8.0)),
                                //color: Colors.red
                              ),
                              width: 105.w,
                              height: 105.w,
                            ),
                          ),
                          Positioned(
                            top: 2,
                            right: 6,
                            child: Row(
                              children: <Widget>[
                                Text(
                                  _formatCount(state[index].playCount),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    shadows: [Shadow(color:Colors.black,offset: Offset(0, 0), blurRadius: 3)],
                                  ),
                                )
                              ],
                            ),
                          ),
                          Positioned(
                            width: 105.w,
                            top: 112.h,
                            child: Text(
                              state[index].name,
                              maxLines: 2,
                              style: TextStyle(
                                  color: HexColor.fromHex("#333333"),
                                  fontSize: 12
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(
                      width: 9.w,
                      height: 1,
                    );
                  },
                  controller: _scrollController,
                ),
              )
            ],
          ),
        );
      },
    );
  }


  Widget _moreWidget() {
    return Container(
      //color: Colors.red,
      width: 75.w,
      height: 145.h,
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            child: Container(
              decoration: BoxDecoration(
                borderRadius:
                BorderRadius.all(Radius.circular(8.0)),
                color: Colors.red,
              ),
              width: 75.w,
              height: 105.w,
            ),
          ),

        ],
      ),
    );
  }

  String _formatCount(int count){
    int originCount = count;
    count = count ~/ 10000;

    if (count < 1) {
      return "$originCount";
    }
    originCount = count;
    count = count ~/ 10000;
    if (count < 1) {
      return "$originCount万";
    } else {
      return "$count亿";
    }
  }
}

const double kMinFlingVelocity = 50.0;

class BouncingScrollPhysics1 extends ScrollPhysics {
  /// Creates scroll physics that bounce back from the edge.
  const BouncingScrollPhysics1({ScrollPhysics parent}) : super(parent: parent);

  @override
  BouncingScrollPhysics1 applyTo(ScrollPhysics ancestor) {
    return BouncingScrollPhysics1(parent: buildParent(ancestor));
  }

  /// The multiple applied to overscroll to make it appear that scrolling past
  /// the edge of the scrollable contents is harder than scrolling the list.
  /// This is done by reducing the ratio of the scroll effect output vs the
  /// scroll gesture input.
  ///
  /// This factor starts at 0.52 and progressively becomes harder to overscroll
  /// as more of the area past the edge is dragged in (represented by an increasing
  /// `overscrollFraction` which starts at 0 when there is no overscroll).
  double frictionFactor(double overscrollFraction) =>
      0.52 * math.pow(1 - overscrollFraction, 2);

  @override
  double applyPhysicsToUserOffset(ScrollMetrics position, double offset) {
    assert(offset != 0.0);
    assert(position.minScrollExtent <= position.maxScrollExtent);

    if (!outOfRange(position)) return offset;

    final double overscrollPastStart =
        math.max(position.minScrollExtent - position.pixels, 0.0);
    final double overscrollPastEnd =
        math.max(position.pixels - position.maxScrollExtent - 100, 0.0);
    final double overscrollPast =
        math.max(overscrollPastStart, overscrollPastEnd);
    final bool easing = (overscrollPastStart > 0.0 && offset < 0.0) ||
        (overscrollPastEnd > 0.0 && offset > 0.0);

    final double friction = easing
        // Apply less resistance when easing the overscroll vs tensioning.
        ? frictionFactor(
            (overscrollPast - offset.abs()) / position.viewportDimension)
        : frictionFactor(overscrollPast / position.viewportDimension);
    final double direction = offset.sign;

    return direction * _applyFriction(overscrollPast, offset.abs(), friction);
  }

  static double _applyFriction(
      double extentOutside, double absDelta, double gamma) {
    assert(absDelta > 0);
    double total = 0.0;
    if (extentOutside > 0) {
      final double deltaToLimit = extentOutside / gamma;
      if (absDelta < deltaToLimit) return absDelta * gamma;
      total += extentOutside;
      absDelta -= deltaToLimit;
    }
    return total + absDelta;
  }

  @override
  double applyBoundaryConditions(ScrollMetrics position, double value) => 0.0;

  @override
  Simulation createBallisticSimulation(
      ScrollMetrics position, double velocity) {
    final Tolerance tolerance = this.tolerance;
    if (velocity.abs() >= tolerance.velocity || outOfRange(position)) {
      return BouncingScrollSimulation(
        spring: spring,
        position: position.pixels,
        velocity: velocity * 0.91,
        // TODO(abarth): We should move this constant closer to the drag end.
        leadingExtent: position.minScrollExtent,
        trailingExtent: position.maxScrollExtent - 100,
        tolerance: tolerance,
      );
    }
    return null;
  }

  // The ballistic simulation here decelerates more slowly than the one for
  // ClampingScrollPhysics so we require a more deliberate input gesture
  // to trigger a fling.
  @override
  double get minFlingVelocity => kMinFlingVelocity * 2.0;

  bool outOfRange(position) {
    return position.pixels < position.minScrollExtent ||
        position.pixels > (position.maxScrollExtent - 100);
  }

  // Methodology:
  // 1- Use https://github.com/flutter/scroll_overlay to test with Flutter and
  //    platform scroll views superimposed.
  // 2- Record incoming speed and make rapid flings in the test app.
  // 3- If the scrollables stopped overlapping at any moment, adjust the desired
  //    output value of this function at that input speed.
  // 4- Feed new input/output set into a power curve fitter. Change function
  //    and repeat from 2.
  // 5- Repeat from 2 with medium and slow flings.
  /// Momentum build-up function that mimics iOS's scroll speed increase with repeated flings.
  ///
  /// The velocity of the last fling is not an important factor. Existing speed
  /// and (related) time since last fling are factors for the velocity transfer
  /// calculations.
  @override
  double carriedMomentum(double existingVelocity) {
    return existingVelocity.sign *
        math.min(0.000816 * math.pow(existingVelocity.abs(), 1.967).toDouble(),
            40000.0);
  }

  // Eyeballed from observation to counter the effect of an unintended scroll
  // from the natural motion of lifting the finger after a scroll.
  @override
  double get dragStartDistanceMotionThreshold => 3.5;
}
