import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/domain/cubits/popularMoviesCubit/popular_movies_cubit.dart';
import 'package:movie_app/screen/widgets/movie_card_item.dart';

class PopularPage extends StatelessWidget {
  const PopularPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<PopularMoviesCubit>().getMoviesList();
    return SafeArea(
      child: BlocBuilder<PopularMoviesCubit, PopularMoviesState>(
          builder: (context, state) {
        if (state is PopularMoviesOnCompletedState) {
          return GridView.builder(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            physics: const BouncingScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              mainAxisExtent: 240,
            ),
            itemCount: state.popularMoviesList.length,
            itemBuilder: (context, index) {
              return MovieCardItem(state.popularMoviesList[index]);
            },
          );
        } else if (state is PopularMoviesOnProgress) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is PopularMoviesOnFailed) {
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
