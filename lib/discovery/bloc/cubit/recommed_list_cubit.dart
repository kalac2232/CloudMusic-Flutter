
import 'package:cloudmusic/discovery/bean/recommend_list_bean.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RecommendListCubit extends Cubit<List<RecommendListBean>> {
  RecommendListCubit() : super(List());

  void setList(List<RecommendListBean> l) => emit(l);

}