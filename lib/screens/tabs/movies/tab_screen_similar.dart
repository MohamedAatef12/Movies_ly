import 'package:cached_network_image/cached_network_image.dart';
import 'package:fade_shimmer/fade_shimmer.dart';
import 'package:flutter/material.dart';

import '../../../api/api.dart';
import '../../../models/movies/movie.dart';
import '../../../models/movies/similar.dart';
import '../../../widgets/widgets.dart';
import '../../pages/details/details_similar.dart';

class TabBuilderSimilar extends StatelessWidget {
  const TabBuilderSimilar({
    required this.future,
    Key? key ,
  }) : super(key: key);

  final Future<List<Similar>?> future;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 20.0,
      ),
      child: FutureBuilder<List<Similar>?>(
        future: future,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Recommended',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.25,
                  child: GridView.builder(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      childAspectRatio: 1.5,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) => GestureDetector(
                      onTap: () {
                          navigateTo(context, DetailsSimilarScreen(
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
                          ));
                        },
                      child:CachedNetworkImage(
                        imageUrl:'${Api.imageBaseUrl}${snapshot.data![index].posterPath}',
                        imageBuilder:(context,imageProvider) => ClipRRect(
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
                    ),
                  ),
                ),
              ],
            );
          } else {
            return buildTabShimmer(
              context,
              MediaQuery.of(context).size.width * 0.9,
              MediaQuery.of(context).size.height  * 0.17,
              Axis.horizontal,
            );
          }
        },
      ),
    );
  }
}
