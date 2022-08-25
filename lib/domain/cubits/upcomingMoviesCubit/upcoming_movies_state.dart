part of 'upcoming_movies_cubit.dart';

abstract class UpcomingMoviesState extends Equatable {
  const UpcomingMoviesState();
}

class UpcomingMoviesInitialState extends UpcomingMoviesState {
  const UpcomingMoviesInitialState();

  @override
  List<Object> get props => [];
}

class UpcomingMoviesOnCompletedState extends UpcomingMoviesState {
  const UpcomingMoviesOnCompletedState(this.moviesList);

  final List<Results> moviesList;

  @override
  List<Object?> get props => [moviesList];
}

class UpcomingMoviesOnProgressState extends UpcomingMoviesState {
  const UpcomingMoviesOnProgressState();

  @override
  List<Object?> get props => [];
}

class UpcomingMoviesOnFailedState extends UpcomingMoviesState {
  const UpcomingMoviesOnFailedState(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
