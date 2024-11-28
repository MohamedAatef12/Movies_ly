import 'package:flutter/material.dart';
import '../../api/api_service.dart';
import '../../screens/pages/details/details_tv.dart';
import '../../widgets/widgets.dart';

class TabBuilderAnime extends StatefulWidget {
  const TabBuilderAnime({
    Key? key,
  }) : super(key: key);

  @override
  State<TabBuilderAnime> createState() => _TabBuilderState();
}
class _TabBuilderState extends State<TabBuilderAnime> {

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          Stack(
            children: [
              buildCarouselSlider(
                  ApiService.getAnimeTvShows('airing_today'),
                  (context, tv) => DetailsTvScreen(tv: tv),
                  setState,
                  getAnimePosterPath
              ),
              buildDots(context),
            ],
          ),
          buildAnimeMWidget(title: 'Top Rated Movies',context: context),
          buildBottomAnimeMWidget(future: ApiService.getAnimeMovie('top_rated')),
          buildAnimeWidget(title: 'Top Rated Anime',context: context),
          buildBottomAnimeWidget(future: ApiService.getAnimeTvShows('top_rated')),
          buildAnimeWidget(title: 'Popular',context: context),
          buildBottomAnimeWidget(future: ApiService.getAnimeTvShows('popular')
          ),
        ],
      ),
    );
  }
}
