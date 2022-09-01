import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/domain/model/movies_model.dart';
import 'package:movie_app/utils/constant.dart';
import 'package:movie_app/utils/routes.dart';

class MovieCardItem extends StatelessWidget {
  const MovieCardItem(this._resultsModel, {Key? key}) : super(key: key);
  final Results _resultsModel;

  @override
  Widget build(BuildContext context) {
    return GridTile(
        footer: GridTileBar(
          backgroundColor: Colors.black45,
          title: Text(
            _resultsModel.title!,
            style: const TextStyle(fontWeight: FontWeight.w400),
          ),
        ),
        // header: Center(
        //   child: Text(
        //     '${_resultsModel.popularity}\n${_resultsModel.voteAverage}\n${_resultsModel.voteCount}',
        //     style: const TextStyle(
        //       color: Colors.red,
        //       fontSize: 18,
        //       fontWeight: FontWeight.w600,
        //     ),
        //   ),
        // ),
        child: GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, Routes.movieDetailsPage,
                arguments: {'movieId': _resultsModel.id});
          },
          child: Hero(
            tag: _resultsModel.id.toString(),
            child: CachedNetworkImage(
              fit: BoxFit.cover,
              imageUrl: imageBaseUrl + _resultsModel.posterPath!,
            ),
          ),
        ));
  }
}
