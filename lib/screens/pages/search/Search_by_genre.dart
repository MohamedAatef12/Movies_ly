import 'package:fade_shimmer/fade_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:icon_broken/icon_broken.dart';


import '../../../api/api_service.dart';
import '../../../models/movies/movie.dart';
import '../../../widgets/widgets.dart';
import '../details/details_screen.dart';

class SearchByGenre extends StatefulWidget {
  const SearchByGenre({super.key, required this.genre, required this.firstGenreId,});
  final int firstGenreId;
  final String genre;
  @override
  State<SearchByGenre> createState() => _SearchByGenreState();
}

class _SearchByGenreState extends State<SearchByGenre> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 40,
        ),
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  padding: const EdgeInsets.all(0),
                  icon: Container(
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
                      icon:const Icon(
                        IconBroken.Arrow___Left_2,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  widget.genre,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                  ),
                ),
              ],
            ),
            SizedBox(
                height: MediaQuery.of(context).size.height * 0.852,
                child: FutureBuilder<List<Movie>?>(
                  future: ApiService.getMovieWithGenre(
                    widget.firstGenreId,
                  ),
                  builder:(context,snapshot) {
                  if(snapshot.hasData) {
                    return GridView.builder(
                       gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 1/1.8,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                  ),
                  physics: const BouncingScrollPhysics(),
                  itemCount: snapshot.data!.length ,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        navigateTo(context,
                            DetailsScreen(
                                movie: snapshot.data![index],
                            ),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          image: DecorationImage(
                            image: NetworkImage(
                              'https://image.tmdb.org/t/p/w500${snapshot.data![index].posterPath}',
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    );
                  },
                );
                  } else if(snapshot.hasError) {
                    return const Center(child: Text('Error While Loading Data...'),);
                  }
                    else {
                    return GridView.builder(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      itemCount: 15,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 1/1.8,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                      ),
                      itemBuilder:(context,index) => ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: FadeShimmer(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          highlightColor: const Color(0xff22272f),
                          baseColor: const Color(0xff20252d),
                        ),
                      ),
                    );
                  }
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
