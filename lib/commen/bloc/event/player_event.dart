import 'package:flutter/cupertino.dart';

abstract class PlayerEvent{

}

class PlayerStartedEvent extends PlayerEvent{

}

class PlayerPausedEvent extends PlayerEvent{

}

class PlayerResumedEvent extends PlayerEvent{

}

class PlayerSeekEvent extends PlayerEvent{

  final double seekTo;

  PlayerSeekEvent({@required this.seekTo});


}

class PlayerProgressEvent extends PlayerEvent{

  final Duration currentDuration;
  final Duration maxDuration;

  PlayerProgressEvent({@required this.currentDuration,@required this.maxDuration});


}


class PlayerCompletedEvent extends PlayerEvent{

}

class PlayerPreviousEvent extends PlayerEvent{
  bool isChangePageView = true;
}

class PlayerNextEvent extends PlayerEvent{
  bool isChangePageView = true;

}