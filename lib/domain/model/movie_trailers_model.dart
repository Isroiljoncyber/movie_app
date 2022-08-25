import 'dart:convert';
/// results : [{"iso_639_1":"en","iso_3166_1":"US","name":"The Secret Behind Thor's Lightning","key":"4_hAjH8hK4U","site":"YouTube","size":1080,"type":"Behind the Scenes","official":true,"published_at":"2022-08-06T16:00:05.000Z","id":"62f1483977e1f6007fcdcbdc"},{"iso_639_1":"en","iso_3166_1":"US","name":"The Goats' Origins | VFX Behind The Scenes","key":"kFAbohd4FXk","site":"YouTube","size":1080,"type":"Behind the Scenes","official":true,"published_at":"2022-08-03T19:00:27.000Z","id":"62eb538a6d9fe80061366471"}]

MovieTrailersModel movieTrailersModelFromJson(String str) => MovieTrailersModel.fromJson(json.decode(str));
String movieTrailersModelToJson(MovieTrailersModel data) => json.encode(data.toJson());
class MovieTrailersModel {
  MovieTrailersModel({
      List<TrailerResults>? results,}){
    _results = results;
}

  MovieTrailersModel.fromJson(dynamic json) {
    if (json['results'] != null) {
      _results = [];
      json['results'].forEach((v) {
        _results?.add(TrailerResults.fromJson(v));
      });
    }
  }
  List<TrailerResults>? _results;
MovieTrailersModel copyWith({  List<TrailerResults>? results,
}) => MovieTrailersModel(  results: results ?? _results,
);
  List<TrailerResults>? get results => _results;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_results != null) {
      map['results'] = _results?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// iso_639_1 : "en"
/// iso_3166_1 : "US"
/// name : "The Secret Behind Thor's Lightning"
/// key : "4_hAjH8hK4U"
/// site : "YouTube"
/// size : 1080
/// type : "Behind the Scenes"
/// official : true
/// published_at : "2022-08-06T16:00:05.000Z"
/// id : "62f1483977e1f6007fcdcbdc"

TrailerResults resultsFromJson(String str) => TrailerResults.fromJson(json.decode(str));
String resultsToJson(TrailerResults data) => json.encode(data.toJson());
class TrailerResults {
  TrailerResults({
      String? iso6391, 
      String? iso31661, 
      String? name, 
      String? key, 
      String? site, 
      num? size, 
      String? type, 
      bool? official, 
      String? publishedAt, 
      String? id,}){
    _iso6391 = iso6391;
    _iso31661 = iso31661;
    _name = name;
    _key = key;
    _site = site;
    _size = size;
    _type = type;
    _official = official;
    _publishedAt = publishedAt;
    _id = id;
}

  TrailerResults.fromJson(dynamic json) {
    _iso6391 = json['iso_639_1'];
    _iso31661 = json['iso_3166_1'];
    _name = json['name'];
    _key = json['key'];
    _site = json['site'];
    _size = json['size'];
    _type = json['type'];
    _official = json['official'];
    _publishedAt = json['published_at'];
    _id = json['id'];
  }
  String? _iso6391;
  String? _iso31661;
  String? _name;
  String? _key;
  String? _site;
  num? _size;
  String? _type;
  bool? _official;
  String? _publishedAt;
  String? _id;
TrailerResults copyWith({  String? iso6391,
  String? iso31661,
  String? name,
  String? key,
  String? site,
  num? size,
  String? type,
  bool? official,
  String? publishedAt,
  String? id,
}) => TrailerResults(  iso6391: iso6391 ?? _iso6391,
  iso31661: iso31661 ?? _iso31661,
  name: name ?? _name,
  key: key ?? _key,
  site: site ?? _site,
  size: size ?? _size,
  type: type ?? _type,
  official: official ?? _official,
  publishedAt: publishedAt ?? _publishedAt,
  id: id ?? _id,
);
  String? get iso6391 => _iso6391;
  String? get iso31661 => _iso31661;
  String? get name => _name;
  String? get key => _key;
  String? get site => _site;
  num? get size => _size;
  String? get type => _type;
  bool? get official => _official;
  String? get publishedAt => _publishedAt;
  String? get id => _id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['iso_639_1'] = _iso6391;
    map['iso_3166_1'] = _iso31661;
    map['name'] = _name;
    map['key'] = _key;
    map['site'] = _site;
    map['size'] = _size;
    map['type'] = _type;
    map['official'] = _official;
    map['published_at'] = _publishedAt;
    map['id'] = _id;
    return map;
  }

}