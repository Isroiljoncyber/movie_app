import 'dart:convert';
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/domain/model/movies_model.dart';
import 'package:movie_app/utils/constant.dart';

import '../../../screen/main_page.dart';

part 'now_playing_movies_state.dart';

class NowPlayingMoviesCubit extends Cubit<NowPlayingMoviesState> {
  NowPlayingMoviesCubit() : super(const NowPlayingMoviesInitialState());

  List<Results> movieList = [];

  Future getNowPlayingMovies() async {
    const String nowPlaying = "${baseUrl}now_playing${apiKeyWithAdd}1";
    var httpClient = HttpClient();
    try {
      emit(const NowPlayingMoviesOnProgressState());
      var request = await httpClient.getUrl(Uri.parse(nowPlaying));
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
        emit(NowPlayingMoviesOnCompletedState(movieList));
      } else {
        emit(const NowPlayingMoviesOnFailedState("Failed http call."));
      }
    } catch (exception) {
      emit(NowPlayingMoviesOnFailedState(exception.toString()));
    }
  }

  Future searchNowPlayingMovies(String movieName) async {
    try {
      emit(const NowPlayingMoviesOnProgressState());
      List<Results> sortedMovies = [];
      for (var element in movieList) {
        if (element.title!.toLowerCase().contains(movieName.toLowerCase())) {
          sortedMovies.add(element);
        }
      }
      emit(NowPlayingMoviesOnCompletedState(sortedMovies));
    } catch (e) {
      emit(NowPlayingMoviesOnFailedState(e.toString()));
    }
  }

  Future sortNowPlayingMovies(SortType sortType) async {
    try {
      emit(const NowPlayingMoviesOnProgressState());
      List<Results> sortedMovies = movieList;
      if (sortType == SortType.popularity) {
        sortedMovies.sort((a, b) => a.popularity!.compareTo(b.popularity!));
      } else if (sortType == SortType.voteAverage) {
        sortedMovies.sort((a, b) => a.voteAverage!.compareTo(b.voteAverage!));
      } else if (sortType == SortType.voteCount) {
        sortedMovies.sort((a, b) => a.voteCount!.compareTo(b.voteCount!));
      }
      emit(NowPlayingMoviesOnCompletedState(sortedMovies.reversed.toList()));
    } catch (e) {
      emit(NowPlayingMoviesOnFailedState(e.toString()));
    }
  }
}
