import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/domain/cubits/upcomingMoviesCubit/upcoming_movies_cubit.dart';
import 'package:movie_app/screen/widgets/movie_card_item.dart';

class UpcomingPage extends StatelessWidget {
  const UpcomingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<UpcomingMoviesCubit>().getMoviesList();
    return SafeArea(
      child: BlocBuilder<UpcomingMoviesCubit, UpcomingMoviesState>(
          builder: (context, state) {
        if (state is UpcomingMoviesOnCompletedState) {
          return GridView.builder(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            physics: const BouncingScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              mainAxisExtent: 240,
            ),
            itemCount: state.moviesList.length,
            itemBuilder: (context, index) {
              return MovieCardItem(state.moviesList[index]);
            },
          );
        } else if (state is UpcomingMoviesOnProgressState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is UpcomingMoviesOnFailedState) {
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
