part of 'movie_detail_cubit.dart';

@immutable
abstract class MovieDetailState extends Equatable {
  const MovieDetailState();
}

class MovieDetailInitialState extends MovieDetailState {
  const MovieDetailInitialState();

  @override
  List<Object> get props => [];
}

class MovieDetailOnCompletedState extends MovieDetailState {
  const MovieDetailOnCompletedState(this.movieDetailsModel);

  final MovieDetailsModel movieDetailsModel;

  @override
  List<Object> get props => [movieDetailsModel];
}

class MovieDetailOnProgressState extends MovieDetailState {
  const MovieDetailOnProgressState();

  @override
  List<Object> get props => [];
}

class MovieDetailOnFailedState extends MovieDetailState {
  const MovieDetailOnFailedState(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}
