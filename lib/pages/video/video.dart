import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:media_booster/pages/music/provider/provider.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

class VideoPage extends StatefulWidget {
  const VideoPage({super.key});

  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  late VideoPlayerController videoController;
  late ChewieController? chewieController;
  @override
  void initState() {
    // context.read<MusicProvider>().videoControllerInit();
    // videoController = VideoPlayerController.networkUrl(
    //   (Uri.parse(
    //       'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4')),
    // )..initialize().then((_) {
    //     setState(() {});
    //   });
    videoController = VideoPlayerController.asset('assets/song/11.mp4')
      ..initialize().then((_) {
        setState(() {});
      });
    chewieController = ChewieController(
      videoPlayerController: videoController,
      autoPlay: true,
      looping: true,
    );
    super.initState();
  }

  void playVideo() {
    videoController.play();
  }

  late MusicProvider musicProviderW;
  late MusicProvider musicProviderR;
  @override
  Widget build(BuildContext context) {
    musicProviderW = context.watch<MusicProvider>();
    musicProviderR = context.read<MusicProvider>();
    return Scaffold(
      backgroundColor: Colors.black,
      // body: musicProviderW.videoController.value.isInitialized
      body: videoController.value.isInitialized
          ? Center(
              child: Column(
                children: [
                  AspectRatio(
                    aspectRatio:
                        // musicProviderW.videoController.value.aspectRatio,
                        videoController.value.aspectRatio,
                    // child: VideoPlayer(musicProviderW.videoController),
                    child: Chewie(
                      controller: chewieController!,
                    ),
                  ),
                  // IconButton(
                  //   onPressed: () {
                  //     // musicProviderR.playVideo();
                  //     playVideo();
                  //   },
                  //   icon: const Icon(Icons.play_arrow),
                  // ),
                ],
              ),
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }

  @override
  void dispose() {
    musicProviderW.videoController.dispose();
    super.dispose();
  }
}
