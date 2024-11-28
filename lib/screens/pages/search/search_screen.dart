import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fade_shimmer/fade_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:movies_ly/screens/pages/search/search_by_genre_tv.dart';

import '../../../api/api.dart';
import '../../../api/api_service.dart';
import '../../../models/movies/movie.dart';
import '../../../models/search/search.dart';
import '../../../models/trending/trending.dart';
import '../../../models/tv/tv_model.dart';
import '../../../utils/utils.dart';
import '../../../utils/utils_tv.dart';
import '../../../widgets/widgets.dart';
import '../details/details_screen.dart';
import '../details/details_tv.dart';
import 'Search_by_genre.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final searchController = TextEditingController();
  String search = '';

  final RegExp arabicRegex = RegExp(r'[\u0600-\u06FF]+');
  final RegExp englishRegex = RegExp(r'[a-zA-Z]+');

  bool isArabic(String search) => arabicRegex.hasMatch(search);
  bool isEnglish(String search) => englishRegex.hasMatch(search);


  List<Color> colors = [
    Colors.blue.shade900.withOpacity(.9),
    Colors.blue.shade900,
    Colors.blue.shade800,
    Colors.blue.shade700,
    Colors.blue.shade600,
    Colors.blue.shade500,
    Colors.blue.shade400,
    Colors.blue.shade300,
  ];
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: const EdgeInsets.only(
            top: 40.0,
            left: 10,
            right: 10,
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(13),
                      color: Colors.blueGrey.withOpacity(.6),
                    ),
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        IconBroken.Arrow___Left_2,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 7,
                  ),
                  const Text(
                    'Search',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              TextFormField(
                controller: searchController,
                decoration:  InputDecoration(
                  hintText: 'Search for a movie or tv show...',
                  hintStyle: const TextStyle(fontSize: 14, color: Colors.grey),
                  enabledBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    borderSide: BorderSide(
                      color: Colors.white,
                    ),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    borderSide: BorderSide(
                      color: Colors.white,
                    ),
                  ),
                  border: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,
                    ),
                  ),
                  prefixIcon: const Icon(
                    IconBroken.Search,
                    color: Colors.green,
                    size: 23,
                  ),
                  suffixIcon: GestureDetector(
                    onTap: () {
                      searchController.clear();
                      setState(() {
                        search = '';
                      });
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Material(
                          type: MaterialType.transparency,
                          child: Ink(
                            padding: const EdgeInsets.all(4.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              border: Border.all(width: 2.0, color: Colors.grey),
                              color: Colors.black,
                            ),
                            child: const Icon(
                              Icons.clear,
                              size: 20.0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.03,
                        ),
                      ],
                    ),
                  ),
                ),
                style: const TextStyle(
                  color: Colors.white,
                ),
                onChanged: (value) {
                  setState(() {
                    search = value;
                  });
                },
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              if (search.isNotEmpty && isArabic(search))
                   Expanded(
                      child: FutureBuilder<List<Search>?>(
                        future: ApiService.getSearchedMovies(' $search', 'ar-SA',),
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
                                    {
                                      navigateTo(
                                          context,
                                          (snapshot.data![index].mediaType == 'movie')
                                          ? DetailsScreen(
                                              movie: Movie(
                                                id: snapshot.data![index].id,
                                                title: snapshot.data![index].title,
                                                posterPath: snapshot.data![index].posterPath,
                                                backdropPath: snapshot.data![index].backdropPath,
                                                overview: snapshot.data![index].overview,
                                                releaseDate: snapshot.data![index].releaseDate,
                                                voteAverage: snapshot.data![index].voteAverage,
                                                genreIds: snapshot.data![index].genreIds,
                                              ),
                                            )
                                          : DetailsTvScreen(
                                              tv: Tv(
                                                id: snapshot.data![index].id,
                                                name: snapshot.data![index].name,
                                                posterPath: snapshot.data![index].posterPath,
                                                backdropPath: snapshot.data![index].backdropPath,
                                                overview: snapshot.data![index].overview,
                                                firstAirDate: snapshot.data![index].firstAirDate,
                                                voteAverage: snapshot.data![index].voteAverage,
                                                genreIds: snapshot.data![index].genreIds,
                                              ),
                                            )
                                      );
                                    }
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0,
                                    ),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            children: [
                                              Text(
                                                snapshot.data![index].mediaType == 'movie'
                                                    ? snapshot.data![index].title
                                                    : snapshot.data![index].name,
                                                textDirection: TextDirection.rtl,
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
                                                snapshot.data![index].overview,
                                                maxLines: 2,
                                                textDirection: TextDirection.rtl,
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
                                                scrollDirection:
                                                    Axis.horizontal,
                                                physics:
                                                    const BouncingScrollPhysics(),
                                                child: Row(
                                                  children: [
                                                    if (snapshot.data![index].genreIds.isNotEmpty)
                                                      for (int i = 0; i < snapshot.data![index].genreIds.length; i++)
                                                        Row(
                                                          children: [
                                                            FittedBox(
                                                              fit: BoxFit
                                                                  .fitWidth,
                                                              child: Container(
                                                                height: 25,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: HexColor(
                                                                      '#3356FE'),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              13),
                                                                ),
                                                                child: Center(
                                                                  child: Text(
                                                                    snapshot.data![index].mediaType ==
                                                                            'movie'
                                                                        ? '   ${Utils.getGenreById(snapshot.data![index].genreIds[i])}   '
                                                                        : '   ${UtilsTv.getGenreById(snapshot.data![index].genreIds[i])}   ',
                                                                    style:
                                                                        const TextStyle(
                                                                      fontSize:
                                                                          15,
                                                                      color: Colors
                                                                          .white,
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
                                                height: 10,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  const Icon(
                                                    Icons.star,
                                                    color: Colors.yellow,
                                                    size: 18,
                                                  ),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text(
                                                    snapshot.data![index]
                                                        .voteAverage
                                                        .toStringAsPrecision(2),
                                                    textDirection: TextDirection.rtl,
                                                    style: const TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 18,
                                                    ),
                                                  ),


                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Container(
                                          width: MediaQuery.of(context).size.width * 0.35,
                                          height: MediaQuery.of(context).size.height * 0.25,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                            BorderRadius.circular(15),
                                            color: Colors.grey.shade900
                                                .withOpacity(.6),
                                          ),
                                          child: ClipRRect(
                                            borderRadius:
                                            BorderRadius.circular(15),
                                            child: Image.network(
                                              'https://image.tmdb.org/t/p/w500/${snapshot.data![index].posterPath}',
                                              errorBuilder: (_, __, ___) =>
                                              const Center(
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
                                                  highlightColor:
                                                  Color(0xff22272f),
                                                  baseColor: Color(0xff20252d),
                                                );
                                              },
                                            ),
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
                                separatorBuilder:
                                    (BuildContext context, int index) {
                                  return const SizedBox(
                                    height: 10,
                                  );
                                },
                                itemBuilder: (context, index) => ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: FadeShimmer(
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height *
                                        .15,
                                    highlightColor: const Color(0xff22272f),
                                    baseColor: const Color(0xff20252d),
                                  ),
                                ),
                              ),
                            );
                          }
                        },
                      ),
                    )
              else if (search.isNotEmpty && isEnglish(search))
                  Expanded(
                  child: FutureBuilder<List<Search>?>(
                    future: ApiService.getSearchedMovies(' $search', 'en-US',),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          separatorBuilder:
                              (BuildContext context, int index) {
                            return const SizedBox(
                              height: 10,
                            );
                          },
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                {
                                  navigateTo(
                                      context,
                                      (snapshot.data![index].mediaType == 'movie')
                                          ? DetailsScreen(
                                        movie: Movie(
                                          id: snapshot.data![index].id,
                                          title: snapshot.data![index].title,
                                          posterPath: snapshot.data![index].posterPath,
                                          backdropPath: snapshot.data![index].backdropPath,
                                          overview: snapshot.data![index].overview,
                                          releaseDate: snapshot.data![index].releaseDate,
                                          voteAverage: snapshot.data![index].voteAverage,
                                          genreIds: snapshot.data![index].genreIds,
                                        ),
                                      )
                                          : DetailsTvScreen(
                                        tv: Tv(
                                          id: snapshot.data![index].id,
                                          name: snapshot.data![index].name,
                                          posterPath: snapshot.data![index].posterPath,
                                          backdropPath: snapshot.data![index].backdropPath,
                                          overview: snapshot.data![index].overview,
                                          firstAirDate: snapshot.data![index].firstAirDate,
                                          voteAverage: snapshot.data![index].voteAverage,
                                          genreIds: snapshot.data![index].genreIds,
                                        ),
                                      )
                                  );
                                }
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
                                        borderRadius:
                                        BorderRadius.circular(15),
                                        color: Colors.grey.shade900
                                            .withOpacity(.6),
                                      ),
                                      child: ClipRRect(
                                        borderRadius:
                                        BorderRadius.circular(15),
                                        child: Image.network(
                                          'https://image.tmdb.org/t/p/w500/${snapshot.data![index].posterPath}',
                                          errorBuilder: (_, __, ___) =>
                                          const Center(
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
                                              highlightColor:
                                              Color(0xff22272f),
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
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            snapshot.data![index].mediaType == 'movie'
                                                ? snapshot.data![index].title
                                                : snapshot.data![index].name,
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
                                            snapshot.data![index].overview,
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
                                            scrollDirection:
                                            Axis.horizontal,
                                            physics:
                                            const BouncingScrollPhysics(),
                                            child: Row(
                                              children: [
                                                if (snapshot.data![index]
                                                    .genreIds.isNotEmpty)
                                                  for (int i = 0;
                                                  i <
                                                      snapshot
                                                          .data![index]
                                                          .genreIds
                                                          .length;
                                                  i++)
                                                    Row(
                                                      children: [
                                                        FittedBox(
                                                          fit: BoxFit
                                                              .fitWidth,
                                                          child: Container(
                                                            height: 25,
                                                            decoration:
                                                            BoxDecoration(
                                                              color: HexColor(
                                                                  '#3356FE'),
                                                              borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                  13),
                                                            ),
                                                            child: Center(
                                                              child: Text(
                                                                snapshot.data![index].mediaType ==
                                                                    'movie'
                                                                    ? '   ${Utils.getGenreById(snapshot.data![index].genreIds[i])}   '
                                                                    : '   ${UtilsTv.getGenreById(snapshot.data![index].genreIds[i])}   ',
                                                                style:
                                                                const TextStyle(
                                                                  fontSize:
                                                                  15,
                                                                  color: Colors
                                                                      .white,
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
                                            height: 10,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                snapshot.data![index]
                                                    .voteAverage
                                                    .toStringAsPrecision(2),
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
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return const SizedBox(
                                height: 10,
                              );
                            },
                            itemBuilder: (context, index) => ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: FadeShimmer(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height *
                                    .15,
                                highlightColor: const Color(0xff22272f),
                                baseColor: const Color(0xff20252d),
                              ),
                            ),
                          ),
                        );
                      }
                    },
                  ),
                )
              else SizedBox(
                      height: MediaQuery.of(context).size.height * 0.79,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01,
                          ),
                          const Text(
                            'Movie',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.05,
                            child: GridView.builder(
                              physics: const BouncingScrollPhysics(),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 1,
                                childAspectRatio: 1 / 3,
                                mainAxisSpacing: 7,

                              ),
                              scrollDirection: Axis.horizontal,
                              itemCount: Utils.getGenre().length,
                              itemBuilder: (context, index) => GestureDetector(
                                onTap: () {
                                  navigateTo(
                                    context,
                                    SearchByGenre(
                                      genre: Utils.getGenre()[index],
                                      firstGenreId:
                                          Utils.genreMap1.keys.toList()[index],
                                    ),
                                  );
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(13),
                                    color: colors[index],
                                  ),
                                  child: Center(
                                    child: Text(
                                      Utils.getGenre()[index],
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.03,
                          ),
                          const Text(
                            'Tv Shows',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.05,
                            child: GridView.builder(
                              physics: const BouncingScrollPhysics(),
                              gridDelegate:
                                   const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 1,
                                childAspectRatio: 1 / 4.8,
                                crossAxisSpacing: 7,
                                mainAxisSpacing: 7,
                              ),
                              scrollDirection: Axis.horizontal,
                              itemCount: 8,
                              itemBuilder: (context, index) => GestureDetector(
                                onTap: () {
                                  navigateTo(
                                    context,
                                    SearchByTvGenre(
                                      genre: UtilsTv.getTvGenre()[index],
                                      firstGenreTvId: UtilsTv.genreTvMap1.keys.toList()[index],
                                    ),
                                  );
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(13),
                                    color: colors[index],
                                  ),
                                  child: Center(
                                    child: Text(
                                      UtilsTv.getTvGenre()[index],
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),
                          buildTrendingWidget(context,'Trending Movies'),
                          FutureBuilder<List<Trending>?>(
                            future: ApiService.getTrending('movie'),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return SizedBox(
                                  height: MediaQuery.of(context).size.height * 0.2,
                                  child: GridView.builder(
                                    physics: const BouncingScrollPhysics(),
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 1,
                                      childAspectRatio: 0.7,
                                      mainAxisSpacing: 10,
                                    ),
                                    scrollDirection: Axis.horizontal,
                                    itemCount: 8,
                                    itemBuilder: (context, index) =>
                                        GestureDetector(
                                          onTap: () {
                                           navigateTo(
                                            context,
                                               DetailsScreen(
                                                  movie: Movie(
                                                    id: snapshot.data![index].id,
                                                    title: snapshot.data![index].title,
                                                    posterPath: snapshot.data![index].posterPath,
                                                    backdropPath: snapshot.data![index].backdropPath,
                                                    overview: snapshot.data![index].overview,
                                                    releaseDate: snapshot.data![index].releaseDate,
                                                    voteAverage: snapshot.data![index].voteAverage,
                                                    genreIds: snapshot.data![index].genreIds,
                                                  ),
                                                ),
                                        );
                                      },
                                      child: Stack(
                                        alignment: Alignment.bottomLeft,
                                        children: [
                                          CachedNetworkImage(
                                            imageUrl:
                                                '${Api.imageBaseUrl}${snapshot.data![index].posterPath}',
                                            imageBuilder:
                                                (context, imageProvider) => ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                child: Image(
                                                  image: imageProvider,
                                                  fit: BoxFit.cover,
                                                  width: double.infinity,
                                                  height: double.infinity,
                                                ),
                                              ),
                                            errorWidget: (_, __, ___) =>
                                                const Center(
                                              child: Icon(
                                                Icons.broken_image,
                                                size: 40,
                                              ),
                                            ),
                                            placeholder: (_, __) => ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              child: FadeShimmer(
                                                width: MediaQuery.of(context).size.width,
                                                height: MediaQuery.of(context).size.height * .7,
                                                highlightColor: const Color(0xff22272f),
                                                baseColor: const Color(0xff20252d),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: MediaQuery.of(context).size.height *0.09,
                                            width: double.infinity,
                                            child: ClipRRect(
                                              borderRadius:
                                                  const BorderRadius.only(
                                                bottomLeft: Radius.circular(10),
                                                bottomRight:
                                                    Radius.circular(10),
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
                                            contentPadding:
                                             const EdgeInsets.only(
                                              left: 8,
                                              bottom: 12,
                                              right: 8,
                                            ),
                                            title: Text(
                                              snapshot.data![index].mediaType == 'movie'
                                                  ? snapshot.data![index].title
                                                  : snapshot.data![index].name,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            trailing: Text(
                                              '${snapshot.data![index].voteAverage.toStringAsPrecision(2)} ⭐',
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
                                  MediaQuery.of(context).size.width * .6,
                                  MediaQuery.of(context).size.height * .2,
                                  Axis.horizontal,
                                );
                              }
                            },
                          ),
                          buildTrendingWidget(context,'Trending Tv Shows'),
                          FutureBuilder<List<Trending>?>(
                            future: ApiService.getTrending('tv'),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return SizedBox(
                                  height: MediaQuery.of(context).size.height * 0.2,
                                  child: GridView.builder(
                                    physics: const BouncingScrollPhysics(),
                                    gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 1,
                                      childAspectRatio: 0.7,
                                      mainAxisSpacing: 10,
                                    ),
                                    scrollDirection: Axis.horizontal,
                                    itemCount: 8,
                                    itemBuilder: (context, index) =>
                                        GestureDetector(
                                          onTap: () {
                                            navigateTo(
                                              context,
                                             DetailsTvScreen(
                                                tv: Tv(
                                                  id: snapshot.data![index].id,
                                                  name: snapshot.data![index].name,
                                                  posterPath: snapshot.data![index].posterPath,
                                                  backdropPath: snapshot.data![index].backdropPath,
                                                  overview: snapshot.data![index].overview,
                                                  firstAirDate: snapshot.data![index].firstAirDate,
                                                  voteAverage: snapshot.data![index].voteAverage,
                                                  genreIds: snapshot.data![index].genreIds,
                                                ),
                                              ),
                                            );
                                          },
                                          child: Stack(
                                            alignment: Alignment.bottomLeft,
                                            children: [
                                              CachedNetworkImage(
                                                imageUrl:
                                                '${Api.imageBaseUrl}${snapshot.data![index].posterPath}',
                                                imageBuilder:
                                                    (context, imageProvider) => ClipRRect(
                                                  borderRadius:
                                                  BorderRadius.circular(15),
                                                  child: Image(
                                                    image: imageProvider,
                                                    fit: BoxFit.cover,
                                                    width: double.infinity,
                                                    height: double.infinity,
                                                  ),
                                                ),
                                                errorWidget: (_, __, ___) =>
                                                const Center(
                                                  child: Icon(
                                                    Icons.broken_image,
                                                    size: 40,
                                                  ),
                                                ),
                                                placeholder: (_, __) => ClipRRect(
                                                  borderRadius:
                                                  BorderRadius.circular(15),
                                                  child: FadeShimmer(
                                                    width: MediaQuery.of(context).size.width,
                                                    height: MediaQuery.of(context).size.height * .7,
                                                    highlightColor: const Color(0xff22272f),
                                                    baseColor: const Color(0xff20252d),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: MediaQuery.of(context).size.height *0.09,
                                                width: double.infinity,
                                                child: ClipRRect(
                                                  borderRadius:
                                                  const BorderRadius.only(
                                                    bottomLeft: Radius.circular(10),
                                                    bottomRight:
                                                    Radius.circular(10),
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
                                                contentPadding:
                                                const EdgeInsets.only(
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
                                                  '${snapshot.data![index].voteAverage.toStringAsPrecision(2)} ⭐',
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
                                  MediaQuery.of(context).size.width * .6,
                                  MediaQuery.of(context).size.height * .2,
                                  Axis.horizontal,
                                );
                              }
                            },
                          ),
                        ],
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
