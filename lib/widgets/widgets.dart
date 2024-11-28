import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:fade_shimmer/fade_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../api/api.dart';
import '../api/api_service.dart';
import '../models/movies/movie.dart';
import '../models/trending/trending.dart';
import '../models/tv/tv_model.dart';
import '../screens/pages/details/details_screen.dart';
import '../screens/pages/details/details_tv.dart';
import '../screens/pages/search/search_screen.dart';
import '../screens/view_all/View_all_anime_movies.dart';
import '../screens/view_all/view_all_anime.dart';
import '../screens/view_all/view_all_screen.dart';
import '../screens/view_all/view_all_series.dart';
import '../screens/view_all/view_trending.dart';
import '../utils/utils.dart';
import '../utils/utils_tv.dart';

Widget? widget_1;
int activeIndex = 0;

bool isArabic(String text) {
  return text.codeUnitAt(0) >= 0x0600 && text.codeUnitAt(0) <= 0x06E0;
}

bool isEnglish(String text) {
  return text.codeUnitAt(0) >= 0x0061 && text.codeUnitAt(0) <= 0x007A;
}

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

Map<String, String?> getGenre(int id) {
  return {
  'tv':  UtilsTv.getGenreById(id),
  'movie': Utils.getGenreById(id),
  };
}

String getTvPosterPath(Tv tv) {
  return tv.posterPath;
}
String getMoviePosterPath(Movie movie) {
  return movie.posterPath;
}
String getAnimePosterPath(Tv tv) {
  return tv.posterPath;
}

Map<String, dynamic> getTvData(Tv tv) {
  return {
    'posterPath': tv.posterPath,
    'title': tv.name,
    'overview': tv.overview,
    'genreIds': tv.genreIds,
    'voteAverage': tv.voteAverage,
  };
}
Map<String, dynamic> getMovieData(Movie movie) {
  return {
    'posterPath': movie.posterPath,
    'title': movie.title,
    'overview': movie.overview,
    'genreIds': movie.genreIds,
    'voteAverage': movie.voteAverage,
  };
}
Map<String, dynamic> getTrendingData(Trending trending) {
  return {
    'posterPath': trending.posterPath,
    'title': trending.title,
    'name': trending.name,
    'overview': trending.overview,
    'genreIds': trending.genreIds,
    'voteAverage': trending.voteAverage,
    'mediaType': trending.mediaType,
  };
}

