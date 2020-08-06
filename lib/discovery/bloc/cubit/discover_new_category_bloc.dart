
import 'package:cloudmusic/discovery/bloc/event/discovery_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DiscoverNewCategoryBloc extends Bloc<DiscoverNewCategoryEvent, DiscoverNewCategoryEvent> {

  DiscoverNewCategoryBloc(DiscoverNewCategoryEvent event) : super(event);

  @override
  Stream<DiscoverNewCategoryEvent> mapEventToState(DiscoverNewCategoryEvent event) async* {

    yield event;
  }
}
