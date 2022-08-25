import 'package:flutter/material.dart';
import 'package:movie_app/domain/model/movie_details_model.dart';
import 'package:movie_app/utils/constant.dart';
import 'package:movie_app/utils/routes.dart';

import 'arc_banner_image.dart';
import 'movie_details_poster.dart';
import 'movie_details_rating_info.dart';

class MovieDetailHeader extends StatelessWidget {
  const MovieDetailHeader(this.movies, {super.key});

  final MovieDetailsModel movies;

  _buildCategoryChips(TextTheme textTheme) {
    return movies.genres!.map((genres) {
      return Chip(
        label: Text(genres.name!),
        labelStyle: textTheme.caption,
        backgroundColor: Colors.black12,
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    var movieInformation = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Text(
            movies.originalTitle!,
            style: textTheme.titleLarge,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: RatingInformation(movies),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 12),
          child: Wrap(
            spacing: 5.0,
            runSpacing: -10.0,
            direction: Axis.horizontal,
            children: _buildCategoryChips(textTheme),
          ),
        )
      ],
    );

    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 240.0),
          child: ArcBannerImage("$imageBaseUrl${movies.backdropPath!}"),
        ),
        Positioned(
          bottom: 32.0,
          left: 16.0,
          right: 16.0,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 70.0),
                child: Hero(
                  tag: movies.id.toString(),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, Routes.movieTrailerPage,
                          arguments: {'movieId': movies.id, "movieName": movies.title});
                    },
                    child: Poster(
                      '$imageBaseUrl${movies.posterPath}',
                      height: 190.0,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0, bottom: 0),
                  child: movieInformation,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
