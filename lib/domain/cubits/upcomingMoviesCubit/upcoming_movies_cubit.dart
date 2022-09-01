import 'dart:convert';
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/screen/main_page.dart';

import '../../../utils/constant.dart';
import '../../model/movies_model.dart';

part 'upcoming_movies_state.dart';

class UpcomingMoviesCubit extends Cubit<UpcomingMoviesState> {
  UpcomingMoviesCubit() : super(const UpcomingMoviesInitialState());

  List<Results> movieList = [];

  Future getMoviesList() async {
    const String upcomingMovieUri = "${baseUrl}upcoming${apiKeyWithAdd}1";
    var httpClient = HttpClient();
    try {
      emit(const UpcomingMoviesOnProgressState());
      var request = await httpClient.getUrl(Uri.parse(upcomingMovieUri));
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
        emit(UpcomingMoviesOnCompletedState(movieList));
      } else {
        emit(const UpcomingMoviesOnFailedState("Failed http call."));
      }
    } catch (exception) {
      emit(UpcomingMoviesOnFailedState(exception.toString()));
    }
  }

  Future searchUpcomingMovies(String movieName) async {
    try {
      emit(const UpcomingMoviesOnProgressState());
      List<Results> sortedMovies = [];
      for (var element in movieList) {
        if (element.title!.toLowerCase().contains(movieName.toLowerCase())) {
          sortedMovies.add(element);
        }
        emit(UpcomingMoviesOnCompletedState(sortedMovies));
      }
    } catch (e) {
      emit(UpcomingMoviesOnFailedState(e.toString()));
    }
  }

  Future sortUpcomingMovies(SortType sortType) async {
    try {
      emit(const UpcomingMoviesOnProgressState());
      List<Results> sortedMovies = movieList;
      if (sortType == SortType.popularity) {
        sortedMovies.sort((a, b) => a.popularity!.compareTo(b.popularity!));
      } else if (sortType == SortType.voteAverage) {
        sortedMovies.sort((a, b) => a.voteAverage!.compareTo(b.voteAverage!));
      } else if (sortType == SortType.voteCount) {
        sortedMovies.sort((a, b) => a.voteCount!.compareTo(b.voteCount!));
      }
      emit(UpcomingMoviesOnCompletedState(sortedMovies.reversed.toList()));
    } catch (e) {
      emit(UpcomingMoviesOnFailedState(e.toString()));
    }
  }
}
