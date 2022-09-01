import 'dart:convert';
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../screen/main_page.dart';
import '../../../utils/constant.dart';
import '../../model/movies_model.dart';

part 'popular_movies_state.dart';

class PopularMoviesCubit extends Cubit<PopularMoviesState> {
  PopularMoviesCubit() : super(const PopularMoviesInitialState());

  List<Results> movieList = [];

  Future getMoviesList() async {
    const String popularMovieUrl = "${baseUrl}popular${apiKeyWithAdd}1";
    var httpClient = HttpClient();
    try {
      emit(const PopularMoviesOnProgress());
      var request = await httpClient.getUrl(Uri.parse(popularMovieUrl));
      var response = await request.close();
      if (response.statusCode == HttpStatus.ok) {
        var jsonResponse = await response.transform(utf8.decoder).join();
        // Decode the json response
        var data = jsonDecode(jsonResponse);
        // Get the result list
        List results = data["results"];
        // Get the Movie list
        movieList = createMovieList(results);
        // Print the results.
        emit(PopularMoviesOnCompletedState(movieList));
      } else {
        emit(const PopularMoviesOnFailed("Failed http call."));
      }
    } catch (exception) {
      emit(PopularMoviesOnFailed(exception.toString()));
    }
  }

  Future searchPopularMovies(String movieName) async {
    try {
      emit(const PopularMoviesOnProgress());
      List<Results> sortedMovies = [];
      for (var element in movieList) {
        if (element.title!.toLowerCase().contains(movieName.toLowerCase())) {
          sortedMovies.add(element);
        }
      }
      emit(PopularMoviesOnCompletedState(sortedMovies));
    } catch (e) {
      emit(PopularMoviesOnFailed(e.toString()));
    }
  }

  Future sortPopularMovies(SortType sortType) async {
    try {
      emit(const PopularMoviesOnProgress());
      List<Results> sortedMovies = movieList;
      if (sortType == SortType.popularity) {
        sortedMovies.sort((a, b) => a.popularity!.compareTo(b.popularity!));
      } else if (sortType == SortType.voteAverage) {
        sortedMovies.sort((a, b) => a.voteAverage!.compareTo(b.voteAverage!));
      } else if (sortType == SortType.voteCount) {
        sortedMovies.sort((a, b) => a.voteCount!.compareTo(b.voteCount!));
      }
      emit(PopularMoviesOnCompletedState(sortedMovies.reversed.toList()));
    } catch (e) {
      emit(PopularMoviesOnFailed(e.toString()));
    }
  }
}
