import 'dart:convert';
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/constant.dart';
import '../../model/movies_model.dart';

part 'popular_movies_state.dart';

class PopularMoviesCubit extends Cubit<PopularMoviesState> {
  PopularMoviesCubit() : super(const PopularMoviesInitialState());

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
        List<Results> movieList = createMovieList(results);
        // Print the results.
        emit(PopularMoviesOnCompletedState(movieList));
      } else {
        emit(const PopularMoviesOnFailed("Failed http call."));
      }
    } catch (exception) {
      emit(PopularMoviesOnFailed(exception.toString()));
    }
  }
}
