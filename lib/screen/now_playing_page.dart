import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/domain/cubits/nowPlayingListCubit/now_playing_movies_cubit.dart';
import 'package:movie_app/screen/widgets/movie_card_item.dart';

class NewPlayingPage extends StatelessWidget {
  const NewPlayingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<NowPlayingMoviesCubit>().getNowPlayingMovies();
    return SafeArea(
      child: BlocBuilder<NowPlayingMoviesCubit, NowPlayingMoviesState>(
          builder: (context, state) {
        if (state is NowPlayingMoviesOnCompletedState) {
          return GridView.builder(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
            physics: const BouncingScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 5,
              mainAxisSpacing: 5,
              mainAxisExtent: 240
            ),
            itemCount: state.resultList.length,
            itemBuilder: (context, index) {
              return MovieCardItem(state.resultList[index]);
            },
          );
        } else if (state is NowPlayingMoviesOnProgressState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is NowPlayingMoviesOnFailedState) {
          return Center(
            child: Text(state.message),
          );
        } else {
          return const SizedBox.shrink();
        }
      }),
    );
  }
}
