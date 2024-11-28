import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:movies_ly/controller/tv/series_tab.dart';

import '../widgets/widgets.dart';
import 'movies/movies_tab.dart';
import 'tv/anime_tab.dart';

class TabController1 extends StatefulWidget {
  const TabController1({super.key});

  @override
  State<TabController1> createState() => _TabController1State();
}

class _TabController1State extends State<TabController1> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            buildTopWidget(context: context),
            DefaultTabController(
              length: 3,
              child: Stack(
                children: [
                  const SizedBox(
                    child:
                        TabBarView(physics: BouncingScrollPhysics(), children: [
                      TabBuilderMovie(),
                      TabBuilderSeries(),
                      TabBuilderAnime(),
                    ]),
                  ),
                  buildTopWidget(context: context),
                  Positioned(
                    top: 85,
                    left: 15,
                    right: 15,
                    child: Stack(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.04,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(
                                sigmaX: 10,
                                sigmaY: 10,
                              ),
                              child: Container(
                                color: Image.network(
                                  'https://hds.filmsenzalimiti.me/wp-content/uploads/2023/08/i6ye8ueFhVE5pXatgyRrZ83LBD8-185x278.jpg',
                                ).color,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.04,
                          child: TabBar(
                            labelColor: Colors.white,
                            labelStyle: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            unselectedLabelColor: Colors.white60,
                            indicator: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: HexColor('#3356FE').withOpacity(0.7),
                            ),
                            indicatorWeight: 0,
                            tabs: const [
                              Tab(text: 'Movies'),
                              Tab(text: 'Tv Shows'),
                              Tab(text: 'Anime'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
