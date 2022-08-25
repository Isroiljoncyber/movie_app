import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class Poster extends StatelessWidget {
  static const POSTER_RATIO = 0.7;

  const Poster(this.posterUrl, {this.height = 100.0, super.key});

  final String posterUrl;
  final double height;

  @override
  Widget build(BuildContext context) {
    var width = POSTER_RATIO * height;
    var theme = Theme.of(context);
    return Material(
      borderRadius: BorderRadius.circular(4.0),
      elevation: 2.0,
      child: Stack(
        children: [
          CachedNetworkImage(
            imageUrl: posterUrl,
            fit: BoxFit.cover,
            width: width,
            height: height,
          ),
          Container(
            width: width,
            height: height,
            decoration: const BoxDecoration(
              color: Color(0x67a5abff)
            ),
            child: const Positioned(
              top: 0,
              bottom: 0,
              left: 0,
              right: 0,
              child: Icon(
                Icons.play_circle_outline_rounded,
                color: Colors.white,
                size: 40,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
