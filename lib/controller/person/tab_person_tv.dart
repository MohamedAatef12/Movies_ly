import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:icon_broken/icon_broken.dart';
import '../../api/api_service.dart';
import '../../screens/pages/details/person_tv_detail.dart';
import '../../screens/tabs/person/person_movie_tab.dart';
import '../../screens/tabs/person/person_tv_tab.dart';



class ViewPersonTvDetails extends StatefulWidget {
  const ViewPersonTvDetails({
    super.key,
    required this.title,
    required this.id,
  });
  final String title;
  final int id;

  @override
  State<ViewPersonTvDetails> createState() => _ViewPersonDetailsState();
}

class _ViewPersonDetailsState extends State<ViewPersonTvDetails> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
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
                      widget.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              PersonTvDetails(
                future: ApiService.getPersons(widget.id),
              ),
              DefaultTabController(
                length: 2,
                child: Column(
                  children: [
                    TabBar(
                        labelColor: Colors.white,
                        labelStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        unselectedLabelColor: Colors.white60,
                        indicator: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: HexColor('#3356FE').withOpacity(0.6),
                        ),
                        indicatorPadding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 5,
                        ),
                        overlayColor: MaterialStateProperty.all(
                          Colors.transparent,
                        ),
                        tabs: const [
                          Tab(
                            child: Text(
                              'Movies',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Tab(
                            child: Text(
                              'TV Shows',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ]
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.56,
                      child:  TabBarView(
                          physics: const BouncingScrollPhysics(),
                          children: [
                            PersonMoviesTab(future: ApiService.getPersonsMovie(widget.id),),
                            PersonTvTab(future: ApiService.getPersonsTv(widget.id),),
                          ]
                      ),
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
