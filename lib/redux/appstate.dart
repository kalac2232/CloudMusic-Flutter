import 'package:cloudmusic/discovery/bean/banner_bean.dart';
import 'package:cloudmusic/redux/reducers.dart';

class AppState{
  List<BannerBean> banners;
  AppState({this.banners});
}

AppState appReducer(AppState state,action) {
  return AppState(
    banners: bannerReducer(state.banners,action)
  );
}