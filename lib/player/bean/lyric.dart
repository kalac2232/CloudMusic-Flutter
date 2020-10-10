class Lyric{
  String lyricStr;
  Duration startDuration;
  Duration endDuration;

  Lyric({this.lyricStr, this.startDuration, this.endDuration});

  @override
  String toString() {
    return 'Lyric{lyricStr: $lyricStr, startDuration: $startDuration, endDuration: $endDuration}';
  }


}