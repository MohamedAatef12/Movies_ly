import 'package:flutter/material.dart';

import '../../models/tv/tv_model.dart';
import '../../widgets/widgets.dart';
import '../pages/details/details_tv.dart';


class ViewAllTvAnime extends StatelessWidget {
  const ViewAllTvAnime({
    super.key,
    required this.title,
    required this.future,
  });
  final String title;
  final Future<List<Tv>?> future;


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: buildViewAllWidget(
          future,
          (context, tv) => DetailsTvScreen(tv: tv),
          context,
          title,
          getTvData,
        )
      ),
    );
  }
}
