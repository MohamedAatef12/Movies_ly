import 'package:cached_network_image/cached_network_image.dart';
import 'package:fade_shimmer/fade_shimmer.dart';
import 'package:flutter/material.dart';

import '../../../api/api.dart';
import '../../../models/person/person.dart';
import '../../../widgets/widgets.dart';

class PersonDetails extends StatefulWidget {
  const PersonDetails({super.key, required this.future,});

  final Future<List<Person>?> future;

  @override
  State<PersonDetails> createState() => _PersonTabState();
}

class _PersonTabState extends State<PersonDetails> {


  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Person>?>(
        future:widget.future ,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CachedNetworkImage(
                        imageUrl:'${Api.imageBaseUrl}${snapshot.data![0].profilePath}',
                        imageBuilder: (context, imageProvider) => ClipRRect(
                          borderRadius:  BorderRadius.circular(
                            15,
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
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height,
                            highlightColor: const Color(0xff22272f),
                            baseColor: const Color(0xff20252d),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.04,
                      ),
                      snapshot.data![0].biography.isEmpty
                          ? const SizedBox()
                          :SizedBox(
                          width: MediaQuery.of(context).size.width * 0.58,
                          child: SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  snapshot.data![0].biography,
                                  style: const TextStyle(
                                    color: Colors.white70,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  snapshot.data![0].placeOfBirth,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
              ],
            );
          }
          else{
            return buildTabShimmer(
              context,
              MediaQuery.of(context).size.width * 0.44,
              MediaQuery.of(context).size.height  * 0.2,
              Axis.horizontal,
            );
          }
        });
  }
}
