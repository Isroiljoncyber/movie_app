import 'package:flutter/material.dart';
import 'package:movie_app/domain/model/movie_details_model.dart';
import 'package:url_launcher/url_launcher.dart';

class AdditionalInfo extends StatelessWidget {
  const AdditionalInfo(this.movieDetailsModel, {Key? key}) : super(key: key);
  final MovieDetailsModel movieDetailsModel;

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Additional information",
          style: textTheme.subtitle1?.copyWith(
            fontSize: 18,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Row(
            children: [
              Icon(
                Icons.date_range_rounded,
                color: theme.colorScheme.secondary,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  movieDetailsModel.releaseDate!,
                  style: textTheme.titleMedium?.copyWith(),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Row(
            children: [
              Icon(
                Icons.favorite_border_rounded,
                color: theme.colorScheme.secondary,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  "${movieDetailsModel.voteCount!} likes",
                  style: textTheme.titleMedium?.copyWith(),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Row(
            children: [
              Icon(
                Icons.timer_outlined,
                color: theme.colorScheme.secondary,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  "${movieDetailsModel.runtime!} minutes",
                  style: textTheme.titleMedium?.copyWith(),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Row(
            children: [
              Icon(
                Icons.monetization_on_outlined,
                color: theme.colorScheme.secondary,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  "${movieDetailsModel.revenue!} USD",
                  style: textTheme.titleMedium?.copyWith(),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Row(
            children: [
              Icon(
                Icons.language_rounded,
                color: theme.colorScheme.secondary,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  "${movieDetailsModel.spokenLanguages?.first.name!}",
                  style: textTheme.titleMedium?.copyWith(),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Row(
            children: [
              Icon(
                Icons.emoji_flags_rounded,
                color: theme.colorScheme.secondary,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  "${movieDetailsModel.productionCountries?.first.name!}",
                  style: textTheme.titleMedium,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Row(
            children: [
              Icon(
                Icons.location_on_outlined,
                color: theme.colorScheme.secondary,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: GestureDetector(
                  onTap: () async {
                    try {
                      await launchUrl(Uri.parse(movieDetailsModel.homepage!),
                          mode: LaunchMode.inAppWebView);
                    } catch (e) {
                      debugPrint(e.toString());
                    }
                  },
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width - 80,
                    child: Text(
                      "${movieDetailsModel.homepage}",
                      overflow: TextOverflow.ellipsis,
                      style: textTheme.titleMedium
                          ?.copyWith(color: theme.colorScheme.secondary)
                      ,
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
