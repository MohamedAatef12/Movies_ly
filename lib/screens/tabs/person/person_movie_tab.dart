import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fade_shimmer/fade_shimmer.dart';
import 'package:flutter/material.dart';

import '../../../api/api.dart';
import '../../../models/movies/movie.dart';
import '../../../models/person/person_movie.dart';
import '../../../widgets/widgets.dart';
import '../../pages/details/details_screen.dart';


class PersonMoviesTab extends StatefulWidget {
  const PersonMoviesTab({super.key, required this.future});
  final Future<List<PersonMovie>?> future;

  @override
  State<PersonMoviesTab> createState() => _PersonMoviesTabState();
}

class _PersonMoviesTabState extends State<PersonMoviesTab> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 10.0,
      ),
      child: Scaffold(
        body: FutureBuilder<List<PersonMovie>?>(
          future: widget.future,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return SizedBox(
                height: MediaQuery.of(context).size.height,
                child: GridView.builder(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.7,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                  ),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) => GestureDetector(
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
                          imageUrl: '${Api.imageBaseUrl}${snapshot.data![index].posterPath}',
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
                                  'https://image.tmdb.org/t/p/w500/${snapshot.data![index].posterPath}',
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
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15.0,
                ),
                child: GridView.builder(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemCount: 15,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.7,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                  ),
                  itemBuilder:(context,index) => ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: FadeShimmer(
                      width: MediaQuery.of(context).size.width * .2,
                      height: MediaQuery.of(context).size.height,
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
    );
  }
}
