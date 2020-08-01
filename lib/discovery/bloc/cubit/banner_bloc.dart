import 'package:cloudmusic/discovery/bean/banner_bean.dart';
import 'package:cloudmusic/discovery/bloc/event/banner_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BannerBloc extends Bloc<BannerEvent, List<BannerBean>> {
  /// {@macro counter_bloc}
  BannerBloc() : super(List());

  @override
  Stream<List<BannerBean>> mapEventToState(BannerEvent event) async* {

    yield event.list;


  }
}
