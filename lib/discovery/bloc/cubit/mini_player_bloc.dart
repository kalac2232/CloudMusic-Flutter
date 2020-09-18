
import 'package:cloudmusic/commen/bloc/event/commen_event.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
///
/// 一个参数是响应什么事件，第二个参数是返回什么数据
///
class MiniPlayerBloc extends Bloc<MiniPlayerWidgetControlEvent, MiniPlayerWidgetControlEvent> {

  MiniPlayerBloc(MiniPlayerWidgetControlEvent event) : super(event);

  @override
  Stream<MiniPlayerWidgetControlEvent> mapEventToState(MiniPlayerWidgetControlEvent event) async* {

    yield event;
  }
}
