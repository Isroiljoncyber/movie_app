part of 'popular_movies_cubit.dart';

abstract class PopularMoviesState extends Equatable {
  const PopularMoviesState();
}

class PopularMoviesInitialState extends PopularMoviesState {
  const PopularMoviesInitialState();

  @override
  List<Object> get props => [];
}

class PopularMoviesOnCompletedState extends PopularMoviesState {
  const PopularMoviesOnCompletedState(this.popularMoviesList);

  final List<Results> popularMoviesList;

  @override
  List<Object> get props => [popularMoviesList];
}

class PopularMoviesOnProgress extends PopularMoviesState {
  const PopularMoviesOnProgress();

  @override
  List<Object> get props => [];
}

class PopularMoviesOnFailed extends PopularMoviesState {
  const PopularMoviesOnFailed(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}
