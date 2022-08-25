import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/domain/cubits/movieTrailersCubit/movie_trailers_cubit.dart';
import 'package:movie_app/screen/widgets/movie_trailer_item.dart';

class MovieTrailerPage extends StatelessWidget {
  const MovieTrailerPage(this.movieId, this.movieName, {Key? key}) : super(key: key);
  final int movieId;
  final String movieName;

  @override
  Widget build(BuildContext context) {
    context.read<MovieTrailersCubit>().getTrailers(movieId);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(movieName),
        centerTitle: true,
      ),
      body: BlocBuilder<MovieTrailersCubit, MovieTrailersState>(
        builder: (context, state) {
          if (state is MovieTrailersOnCompletedState) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: state.trailerList.length,
                itemBuilder: (context, index) {
                  return MoviesTrailerItem(state.trailerList[index]);
                },
              ),
            );
          } else if (state is MovieTrailersOnProgressState) {
            return Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).colorScheme.secondary,
              ),
            );
          } else if (state is MovieTrailersOnFailedState) {
            return Center(
              child: Text(state.message),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
