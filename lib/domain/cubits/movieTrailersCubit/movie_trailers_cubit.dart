import 'dart:convert';
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/constant.dart';
import '../../model/movie_trailers_model.dart';

part 'movie_trailers_state.dart';

class MovieTrailersCubit extends Cubit<MovieTrailersState> {
  MovieTrailersCubit() : super(const MovieTrailersInitialState());

  Future getTrailers(int movieId) async {
    String trailerURI = "$baseUrl$movieId$trailerUrl${apiKeyWithAdd}1";
    var httpClient = HttpClient();
    try {
      emit(const MovieTrailersOnProgressState());
      var request = await httpClient.getUrl(Uri.parse(trailerURI));
      var response = await request.close();
      if (response.statusCode == HttpStatus.ok) {
        var jsonResponse = await response.transform(utf8.decoder).join();
        // Decode the json response
        var data = jsonDecode(jsonResponse);
        // Get the result list
        List results = data["results"];
        // Get the Movie list
        List<TrailerResults> movieList = createTrailerList(results);
        // Print the results.
        emit(MovieTrailersOnCompletedState(movieList));
      } else {
        emit(const MovieTrailersOnFailedState("Failed http call."));
      }
    } catch (exception) {
      emit(MovieTrailersOnFailedState(exception.toString()));
    }
  }
}
