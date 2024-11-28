import 'package:flutter/material.dart';
import 'package:movies_ly/models/movies/movie.dart';

import '../../widgets/widgets.dart';
import '../pages/details/details_screen.dart';


class ViewAllAnime extends StatelessWidget {
  const ViewAllAnime({
    super.key,
    required this.title,
    required this.future,
  });
  final String title;
  final Future<List<Movie>?> future;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: buildViewAllWidget(
            future,
            (context, movie) => DetailsScreen(movie: movie),
            context,
            title,
            getMovieData,
          )
      ),
    );
  }
}
