import 'package:cloudmusic/discovery/bean/banner_bean.dart';
import 'package:cloudmusic/redux/actions.dart';
import 'package:redux/redux.dart';

final bannerReducer = combineReducers<List<BannerBean>>([TypedReducer<List<BannerBean>,SetBannerAction>(_setBanner)]);
List<BannerBean> _setBanner(List<BannerBean> banners,SetBannerAction action) {
  banners = action.banners;
  return banners;
}