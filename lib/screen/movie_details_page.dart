import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/domain/cubits/movieDetailsCubit/movie_detail_cubit.dart';
import 'package:movie_app/screen/widgets/movie_details_additional_info.dart';
import 'package:movie_app/screen/widgets/movie_details_header.dart';
import 'package:movie_app/screen/widgets/movie_details_production_companies_scroller.dart';
import 'package:movie_app/screen/widgets/movie_details_story_line.dart';


class MovieDetailsPage extends StatelessWidget {
  const MovieDetailsPage(this.movieId, {Key? key}) : super(key: key);
  final int movieId;

  @override
  Widget build(BuildContext context) {
    context.read<MovieDetailCubit>().getMovieDetails(movieId);
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocBuilder<MovieDetailCubit, MovieDetailState>(
        // bloc: MovieDetailCubit(),
        builder: (context, state) {
          if (state is MovieDetailOnCompletedState) {
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MovieDetailHeader(state.movieDetailsModel),
                  StoryLine(state.movieDetailsModel.overview!),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 20.0,
                      bottom: 10.0,
                    ),
                    child: ProductionCompaniesScroller(
                        state.movieDetailsModel.productionCompanies!),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 16, right: 16, bottom: 30),
                    child: AdditionalInfo(state.movieDetailsModel),
                  )
                ],
              ),
            );
          } else if (state is MovieDetailOnProgressState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is MovieDetailOnFailedState) {
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
