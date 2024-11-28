import 'package:flutter/material.dart';

import '../../../models/tv/review_tv.dart';
import '../../../widgets/widgets.dart';


class TabReviewTv extends StatelessWidget {
  const TabReviewTv({super.key, required this.future});

  final Future<List<ReviewTv>?> future;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ReviewTv>?>(
      future: future,
      builder: (context, snapshot){
        if (snapshot.hasData) {
          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
            ),
            child: Column(
              children: [
                buildTopRow(snapshot,),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.35,
                  child: ListView.separated(
                    separatorBuilder: (context, index) => const Divider(
                      height: 50,
                      color: Colors.white,
                    ),
                    scrollDirection: Axis.vertical,
                    physics: const BouncingScrollPhysics(),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          snapshot.data![index].author,
                          style:const TextStyle(
                            color: Colors.green,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          snapshot.data![index].content,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }
        return buildTabShimmer(
          context,
          MediaQuery.of(context).size.width * 0.5,
          MediaQuery.of(context).size.height  * 0.17,
          Axis.vertical,
        );
      },
    );
  }
  Widget buildTopRow(snapshot) =>Row(
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
}
