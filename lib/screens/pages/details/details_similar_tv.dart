import 'package:cached_network_image/cached_network_image.dart';
import 'package:fade_shimmer/fade_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:icon_broken/icon_broken.dart';

import '../../../api/api.dart';
import '../../../api/api_service.dart';
import '../../../models/tv/tv_model.dart';
import '../../../utils/utils_tv.dart';
import '../../../widgets/widgets.dart';
import '../../tabs/tv/tab_cast_tv.dart';
import '../../tabs/tv/tab_review_tv.dart';
import '../../tabs/tv/tab_similar_tv.dart';
import '../videos/video_tv.dart';

class DetailsSimilarTvScreen extends StatelessWidget {
  const DetailsSimilarTvScreen({
    Key? key,
    required this.tv,
  }) : super(key: key);
  final Tv tv;
  String? getMovieGenre(int movieId) {
    return UtilsTv.getGenreById(movieId);
  }
  String truncateText(String text, int maxWords) {
    List<String> words = text.split(' ');
    if (words.length <= maxWords) {
      return text;
    } else {
      List<String> truncatedWords = words.sublist(0, maxWords);
      return '${truncatedWords.join(' ')}...';
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                CachedNetworkImage(
                  imageUrl: '${Api.imageBaseUrl}${tv.backdropPath}',
                  imageBuilder :(context,imageProvider) => Container(
                    height: MediaQuery.of(context).size.height * 0.55,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: FractionalOffset.topCenter,
                          end: FractionalOffset.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.transparent,
                            Colors.transparent,
                            Colors.black,
                          ],
                        ),
                      ),
                    ),
                  ),
                  errorWidget: (_, __, ___) => const Center(
                    child: Icon(
                      Icons.broken_image,
                      size: 40,
                    ),
                  ),
                  placeholder: (_, __) => FadeShimmer(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * .55,
                    highlightColor: const Color(0xff22272f),
                    baseColor: const Color(0xff20252d),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 40,
                  ),
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    padding: const EdgeInsets.all(0),
                    icon: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                          color: Colors.blueGrey.withOpacity(.6),
                          borderRadius: BorderRadius.circular(13)),
                      child: const Icon(
                        IconBroken.Arrow___Left_2,
                        size: 25,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 20,
                right: 20,

              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tv.name,
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Text(
                        tv.voteAverage.toStringAsPrecision(2),
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(
                        width: 3,
                      ),
                      const Icon(
                        Icons.star,
                        color: Colors.yellow,
                        size: 20,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        tv.firstAirDate.split('-')[0],
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    child: Row(
                      children: [
                        if (tv.genreIds.isNotEmpty)
                          for (int i = 0; i < tv.genreIds.length; i++)
                            Row(
                              children: [
                                FittedBox(
                                  child: Container(
                                    height: 25,
                                    decoration: BoxDecoration(
                                      color: HexColor('#3356FE'),
                                      borderRadius: BorderRadius.circular(13),
                                    ),
                                    child: Center(
                                      child: Text(
                                        '   ${getMovieGenre(tv.genreIds[i])!}   ',
                                        style: const TextStyle(
                                          fontSize: 15,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                              ],
                            ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      navigateTo(
                          context,
                          VideoTvScreen(
                            future : ApiService.getVideoTv(tv.id,),
                          ));
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.06,
                      width: MediaQuery.of(context).size.width* 0.57,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: HexColor('#0FA125'),
                      ),
                      child:  const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.play_arrow_rounded,
                            color: Colors.white,
                            size: 30,
                          ),
                          SizedBox(
                            width: 3,
                          ),
                          Text(
                            'Watch Trailer',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                Material(
                  type: MaterialType.transparency,
                  child: Ink(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      border: Border.all(width: 1.0, color: Colors.grey),
                      color: Colors.black,
                    ),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(14),
                      onTap: () {},
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(
                          IconBroken.Download,
                          size: 28.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Material(
                  type: MaterialType.transparency,
                  child: Ink(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      border: Border.all(width: 1.0, color: Colors.grey),
                      color: Colors.black,
                    ),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(14),
                      onTap: () {},
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(
                          IconBroken.Send,
                          size: 28.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            TabCastTv(
              future:ApiService.getCastTv(tv.id),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Overview',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    tv.overview,
                    style: const TextStyle(
                      overflow: TextOverflow.fade,
                      fontSize: 18,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TabBuilderSimilarTv(
              future:ApiService.getReTv(tv.id),
            ),
            const SizedBox(
              height: 20,
            ),
            TabReviewTv(
              future: ApiService.getReviewTv(tv.id),
            ),
          ],
        ),
      ),
    );
  }
}
