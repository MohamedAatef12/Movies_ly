import 'package:flutter/material.dart';
import '../../api/api_service.dart';
import '../../screens/pages/details/details_screen.dart';
import '../../widgets/widgets.dart';

class TabBuilderMovie extends StatefulWidget {
   const TabBuilderMovie({
    super.key,
  });

  @override
  State<TabBuilderMovie> createState() => _TabBuilderState();
}
class _TabBuilderState extends State<TabBuilderMovie> {
  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Stack(
              children: [
                buildCarouselSlider(
                  ApiService.getCustomMovies('upcoming'),
                      (context, movie) => DetailsScreen(movie: movie),
                      setState,
                      getMoviePosterPath
                ),
                buildDots(context),
              ],
            ),
            buildMovieWidget(title:'Top Rated',context: context,),
            buildBottomMovieWidget(future: ApiService.getCustomMovies('top_rated'),),
            buildMovieWidget(title: 'Now Playing',context: context),
            buildBottomMovieWidget(future: ApiService.getCustomMovies('now_playing')),
          ],
        ),
    );
  }
}
