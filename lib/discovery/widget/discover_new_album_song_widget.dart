import 'package:cloudmusic/commen/utils/hex_color.dart';
import 'package:cloudmusic/discovery/bean/album_list_item_bean.dart';
import 'package:cloudmusic/discovery/bean/song_item_bean.dart';
import 'package:cloudmusic/discovery/bloc/cubit/discover_new_album_cubit.dart';
import 'package:cloudmusic/discovery/bloc/cubit/discover_new_category_bloc.dart';
import 'package:cloudmusic/discovery/bloc/cubit/discover_new_song_cubit.dart';
import 'package:cloudmusic/discovery/bloc/event/discovery_event.dart';
import 'package:cloudmusic/discovery/widget/discover_songlist_pagerview.dart';
import 'package:cloudmusic/discovery/widget/song_item_widget.dart';
import 'package:cloudmusic/generated/r.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'album_item_widget.dart';

class DiscoverNewAlbumAndSongWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DiscoverNewCategoryBloc, DiscoverNewCategoryEvent>(
      builder: (BuildContext context, DiscoverNewCategoryEvent state) {
        return Container(
          height: 238.w,
          child: Stack(
            children: <Widget>[
              Positioned(
                left: 16.w,
                top: 0,
                child: GestureDetector(
                  onTap: (){
                    if(state == DiscoverNewCategoryEvent.newSong) {
                      return;
                    }
                    context.bloc<DiscoverNewCategoryBloc>().add(DiscoverNewCategoryEvent.newSong);
                  },
                  child: Text(
                    "新歌",
                    style: TextStyle(
                        fontSize: 18.sp,
                        color: state == DiscoverNewCategoryEvent.newSong?HexColor.fromHex("#000000"):HexColor.fromHex("#9C9C9C"),
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Positioned(
                left: 60.w,
                top: 6.h,
                child: Container(
                  width: 1,
                  height: 16.w,
                  color: HexColor.fromHex("#E6E6E6"),
                ),
              ),
              Positioned(
                left: 71.w,
                top: 0,
                child: GestureDetector(
                  onTap: (){
                    if(state == DiscoverNewCategoryEvent.newAlbum) {
                      return;
                    }
                    context.bloc<DiscoverNewCategoryBloc>().add(DiscoverNewCategoryEvent.newAlbum);
                  },
                  child: Text(
                    "新碟",
                    style: TextStyle(
                        fontSize: 18.sp,
                        color: state == DiscoverNewCategoryEvent.newAlbum?HexColor.fromHex("#000000"):HexColor.fromHex("#9C9C9C"),
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              //加载更多按钮
              Positioned(
                right: 16.w,
                top: 0,
                child: Container(
                  width: 76.w,
                  height: 25.w,
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: HexColor.fromHex("#E6E6E6"), width: 1),
                      borderRadius: BorderRadius.circular(12.5.w)),
                  alignment: Alignment.center,
                  child: Text(
                    state == DiscoverNewCategoryEvent.newSong?"更多新歌":"更多新碟",
                    style: TextStyle(
                        color: HexColor.fromHex("#333333"), fontSize: 13.sp),
                  ),
                ),
              ),
              Positioned(
                top: 38.w,
                height: 200.w,
                width: MediaQuery.of(context).size.width,
                child: state == DiscoverNewCategoryEvent.newSong?_getNewSongWidget():_getNewAlbumWidget(),
              )
            ],
          ),
        );
      },

    );
  }

  Widget _getNewSongWidget() {
    return BlocBuilder<DiscoverNewSongCubit,List<SongItemBean>>(
      builder: (context, List<SongItemBean> state) {

        return DiscoverSongListPageView<SongItemBean>(
          list: state,
          itemBuilder: (BuildContext context, SongItemBean bean) {
            return SongItemWidget(bean:bean);
        },);
    },);
  }

  Widget _getNewAlbumWidget() {
    return BlocBuilder<DiscoverNewAlbumCubit,List<AlbumListItemBean>>(
      builder: (context, List<AlbumListItemBean> state) {

        return DiscoverSongListPageView<AlbumListItemBean>(
          list: state,
          itemBuilder: (BuildContext context, AlbumListItemBean bean) {
            return AlbumItemWidget(bean:bean);
          },);
      },);
  }
}
