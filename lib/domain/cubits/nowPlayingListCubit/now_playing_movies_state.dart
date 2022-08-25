part of 'now_playing_movies_cubit.dart';

@immutable
abstract class NowPlayingMoviesState extends Equatable {
  const NowPlayingMoviesState();
}

class NowPlayingMoviesInitialState extends NowPlayingMoviesState {
  const NowPlayingMoviesInitialState();

  @override 
  List<Object?> get props => [];
}

class NowPlayingMoviesOnCompletedState
    extends NowPlayingMoviesState {
  const NowPlayingMoviesOnCompletedState(this.resultList);
  final List<Results> resultList;
  @override
  List<Object?> get props => [resultList];
}

class NowPlayingMoviesOnProgressState
    extends NowPlayingMoviesState {
  const NowPlayingMoviesOnProgressState();

  @override
  List<Object?> get props => [];
}

class NowPlayingMoviesOnFailedState extends NowPlayingMoviesState {
  const NowPlayingMoviesOnFailedState(this.message);

  final String message;

  @override
  // TODO: implement props
  List<Object?> get props => [message];
}
