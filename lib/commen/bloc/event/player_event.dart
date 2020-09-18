import 'package:flutter/cupertino.dart';

abstract class PlayerEvent{

}

class PlayerStartedEvent extends PlayerEvent{

}

class PlayerPausedEvent extends PlayerEvent{

}

class PlayerResumedEvent extends PlayerEvent{

}

class PlayerProgressEvent extends PlayerEvent{

  final double progress;

  PlayerProgressEvent({@required this.progress});


}


class PlayerCompletedEvent extends PlayerEvent{

}

class PlayerPreviousEvent extends PlayerEvent{
  bool isChangePageView = true;
}

class PlayerNextEvent extends PlayerEvent{
  bool isChangePageView = true;

}