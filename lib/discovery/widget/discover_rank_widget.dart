
import 'package:cloudmusic/commen/utils/hex_color.dart';
import 'package:cloudmusic/discovery/bean/discover_rank_bean.dart';
import 'package:cloudmusic/discovery/bean/song_item_bean.dart';
import 'package:cloudmusic/discovery/bloc/cubit/discover_rank_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';

class DiscoverRankWidget extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 277.h,
      child: Stack(
        children: <Widget>[
          Positioned(
            left: 16.w,
            top: 0,
            child: Text(
              "热歌风向标",
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
          Positioned(
            top: 38.h,
            height: 240.h,
            width: MediaQuery.of(context).size.width,
            child: BlocBuilder<DiscoverRankCubit, List<DiscoverRankBean>>(
              builder: (BuildContext context, List<DiscoverRankBean> state) {
                return state.isEmpty?Container():PageView.builder(
                    controller: PageController(
                      viewportFraction: 341 / 375,
                    ),
                    physics: BouncingScrollPhysics(),
                    itemCount:  state.length,
                    itemBuilder: (context, index) {
                      return _RankPage(state[index]);
                    });
              },
            ),
          )
        ],
      ),
    );
  }

}

class _RankPage extends StatelessWidget {
  final DiscoverRankBean bean;
  _RankPage(this.bean);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(right: 16.w),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Stack(
              children: <Widget>[
                Positioned(
                  width: 333.w,
                  child: _DynamicBackground(this.bean.topThree[0].picUrl+"?param=300y300"),
                ),
                Positioned(
                  left: 10.w,
                  top: 18.h,
                  child: Text(bean.name,style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.bold
                  ),),
                ),
                Positioned(
                  top: 60.h,
                  left: 10.w,
                  height: 50.h,
                  width: 313.w,
                  child: _Item(index: 1, bean: this.bean.topThree[0]),
                ),
                Positioned(
                  top: 120.h,
                  left: 10.w,
                  height: 50.h,
                  width: 313.w,
                  child: _Item(index: 2, bean: this.bean.topThree[1]),
                ),
                Positioned(
                  top: 180.h,
                  left: 10.w,
                  height: 50.h,
                  width: 313.w,
                  child: _Item(index: 3, bean: this.bean.topThree[2]),
                ),
              ],
            )
        )
    );
  }
}

class _Item extends StatelessWidget {
  int index;
  SongItemBean bean;


  _Item({@required this.index, @required this.bean});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Positioned(
          width: 50.w,
          height: 50.h,
          left: 0,
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(bean.picUrl+"?param=100y100"),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(6.0),
              ),
            ),
          ),
        ),
        Positioned(
          left: 66.w,
          child: Text(index.toString(),style: TextStyle(color: Colors.white,fontSize: 14,fontWeight: FontWeight.bold),),
        ),
        Positioned(
          width: 180.w,
          left: 98.w,
          child: Row(
            children: <Widget>[
              Container(
                constraints: BoxConstraints(
                  maxWidth: 110.w,
                ),
                child: Text(
                  bean.name,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(
                      color: HexColor.fromHex("#FFFFFF"), fontSize: 15.sp),
                ),
              ),
              Expanded(
                child: Text(
                  " - " + bean.author,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(
                      color: HexColor.fromHex("#E5E5E5").withAlpha(127), fontSize: 12.sp),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}


///背景
class _DynamicBackground extends StatefulWidget {
  final String picUrl;


  _DynamicBackground(this.picUrl);

  @override
  _DynamicBackgroundState createState() => _DynamicBackgroundState();
}

class _DynamicBackgroundState extends State<_DynamicBackground> {

  PaletteGenerator paletteGenerator;
  @override
  void initState() {
    super.initState();

    _updatePaletteGenerator();
  }

  Future<void> _updatePaletteGenerator() async {

    paletteGenerator = await PaletteGenerator.fromImageProvider(
        NetworkImage(widget.picUrl)
    );
    setState(() {});

  }
  @override
  Widget build(BuildContext context) {

    Color filterColor = paletteGenerator == null ? Colors.grey : paletteGenerator.dominantColor.color;

    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors:[filterColor.withAlpha(122),filterColor.withAlpha(255)],
          begin: Alignment.topCenter,
          end: Alignment(0.0, -0.3),

        ),
      ),
      position: DecorationPosition.foreground,
      child: Container(
        //color: Colors.green,
        child: Image.network(widget.picUrl,fit: BoxFit.cover,),
      ),
    );
  }
}
