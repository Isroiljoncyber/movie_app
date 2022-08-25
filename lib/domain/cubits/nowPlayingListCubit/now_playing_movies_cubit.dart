import 'dart:convert';
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/domain/model/movies_model.dart';
import 'package:movie_app/utils/constant.dart';

part 'now_playing_movies_state.dart';

class NowPlayingMoviesCubit extends Cubit<NowPlayingMoviesState> {
  NowPlayingMoviesCubit()
      : super(const NowPlayingMoviesInitialState());

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
        List<Results> movieList = createMovieList(results);
        // Print the results.
        emit(NowPlayingMoviesOnCompletedState(movieList));
      } else {
        emit(const NowPlayingMoviesOnFailedState("Failed http call."));
      }
    } catch (exception) {
      emit(NowPlayingMoviesOnFailedState(exception.toString()));
    }
  }
}
