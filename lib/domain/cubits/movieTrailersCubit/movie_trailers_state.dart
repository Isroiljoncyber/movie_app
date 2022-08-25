part of 'movie_trailers_cubit.dart';

@immutable
abstract class MovieTrailersState extends Equatable {
  const MovieTrailersState();
}

class MovieTrailersInitialState extends MovieTrailersState {
  const MovieTrailersInitialState();

  @override
  List<Object?> get props => [];
}

class MovieTrailersOnCompletedState extends MovieTrailersState {
  const MovieTrailersOnCompletedState(this.trailerList);

  final List<TrailerResults> trailerList;

  @override
  List<Object?> get props => [trailerList];
}

class MovieTrailersOnProgressState extends MovieTrailersState {
  const MovieTrailersOnProgressState();

  @override
  List<Object?> get props => [];
}

class MovieTrailersOnFailedState extends MovieTrailersState {
  const MovieTrailersOnFailedState(this.message);

  final String message;

  @override
  List<Object?> get props => [];
}
