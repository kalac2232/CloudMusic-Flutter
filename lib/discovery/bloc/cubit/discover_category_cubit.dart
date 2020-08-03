
import 'package:cloudmusic/discovery/bean/discover_category_bean.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class DiscoverCategoryCubit extends Cubit<DiscoverCategoryBean> {
  DiscoverCategoryCubit() : super(null);

  void setBean(DiscoverCategoryBean l) => emit(l);

}