import 'package:cloudmusic/discovery/bean/banner_bean.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BannerCubit extends Cubit<List<BannerBean>> {
  BannerCubit() : super(List());

  void setBanner(List<BannerBean> l) => emit(l);

}