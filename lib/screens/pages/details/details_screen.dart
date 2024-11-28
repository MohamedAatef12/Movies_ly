import 'package:cached_network_image/cached_network_image.dart';
import 'package:fade_shimmer/fade_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:icon_broken/icon_broken.dart';


import '../../../api/api.dart';
import '../../../api/api_service.dart';
import '../../../models/movies/movie.dart';
import '../../../utils/utils.dart';
import '../../../widgets/widgets.dart';
import '../../tabs/movies/tab_cast.dart';
import '../../tabs/movies/tab_review.dart';
import '../../tabs/movies/tab_screen_similar.dart';
import '../videos/video.dart';

class DetailsScreen extends StatelessWidget {
   DetailsScreen({
    Key? key,
    required this.movie,
    }) : super(key: key);
  final Movie movie;
  String? getMovieGenre(int movieId) {
    return Utils.getGenreById(movieId);
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

  final RegExp arabicRegex = RegExp(r'[\u0600-\u06FF]+');
  final RegExp englishRegex = RegExp(r'[a-zA-Z]+');

  bool isArabic(String search) => arabicRegex.hasMatch(search);
  bool isEnglish(String search) => englishRegex.hasMatch(search);

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
                  imageUrl: '${Api.imageBaseUrl}${movie.backdropPath}',
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
                    if(isArabic(movie.title,))
                      Text(
                        movie.title,
                        textDirection: TextDirection.rtl,
                        style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      )
                    else
                      Text(
                      movie.title,
                      textDirection: TextDirection.ltr,
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
                          movie.voteAverage.toStringAsPrecision(2),
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
                          movie.releaseDate.split('-')[0],
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
                          if (movie.genreIds.isNotEmpty)
                            for (int i = 0; i < movie.genreIds.length; i++)
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
                                          '   ${getMovieGenre(movie.genreIds[i])!}   ',
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
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                  ],
                ),
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
                        context, VideoScreen(
                            future : ApiService.getVideoMovies(movie.id,),
                        )
                      );
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
            TabCast(
              future:ApiService.getCastMovies(movie.id),
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
                    movie.overview,
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
            TabBuilderSimilar(
              future:ApiService.getRecMovies(movie.id),
            ),
            const SizedBox(
              height: 20,
            ),
            TabReview(
              future: ApiService.getReviewMovies(movie.id),
            ),
          ],
        ),
      ),
    );
  }
}
