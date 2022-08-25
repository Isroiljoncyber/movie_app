import 'dart:convert';
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/domain/model/movie_details_model.dart';
import 'package:movie_app/utils/constant.dart';

part 'movie_detail_state.dart';

class MovieDetailCubit extends Cubit<MovieDetailState> {
  MovieDetailCubit() : super(const MovieDetailInitialState());

  Future getMovieDetails(int movieId) async {
    String movieDetailUrl = "$baseUrl$movieId${apiKeyWithAdd}1";
    var httpClient = HttpClient();
    try {
      emit(const MovieDetailOnProgressState());
      var request = await httpClient.getUrl(Uri.parse(movieDetailUrl));
      var response = await request.close();
      if (response.statusCode == HttpStatus.ok) {
        var jsonResponse = await response.transform(utf8.decoder).join();
        // Decode the json response
        var data = jsonDecode(jsonResponse);
        // Get the result list
        MovieDetailsModel model = MovieDetailsModel.fromJson(data);
        // List results = data["results"];
        // // Get the Movie list
        // List<Results> movieList = createMovieList(results);
        // // Print the results.
        emit(MovieDetailOnCompletedState(model));
      } else {
        emit(const MovieDetailOnFailedState("Failed http call."));
      }
    } catch (exception) {
      emit(MovieDetailOnFailedState(exception.toString()));
    }
  }
}
