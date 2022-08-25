import 'dart:convert';
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/constant.dart';
import '../../model/movies_model.dart';

part 'upcoming_movies_state.dart';

class UpcomingMoviesCubit extends Cubit<UpcomingMoviesState> {
  UpcomingMoviesCubit() : super(const UpcomingMoviesInitialState());

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
        List<Results> movieList = createMovieList(results);
        // Print the results.
        emit(UpcomingMoviesOnCompletedState(movieList));
      } else {
        emit(const UpcomingMoviesOnFailedState("Failed http call."));
      }
    } catch (exception) {
      emit(UpcomingMoviesOnFailedState(exception.toString()));
    }
  }
}
