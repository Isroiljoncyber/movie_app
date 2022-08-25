import 'dart:convert';
/// results : [{"adult":false,"backdrop_path":"/vsN9Lpi3HQJHQeHx8GzN6qfOYqk.jpg","genre_ids":[28,53,80,18],"id":766907,"original_language":"en","original_title":"American Siege","overview":"An ex-NYPD officer-turned-sheriff of a small rural Georgia town has to contend with a gang of thieves who have taken a wealthy doctor hostage.","popularity":160.738,"poster_path":"/daeVrgyj0ue8qb3AHyU3UeCwoZz.jpg","release_date":"2022-01-07","title":"American Siege","video":false,"vote_average":5.7,"vote_count":101},{"adult":false,"backdrop_path":"/i1GT0e6Crg6UezT3ibXnMS3pBAd.jpg","genre_ids":[16,18,10749],"id":652837,"original_language":"ja","original_title":"ジョゼと虎と魚たち","overview":"With dreams of diving abroad, Tsuneo gets a job assisting Josee, an artist whose imagination takes her far beyond her wheelchair. But when the tide turns against them, they push each other to places they never thought possible, and inspire a love fit for a storybook.","popularity":135.556,"poster_path":"/z1D8xi9x4uEhyFruo7uEHXUMD4K.jpg","release_date":"2020-12-25","title":"Josee, the Tiger and the Fish","video":false,"vote_average":8.4,"vote_count":257}]

MoviesModel moviesModelFromJson(String str) => MoviesModel.fromJson(json.decode(str));
String moviesModelToJson(MoviesModel data) => json.encode(data.toJson());
class MoviesModel {
  MoviesModel({
      List<Results>? results,}){
    _results = results;
}

  MoviesModel.fromJson(dynamic json) {
    if (json['results'] != null) {
      _results = [];
      json['results'].forEach((v) {
        _results?.add(Results.fromJson(v));
      });
    }
  }
  List<Results>? _results;
MoviesModel copyWith({  List<Results>? results,
}) => MoviesModel(  results: results ?? _results,
);
  List<Results>? get results => _results;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_results != null) {
      map['results'] = _results?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// adult : false
/// backdrop_path : "/vsN9Lpi3HQJHQeHx8GzN6qfOYqk.jpg"
/// genre_ids : [28,53,80,18]
/// id : 766907
/// original_language : "en"
/// original_title : "American Siege"
/// overview : "An ex-NYPD officer-turned-sheriff of a small rural Georgia town has to contend with a gang of thieves who have taken a wealthy doctor hostage."
/// popularity : 160.738
/// poster_path : "/daeVrgyj0ue8qb3AHyU3UeCwoZz.jpg"
/// release_date : "2022-01-07"
/// title : "American Siege"
/// video : false
/// vote_average : 5.7
/// vote_count : 101

Results resultsFromJson(String str) => Results.fromJson(json.decode(str));
String resultsToJson(Results data) => json.encode(data.toJson());
class Results {
  Results({
      bool? adult, 
      String? backdropPath, 
      List<num>? genreIds, 
      num? id, 
      String? originalLanguage, 
      String? originalTitle, 
      String? overview, 
      num? popularity, 
      String? posterPath, 
      String? releaseDate, 
      String? title, 
      bool? video, 
      num? voteAverage, 
      num? voteCount,}){
    _adult = adult;
    _backdropPath = backdropPath;
    _genreIds = genreIds;
    _id = id;
    _originalLanguage = originalLanguage;
    _originalTitle = originalTitle;
    _overview = overview;
    _popularity = popularity;
    _posterPath = posterPath;
    _releaseDate = releaseDate;
    _title = title;
    _video = video;
    _voteAverage = voteAverage;
    _voteCount = voteCount;
}

  Results.fromJson(dynamic json) {
    _adult = json['adult'];
    _backdropPath = json['backdrop_path'];
    _genreIds = json['genre_ids'] != null ? json['genre_ids'].cast<num>() : [];
    _id = json['id'];
    _originalLanguage = json['original_language'];
    _originalTitle = json['original_title'];
    _overview = json['overview'];
    _popularity = json['popularity'];
    _posterPath = json['poster_path'];
    _releaseDate = json['release_date'];
    _title = json['title'];
    _video = json['video'];
    _voteAverage = json['vote_average'];
    _voteCount = json['vote_count'];
  }
  bool? _adult;
  String? _backdropPath;
  List<num>? _genreIds;
  num? _id;
  String? _originalLanguage;
  String? _originalTitle;
  String? _overview;
  num? _popularity;
  String? _posterPath;
  String? _releaseDate;
  String? _title;
  bool? _video;
  num? _voteAverage;
  num? _voteCount;
Results copyWith({  bool? adult,
  String? backdropPath,
  List<num>? genreIds,
  num? id,
  String? originalLanguage,
  String? originalTitle,
  String? overview,
  num? popularity,
  String? posterPath,
  String? releaseDate,
  String? title,
  bool? video,
  num? voteAverage,
  num? voteCount,
}) => Results(  adult: adult ?? _adult,
  backdropPath: backdropPath ?? _backdropPath,
  genreIds: genreIds ?? _genreIds,
  id: id ?? _id,
  originalLanguage: originalLanguage ?? _originalLanguage,
  originalTitle: originalTitle ?? _originalTitle,
  overview: overview ?? _overview,
  popularity: popularity ?? _popularity,
  posterPath: posterPath ?? _posterPath,
  releaseDate: releaseDate ?? _releaseDate,
  title: title ?? _title,
  video: video ?? _video,
  voteAverage: voteAverage ?? _voteAverage,
  voteCount: voteCount ?? _voteCount,
);
  bool? get adult => _adult;
  String? get backdropPath => _backdropPath;
  List<num>? get genreIds => _genreIds;
  num? get id => _id;
  String? get originalLanguage => _originalLanguage;
  String? get originalTitle => _originalTitle;
  String? get overview => _overview;
  num? get popularity => _popularity;
  String? get posterPath => _posterPath;
  String? get releaseDate => _releaseDate;
  String? get title => _title;
  bool? get video => _video;
  num? get voteAverage => _voteAverage;
  num? get voteCount => _voteCount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['adult'] = _adult;
    map['backdrop_path'] = _backdropPath;
    map['genre_ids'] = _genreIds;
    map['id'] = _id;
    map['original_language'] = _originalLanguage;
    map['original_title'] = _originalTitle;
    map['overview'] = _overview;
    map['popularity'] = _popularity;
    map['poster_path'] = _posterPath;
    map['release_date'] = _releaseDate;
    map['title'] = _title;
    map['video'] = _video;
    map['vote_average'] = _voteAverage;
    map['vote_count'] = _voteCount;
    return map;
  }

}