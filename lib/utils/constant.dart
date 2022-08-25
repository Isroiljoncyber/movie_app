import 'package:movie_app/domain/model/movie_trailers_model.dart';

import '../domain/model/movies_model.dart';

const String apiKeyWithAdd = "?api_key=af5d3f44260e5f84677a9d04bada8a19&page=";
const String baseUrl = "https://api.themoviedb.org/3/movie/";
const String imageBaseUrl = "https://image.tmdb.org/t/p/w500";
const String imageBaseUrlDefault =
    "https://i.ibb.co/RPKnckW/ic-launcher-movies.png";
const String trailerUrl = "/videos";

List<Results> createMovieList(List results) {
  List<Results> list = [];
  for (var item in results) {
    var model = Results.fromJson(item);
    list.add(model);
  }
  return list;
}

List<TrailerResults> createTrailerList(List results) {
  List<TrailerResults> list = [];
  for (var item in results) {
    var model = TrailerResults.fromJson(item);
    list.add(model);
  }
  return list;
}
