/// imageUrl : "http://p1.music.126.net/ZKQcagTfYmweo8L2z6tpQw==/109951165159903279.jpg"
/// targetId : 1463165983
/// adid : null
/// targetType : 1
/// titleColor : "red"
/// typeTitle : "新歌首发"
/// url : null
/// exclusive : false
/// monitorImpress : null
/// monitorClick : null
/// monitorType : null
/// monitorImpressList : null
/// monitorClickList : null
/// monitorBlackList : null
/// extMonitor : null
/// extMonitorInfo : null
/// adSource : null
/// adLocation : null
/// adDispatchJson : null
/// encodeId : "1463165983"
/// program : null
/// event : null
/// video : null
/// song : null
/// scm : "1.music-homepage.homepage_banner_force.banner.762349.1609457021.null"

class BannerBean {
  String _pic;
  int _targetId;
  dynamic _adid;
  int _targetType;
  String _titleColor;
  String _typeTitle;
  dynamic _url;
  bool _exclusive;
  String _encodeId;
  dynamic _program;
  dynamic _event;
  dynamic _video;
  dynamic _song;
  String _scm;

  String get pic => _pic;
  int get targetId => _targetId;
  dynamic get adid => _adid;
  int get targetType => _targetType;
  String get titleColor => _titleColor;
  String get typeTitle => _typeTitle;
  dynamic get url => _url;
  bool get exclusive => _exclusive;
  String get encodeId => _encodeId;
  dynamic get program => _program;
  dynamic get event => _event;
  dynamic get video => _video;
  dynamic get song => _song;
  String get scm => _scm;

  BannerBean({
      String pic,
      int targetId, 
      dynamic adid, 
      int targetType, 
      String titleColor, 
      String typeTitle, 
      dynamic url, 
      bool exclusive, 
      dynamic monitorImpress, 
      dynamic monitorClick, 
      dynamic monitorType, 
      dynamic monitorImpressList, 
      dynamic monitorClickList, 
      dynamic monitorBlackList, 
      dynamic extMonitor, 
      dynamic extMonitorInfo, 
      dynamic adSource, 
      dynamic adLocation, 
      dynamic adDispatchJson, 
      String encodeId, 
      dynamic program, 
      dynamic event, 
      dynamic video, 
      dynamic song, 
      String scm}){
    _pic = pic;
    _targetId = targetId;
    _adid = adid;
    _targetType = targetType;
    _titleColor = titleColor;
    _typeTitle = typeTitle;
    _url = url;
    _exclusive = exclusive;
    _encodeId = encodeId;
    _program = program;
    _event = event;
    _video = video;
    _song = song;
    _scm = scm;
}

  BannerBean.fromJson(dynamic json) {
    _pic = json["pic"];
    _targetId = json["targetId"];
    _adid = json["adid"];
    _targetType = json["targetType"];
    _titleColor = json["titleColor"];
    _typeTitle = json["typeTitle"];
    _url = json["url"];
    _exclusive = json["exclusive"];
    _encodeId = json["encodeId"];
    _program = json["program"];
    _event = json["event"];
    _video = json["video"];
    _song = json["song"];
    _scm = json["scm"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["pic"] = _pic;
    map["targetId"] = _targetId;
    map["adid"] = _adid;
    map["targetType"] = _targetType;
    map["titleColor"] = _titleColor;
    map["typeTitle"] = _typeTitle;
    map["url"] = _url;
    map["exclusive"] = _exclusive;
    map["encodeId"] = _encodeId;
    map["program"] = _program;
    map["event"] = _event;
    map["video"] = _video;
    map["song"] = _song;
    map["scm"] = _scm;
    return map;
  }

}