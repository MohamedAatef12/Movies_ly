import 'package:flutter/material.dart';
import '../../api/api_service.dart';
import '../../screens/pages/details/details_tv.dart';
import '../../widgets/widgets.dart';

class TabBuilderSeries extends StatefulWidget {
  const TabBuilderSeries({
    Key? key,

  }) : super(key: key);

  @override
  State<TabBuilderSeries> createState() => _TabBuilderState();
}

class _TabBuilderState extends State<TabBuilderSeries> {

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          Stack(
            children: [
              buildCarouselSlider(
                ApiService.getCustomTvShows('on_the_air'),
                (context, tv) => DetailsTvScreen(tv: tv),
                setState,
                getTvPosterPath
              ),
              buildDots(context),
            ],
          ),
          buildTvShowWidget(title: 'Top Rated', context: context),
          buildBottomTvWidget(future: ApiService.getCustomTvShows('top_rated')),
          buildTvShowWidget(title: 'Popular', context: context),
          buildBottomTvWidget(future: ApiService.getCustomTvShows('popular')),
        ],
      ),
    );
  }
}