Widget buildTopWidget({required BuildContext context}) => Padding(
  padding: const EdgeInsets.only(
      top: 30.0, left: 12.0, right: 12.0),
  child: Row(
    children: [
      Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: const DecorationImage(
            image: AssetImage(
              'assets/images/letter_m.png',
            ),
            fit: BoxFit.cover,
          ),
        ),
      ),
      const Spacer(),
      IconButton(
        onPressed: () {
          navigateTo(context,  const SearchScreen());
        },
        padding: const EdgeInsets.all(0),
        icon: const Icon(
          IconBroken.Search,
          color: Colors.white,
          size: 25,
        ),
      ),
    ],
  ),
);
Widget buildTopReviewRow(snapshot) =>Row(
  children: [
    const Text(
      'Reviews',
      style: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
    const Spacer(),
    Text (
      '${snapshot.data!.length} Reviews',
      style: const TextStyle(
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    ),
  ],
);

Widget buildTrendingWidget(context,String title) => Row(
      children: [
         Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Spacer(),
        const Icon(
          IconBroken.Category,
          color: Colors.green,
          size: 15,
        ),
        TextButton(
          onPressed: () {
            if (title == 'Trending Movies') {
              navigateTo(context, ViewAllTrending(
                future: ApiService.getTrending('movie'),
                title:'Trending Movies',
              ),
              );
            } else  {
              navigateTo(context, ViewAllTrending(
                future: ApiService.getTrending('tv'),
                title:'Trending Tv Shows',
              ),
              );
            }
          },
          child: const Text(
            'View all',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );

Widget buildMovieWidget({required String title, required BuildContext context}) => Padding(
  padding: const EdgeInsets.symmetric(
    horizontal: 10.0,
    vertical: 10,
  ),
  child: Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(15),
      color: Colors.grey.shade900.withOpacity(.9),
    ),
    child: Row(
      children: [
        const SizedBox(
          width: 20,
        ),
         Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Spacer(),
        const Icon(
          IconBroken.Category,
          color: Colors.green,
          size: 15,
        ),
        TextButton(
          onPressed: () {
           if (title == 'Top Rated') {
             navigateTo(context, ViewAllScreen(
               title: title,
               future: ApiService.getCustomMovies('top_rated'),
                ),
             );
           } else  {
             navigateTo(context, ViewAllScreen(
               title: title,
               future: ApiService.getCustomMovies(
                   'popular'),
             ),
             );
           }
          },
          child: const Text(
            'View all',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(
          width: 20,
        ),
      ],
    ),
  ),
);
Widget buildTvShowWidget({required String title, required BuildContext context}) => Padding(
  padding: const EdgeInsets.symmetric(
    horizontal: 10.0,
    vertical: 10,
  ),
  child: Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(15),
      color: Colors.grey.shade900.withOpacity(.9),
    ),
    child: Row(
      children: [
        const SizedBox(
          width: 20,
        ),
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Spacer(),
        const Icon(
          IconBroken.Category,
          color: Colors.green,
          size: 15,
        ),
        TextButton(
          onPressed: () {
            if (title == 'Top Rated') {
              navigateTo(context, ViewAllTvSeries(
                title: title,
                future: ApiService.getCustomTvShows(
                    'top_rated'
                ),
              ),
              );
            } else  {
              navigateTo(context, ViewAllTvSeries(
                title: title,
                future: ApiService.getCustomTvShows(
                    'popular'),
              ),
              );
            }
          },
          child: const Text(
            'View all',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(
          width: 20,
        ),
      ],
    ),
  ),
);
Widget buildAnimeWidget({required String title, required BuildContext context}) => Padding(
  padding: const EdgeInsets.symmetric(
    horizontal: 10.0,
    vertical: 10,
  ),
  child: Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(15),
      color: Colors.grey.shade900.withOpacity(.9),
    ),
    child: Row(
      children: [
        const SizedBox(
          width: 20,
        ),
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Spacer(),
        const Icon(
          IconBroken.Category,
          color: Colors.green,
          size: 15,
        ),
        TextButton(
          onPressed: () {
            if (title == 'Top Rated Tv Shows') {
              navigateTo(context, ViewAllTvAnime (
                title: title,
                future: ApiService.getAnimeTvShows('top_rated'),
              ),
              );
            } else  {
              navigateTo(context, ViewAllTvAnime(
                title: title,
                future: ApiService.getAnimeTvShows(
                    'popular'),
              ),
              );
            }
          },
          child: const Text(
            'View all',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(
          width: 20,
        ),
      ],
    ),
  ),
);
Widget buildAnimeMWidget({required String title, required BuildContext context}) => Padding(
  padding: const EdgeInsets.symmetric(
    horizontal: 10.0,
    vertical: 10,
  ),
  child: Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(15),
      color: Colors.grey.shade900.withOpacity(.9),
    ),
    child: Row(
      children: [
        const SizedBox(
          width: 20,
        ),
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Spacer(),
        const Icon(
          IconBroken.Category,
          color: Colors.green,
          size: 15,
        ),
        TextButton(
          onPressed: () {
              navigateTo(context, ViewAllAnime(
                title: title,
                future: ApiService.getAnimeMovie(
                    'top_rated'),
              ),
              );
          },
          child: const Text(
            'View all',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(
          width: 20,
        ),
      ],
    ),
  ),
);


Widget buildBottomTvWidget({required Future<List<Tv>?> future}) => Padding(
  padding: const EdgeInsets.only(
    left: 12.0,
    right: 12.0,
  ),
  child: FutureBuilder<List<Tv>?>(
    future: future,
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.35,
          child: GridView.builder(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              childAspectRatio: 1.5,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
            ),
            itemCount: 6,
            itemBuilder: (context, index) => GestureDetector(
              onTap: () {
                navigateTo(
                  context,
                  DetailsTvScreen(
                    tv: snapshot.data![index],
                  ),
                );
              },
              child: Stack(
                alignment: Alignment.bottomLeft,
                children: [
                  CachedNetworkImage(
                    imageUrl:
                    '${Api.imageBaseUrl}${snapshot.data![index].posterPath}',
                    imageBuilder: (context, imageProvider) => ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image(
                        image: imageProvider,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      ),
                    ),
                    errorWidget: (_, __, ___) => const Center(
                      child: Icon(
                        Icons.broken_image,
                        size: 40,
                      ),
                    ),
                    placeholder: (_, __) => ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: FadeShimmer(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * .7,
                        highlightColor: const Color(0xff22272f),
                        baseColor: const Color(0xff20252d),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.09,
                    width: double.infinity,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(
                          sigmaX: 10,
                          sigmaY: 10,
                        ),
                        child: Container(
                          color: Image.network(
                            'https://image.tmdb.org/t/p/w300/${snapshot.data![index].posterPath}',
                          ).color,
                        ),
                      ),
                    ),
                  ),
                  ListTile(
                    contentPadding: const EdgeInsets.only(
                      left: 8,
                      bottom: 12,
                      right: 8,
                    ),
                    title: Text(
                      snapshot.data![index].name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    trailing: Text(
                      '${snapshot.data![index].voteAverage} ⭐',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      } else {
        return buildTabShimmer(
          context,
          MediaQuery.of(context).size.width * .5,
          MediaQuery.of(context).size.height * .35,
          Axis.horizontal,
        );
      }
    },
  ),
);
Widget buildBottomMovieWidget({required Future<List<Movie>?> future}) => Padding(
  padding: const EdgeInsets.only(
    left: 12.0,
    right: 12.0,
  ),
  child: FutureBuilder<List<Movie>?>(
    future: future,
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.35,
          child: GridView.builder(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              childAspectRatio: 1.5,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
            ),
            itemCount: 6,
            itemBuilder: (context, index) => GestureDetector(
              onTap: () {
                navigateTo(
                    context, DetailsScreen(movie: snapshot.data![index]
                ));
              },
              child: Stack(
                alignment: Alignment.bottomLeft,
                children: [
                  CachedNetworkImage(
                    imageUrl:
                    '${Api.imageBaseUrl}${snapshot.data![index].posterPath}',
                    imageBuilder: (context, imageProvider) => ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image(
                        image: imageProvider,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      ),
                    ),
                    errorWidget: (_, __, ___) => const Center(
                      child: Icon(
                        Icons.broken_image,
                        size: 40,
                      ),
                    ),
                    placeholder: (_, __) => ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: FadeShimmer(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * .7,
                        highlightColor: const Color(0xff22272f),
                        baseColor: const Color(0xff20252d),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.09,
                    width: double.infinity,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(
                          sigmaX: 10,
                          sigmaY: 10,
                        ),
                        child: Container(
                          color: Image.network(
                            'https://image.tmdb.org/t/p/w300/${snapshot.data![index].posterPath}',
                          ).color,
                        ),
                      ),
                    ),
                  ),
                  ListTile(
                    contentPadding: const EdgeInsets.only(
                      left: 8,
                      bottom: 12,
                      right: 8,
                    ),
                    title: Text(
                      snapshot.data![index].title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    trailing: Text(
                      '${snapshot.data![index].voteAverage} ⭐',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      } else {
        return buildTabShimmer(
          context,
          MediaQuery.of(context).size.width * 0.5,
          MediaQuery.of(context).size.height * .35,
          Axis.horizontal,
        );
      }
    },
  ),
);
Widget buildBottomAnimeWidget({required Future<List<Tv>?> future}) => Padding(
  padding: const EdgeInsets.only(
    left: 12.0,
    right: 12.0,
  ),
  child: FutureBuilder<List<Tv>?>(
    future: future,
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.35,
          child: GridView.builder(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              childAspectRatio: 1.5,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
            ),
            itemCount: 6,
            itemBuilder: (context, index) => GestureDetector(
              onTap: () {
                navigateTo(
                  context, DetailsTvScreen(
                  tv: snapshot.data![index],
                ),);
              },
              child: Stack(
                alignment: Alignment.bottomLeft,
                children: [
                  CachedNetworkImage(
                    imageUrl:
                    '${Api.imageBaseUrl}${snapshot.data![index].posterPath}',
                    imageBuilder: (context, imageProvider) => ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image(
                        image: imageProvider,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      ),
                    ),
                    errorWidget: (_, __, ___) => const Center(
                      child: Icon(
                        Icons.broken_image,
                        size: 40,
                      ),
                    ),
                    placeholder: (_, __) => ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: FadeShimmer(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height ,
                        highlightColor: const Color(0xff22272f),
                        baseColor: const Color(0xff20252d),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.09,
                    width: double.infinity,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(
                          sigmaX: 10,
                          sigmaY: 10,
                        ),
                        child: Container(
                          color: Image.network(
                            'https://image.tmdb.org/t/p/w300/${snapshot.data![index].posterPath}',
                          ).color,
                        ),
                      ),
                    ),
                  ),
                  ListTile(
                    contentPadding: const EdgeInsets.only(
                      left: 8,
                      bottom: 12,
                      right: 8,
                    ),
                    title: Text(
                      snapshot.data![index].name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    trailing: Text(
                      '${snapshot.data![index].voteAverage} ⭐',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      } else {
        return buildTabShimmer(
          context,
          MediaQuery.of(context).size.width * 0.5,
          MediaQuery.of(context).size.height * .35,
          Axis.horizontal,
        );
      }
    },
  ),
);
Widget buildBottomAnimeMWidget({required Future<List<Movie>?> future}) => Padding(
  padding: const EdgeInsets.only(
    left: 12.0,
    right: 12.0,
  ),
  child: FutureBuilder<List<Movie>?>(
    future: future,
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.35,
          child: GridView.builder(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              childAspectRatio: 1.5,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
            ),
            itemCount: 6,
            itemBuilder: (context, index) => GestureDetector(
              onTap: () {
                navigateTo(
                  context, DetailsScreen(
                  movie: snapshot.data![index],
                ),);
              },
              child: Stack(
                alignment: Alignment.bottomLeft,
                children: [
                  CachedNetworkImage(
                    imageUrl:
                    '${Api.imageBaseUrl}${snapshot.data![index].posterPath}',
                    imageBuilder: (context, imageProvider) => ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image(
                        image: imageProvider,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      ),
                    ),
                    errorWidget: (_, __, ___) => const Center(
                      child: Icon(
                        Icons.broken_image,
                        size: 40,
                      ),
                    ),
                    placeholder: (_, __) => ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: FadeShimmer(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height ,
                        highlightColor: const Color(0xff22272f),
                        baseColor: const Color(0xff20252d),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.09,
                    width: double.infinity,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(
                          sigmaX: 10,
                          sigmaY: 10,
                        ),
                        child: Container(
                          color: Image.network(
                            'https://image.tmdb.org/t/p/w300/${snapshot.data![index].posterPath}',
                          ).color,
                        ),
                      ),
                    ),
                  ),
                  ListTile(
                    contentPadding: const EdgeInsets.only(
                      left: 8,
                      bottom: 12,
                      right: 8,
                    ),
                    title: Text(
                      snapshot.data![index].title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    trailing: Text(
                      '${snapshot.data![index].voteAverage} ⭐',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      } else {
        return buildTabShimmer(
          context,
          MediaQuery.of(context).size.width * 0.5,
          MediaQuery.of(context).size.height * .35,
          Axis.horizontal,
        );
      }
    },
  ),
);

Widget buildViewAllWidget<model>(
  Future<List<model>?> future,
  Widget Function(BuildContext,model) detailsScreenBuilder,
  BuildContext context,
  String title,
  Map Function(model) getData,)
=> Column(
  children: [
    Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10.0,
        vertical: 10,
      ),
      child: Row(
        children: [
          IconButton(
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
              child:const Icon(
                IconBroken.Arrow___Left_2,
                size: 25,
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 25,
            ),
          ),
        ],
      ),
    ),
    Expanded(
      child: FutureBuilder<List<model>?>(
        future: future,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.separated(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(
                  height: 10,
                );
              },
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    navigateTo(
                      context,
                      detailsScreenBuilder(
                        context,
                        snapshot.data![index],
                      )
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10.0,
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.35,
                          height: MediaQuery.of(context).size.height * 0.25,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.grey.shade900.withOpacity(.6),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.network(
                              'https://image.tmdb.org/t/p/w500/${getData(snapshot.data![index])['posterPath']}',
                              errorBuilder: (_, __, ___) => const Center(
                                child: Icon(
                                  Icons.broken_image,
                                  size: 40,
                                ),
                              ),
                              loadingBuilder: (_, __, ___) {
                                if (___ == null) return __;
                                return const FadeShimmer(
                                  width: 180,
                                  height: 250,
                                  highlightColor: Color(0xff22272f),
                                  baseColor: Color(0xff20252d),
                                );
                              },
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                 getData(snapshot.data![index])['title'] ,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                '${getData(snapshot.data![index])['overview']}',
                                maxLines: 2,
                                style: const TextStyle(
                                  overflow: TextOverflow.fade,
                                  color: Colors.grey,
                                  fontSize: 15,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                physics: const BouncingScrollPhysics(),
                                child: Row(
                                  children: [
                                    if ( getData(snapshot.data![index])['genreIds'].isNotEmpty)
                                      for (int i = 0; i < getData(snapshot.data![index])['genreIds'].length; i++)
                                        Row(
                                          children: [
                                            FittedBox(
                                              fit: BoxFit.fitWidth,
                                              child: Container(
                                                height: 25,
                                                decoration: BoxDecoration(
                                                  color: HexColor('#3356FE'),
                                                  borderRadius: BorderRadius.circular(13),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    '   ${getGenre(
                                                        getData(snapshot.data![index])['genreIds'][i])['tv']
                                                        ?? getGenre(getData(snapshot.data![index])['genreIds'][i])['movie']
                                                    }   ',
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
                                )
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Text(
                                    getData(snapshot.data![index])['voteAverage'].toStringAsPrecision(2),
                                    style: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 18,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  const Icon(
                                    Icons.star,
                                    color: Colors.yellow,
                                    size: 18,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            return Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 15.0,
              ),
              child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemCount: 15,
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(
                    height: 10,
                  );
                },
                itemBuilder:(context,index) => ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: FadeShimmer(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * .15,
                    highlightColor: const Color(0xff22272f),
                    baseColor: const Color(0xff20252d),
                  ),
                ),
              ),
            );
          }
        },
      ),
    ),
  ],
);


Widget buildCarouselSlider<model>(
   Future<List<model>?> future,
   Widget Function(BuildContext,model) detailsScreenBuilder,
   setState,
   String Function(model) getPosterPath,)
=> FutureBuilder<List<model>?>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return SizedBox(
            child: CarouselSlider.builder(
              itemCount: 6,
              itemBuilder: (context, index, realIndex) =>
                  GestureDetector(
                    onTap: () {
                      navigateTo(
                        context,
                        detailsScreenBuilder(
                          context,
                          snapshot.data![index],
                        ),
                      );
                    },
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        CachedNetworkImage(
                          imageUrl: '${Api.imageBaseUrl}${getPosterPath(snapshot.data![index])}',
                          imageBuilder: (context, imageProvider) =>
                              Container(
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
                                        Colors.transparent,
                                        Colors.black,
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                          errorWidget: (_, __, ___) =>
                          const Center(
                            child: Icon(
                              Icons.broken_image,
                              size: 40,
                            ),
                          ),
                          placeholder: (_, __) =>
                              FadeShimmer(
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width,
                                height: MediaQuery
                                    .of(context)
                                    .size
                                    .height * .65,
                                highlightColor: const Color(0xff22272f),
                                baseColor: const Color(0xff20252d),
                              ),
                        ),
                      ],
                    ),
                  ),
              options: CarouselOptions(
                height: MediaQuery.of(context).size.height * .65,
                viewportFraction: 1,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 3),
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                onPageChanged: (index, reason) {
                  setState(() {
                    activeIndex = index;
                  });
                },
                scrollDirection: Axis.horizontal,
              ),
            ),
          );
        } else {
          return FadeShimmer(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * .65,
            highlightColor: const Color(0xff22272f),
            baseColor: const Color(0xff20252d),
          );
        }
      },
    );

Widget buildTabShimmer(context,width ,height,scrollDirection) => SingleChildScrollView(
  scrollDirection: scrollDirection,
  physics: const BouncingScrollPhysics(),
  child: Row(
    children: [
      ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: FadeShimmer(
          width: width,
          height:  height,
          highlightColor: const Color(0xff22272f),
          baseColor: const Color(0xff20252d),
        ),
      ),
      const SizedBox(width: 10,),
      ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: FadeShimmer(
          width: width - 10,
          height:  height,
          highlightColor: const Color(0xff22272f),
          baseColor: const Color(0xff20252d),
        ),
      ),
    ],
  ),
);

Widget buildDots(context) => Positioned(
  bottom: 10,
  left: MediaQuery.of(context).size.width * .43,
  child: AnimatedSmoothIndicator(
    effect: ExpandingDotsEffect(
      dotColor: Colors.green[900]!.withOpacity(.5),
      activeDotColor: HexColor('#0FA125').withOpacity(.5),
      dotHeight: 6.0,
      dotWidth: 6.0,
      spacing: 4.0,
    ),
    count: 6,
    activeIndex: activeIndex,
  ),
);

void navigateTo(context, widget) => Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => widget,
  ),
);
void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
  context,
  MaterialPageRoute(
    builder: (context) => widget,
  ),
      (route) => false,
);
