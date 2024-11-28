import 'package:cached_network_image/cached_network_image.dart';
import 'package:fade_shimmer/fade_shimmer.dart';
import 'package:flutter/material.dart';

import '../../../api/api.dart';
import '../../../controller/person/tab_person.dart';
import '../../../models/movies/casts.dart';
import '../../../widgets/widgets.dart';

class TabCast extends StatelessWidget {
  const TabCast({Key? key,required this.future,})
      : super(key: key);

  final Future<List<Cast>?> future;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 20.0,
      ),
      child: FutureBuilder<List<Cast>?>(
          future: future,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return SizedBox(
                height: MediaQuery.of(context).size.height * 0.13,
                child: ListView.separated(
                  separatorBuilder: (context, index) => const SizedBox(
                    width: 10,
                  ),
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: () {
                      navigateTo(
                          context,
                          ViewPersonDetails(
                            title: snapshot.data![index].name,
                            id: snapshot.data![index].id,
                        ),
                      );
                    },
                    child:Container(
                          decoration: BoxDecoration(
                            color: const Color(0xff20252d),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            children: [
                              CachedNetworkImage(
                                imageUrl: '${Api.imageBaseUrl}${snapshot.data![index].profilePath}',
                                imageBuilder: (context, imageProvider) => ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    bottomLeft: Radius.circular(20),
                                  ),
                                  child: Image(
                                    image: imageProvider,
                                  ),
                                ),
                                errorWidget: (_, __, ___) => const Center(
                                  child: Image(
                                    image: AssetImage('assets/images/user.jpg'),
                                    width: 90,
                                    height: 90,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                placeholder: (_, __) => ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: FadeShimmer(
                                    width: MediaQuery.of(context).size.width * 0.177,
                                    height: MediaQuery.of(context).size.height,
                                    highlightColor: const Color(0xff22272f),
                                    baseColor: const Color(0xff20252d),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.04,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    snapshot.data![index].name,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    snapshot.data![index].job == 'Director'
                                      || snapshot.data![index].job == 'Director'
                                      || snapshot.data![index].job == 'Screenplay'
                                      || snapshot.data![index].job == 'Writer'
                                      || snapshot.data![index].job == 'Producer'
                                      || snapshot.data![index].job == 'Author'
                                    ? snapshot.data![index].job
                                    : snapshot.data![index].character,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.04,
                              ),
                            ],
                          ),
                        ),
                  ),
                ),
              );
            }
            else{
              return buildTabShimmer(
                context,
                MediaQuery.of(context).size.width * 0.65,
                MediaQuery.of(context).size.height  * 0.13,
                Axis.horizontal,
              );
            }
          }),
    );
  }
}
