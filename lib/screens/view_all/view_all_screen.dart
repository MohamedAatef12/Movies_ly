import 'package:fade_shimmer/fade_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:icon_broken/icon_broken.dart';

import '../../models/movies/movie.dart';
import '../../utils/utils.dart';
import '../../widgets/widgets.dart';
import '../pages/details/details_screen.dart';

class ViewAllScreen extends StatelessWidget {
  const ViewAllScreen({
    super.key,
    required this.title,
    required this.future,
  });
  final String title;
  final Future<List<Movie>?> future;

  String? getMovieGenre(int movieId) {
    return Utils.getGenreById(movieId);
  }
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
