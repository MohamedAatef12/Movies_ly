import 'package:flutter/material.dart';

import '../../models/movies/movie.dart';
import '../../models/trending/trending.dart';
import '../../models/tv/tv_model.dart';

import '../../widgets/widgets.dart';
import '../pages/details/details_screen.dart';
import '../pages/details/details_tv.dart';

class ViewAllTrending extends StatelessWidget {
  const ViewAllTrending({
    super.key, required this.future,
    required this.title,
  });
  final String title;
  final Future<List<Trending>?> future ;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: buildViewAllWidget(
          future,
          (context, trending) {
            if (trending.mediaType == 'movie') {
              return DetailsScreen(movie: Movie(
                id: trending.id,
                title: trending.title,
                overview: trending.overview,
                posterPath: trending.posterPath,
                backdropPath: trending.backdropPath,
                voteAverage: trending.voteAverage,
                releaseDate: trending.releaseDate,
                genreIds: trending.genreIds,
              ));
            }
            else {
              return DetailsTvScreen(tv: Tv(
                id: trending.id,
                name: trending.name,
                overview: trending.overview,
                posterPath: trending.posterPath,
                backdropPath: trending.backdropPath,
                voteAverage: trending.voteAverage,
                firstAirDate: trending.firstAirDate,
                genreIds: trending.genreIds,
              ));
            }
          },
          context,
          title,
          getTrendingData,
        ),
      ),
    );
  }
}
