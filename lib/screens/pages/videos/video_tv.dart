import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../models/video/video_tv.dart';

class VideoTvScreen extends StatefulWidget {
  const VideoTvScreen({super.key, required this.future});
  final Future<List<VideoTv>?> future;

  @override
  State<VideoTvScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoTvScreen> {
  YoutubePlayerController? controller;
  VideoTv? video;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FutureBuilder<List<VideoTv>?>(
            future: widget.future,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                for (var element in snapshot.data!) {
                  if (element.official == true) {
                    video = element;
                  }else if (element.type == 'Trailer') {
                    video = element;
                    break;
                  }
                }
                return SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: YoutubePlayerBuilder(
                    player: YoutubePlayer(
                      aspectRatio: 16 / 9,
                      controller: controller = YoutubePlayerController(
                        initialVideoId: video!.key,
                        flags: const YoutubePlayerFlags(
                          autoPlay: false,
                          mute: false,
                          isLive: false,
                          enableCaption: true,
                          forceHD: false,
                          hideThumbnail: false,
                        ),
                      ),
                      showVideoProgressIndicator: true,
                      progressIndicatorColor: Colors.green,
                      progressColors:  ProgressBarColors(
                        bufferedColor: Colors.green[200]!,
                        backgroundColor: Colors.white70,
                        playedColor: Colors.green,
                        handleColor: Colors.green,
                      ),
                      bottomActions: [
                        CurrentPosition(),
                        const SizedBox(width: 10.0),
                        ProgressBar(isExpanded: true),
                        const SizedBox(width: 10.0),
                        RemainingDuration(),
                        FullScreenButton(),
                      ],
                      topActions: [
                        const SizedBox(width: 8.0),
                        Expanded(
                          child: Text(
                            controller!.metadata.title,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                      ],
                    ),
                    builder: (context, player) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          player,
                        ],
                      );
                    },
                  ),
                );
              }else if (snapshot.hasError) {
                return const Center(
                  child: Text('Error'),
                );
              }
              else {
                return   Center(
                  child: Column(
                    children: [
                      const CircularProgressIndicator(),
                      const SizedBox(height: 50.0,),
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Go Back',
                            style: TextStyle(
                              color: Colors.grey,
                              fontStyle: FontStyle.italic,
                              fontSize: 18.0,

                            ),
                          )
                      ),
                    ],
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
