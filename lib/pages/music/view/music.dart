import 'package:flutter/material.dart';
import 'package:media_booster/pages/music/provider/provider.dart';
import 'package:media_booster/utils/model.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

class MusicPage extends StatefulWidget {
  const MusicPage({super.key});

  @override
  State<MusicPage> createState() => _MusicPageState();
}

class _MusicPageState extends State<MusicPage> {
  int index = 0;
  late MusicProvider musicProviderW;
  late MusicProvider musicProviderR;

  @override
  void initState() {
    context.read<MusicProvider>().intMusic();
    context.read<MusicProvider>().playMusic();
    super.initState();
  }

  @override
  void dispose() {
    context.read<MusicProvider>().songEnd();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    musicProviderW = context.watch<MusicProvider>();
    musicProviderR = context.read<MusicProvider>();
    MusicModel musicModel =
        ModalRoute.of(context)!.settings.arguments as MusicModel;
    musicModel = musicList[musicProviderW.selectIndex];
    musicModel = musicList[musicProviderW.currentIndex];
    musicProviderR.getTotalTime();
    return Scaffold(
      // backgroundColor: Colors.teal.shade300,
      body: Stack(
        // alignment: Alignment.center,
        children: [
          // Text(
          //   "${musicModel.title}",
          //   style: const TextStyle(fontSize: 25),
          // ),
          Image(
            image: NetworkImage(
              musicModel.b_image!,
            ),
            height: double.infinity,
            fit: BoxFit.cover,
          ),
          Container(
            height: double.infinity,
            color: Colors.black.withOpacity(0.6),
          ),
          Container(
            height: double.infinity,
            color: Colors.black.withOpacity(0.2),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Align(
                alignment: const Alignment(-1, -0.8),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(
                    onPressed: () {
                      musicProviderR.songEnd();
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 80),
                    child: Text(
                      "${musicModel.title}",
                      style: const TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text(
                    "${musicModel.singer}",
                    style: const TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Align(
                alignment: const Alignment(1, -0.8),
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.more_vert,
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Align(
              alignment: const Alignment(0, -0.3),
              child: Container(
                height: 300,
                width: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                    image: NetworkImage(musicModel.f_image!),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Spacer(),
                Row(
                  children: [
                    Text(
                      "${musicModel.title}",
                      style: const TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {
                        Share.share("${musicModel.title}\n${musicModel.path}");
                      },
                      icon: const Icon(
                        Icons.share_rounded,
                        color: Colors.white,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        musicProviderW.favMusicList.contains(musicModel)
                            ? musicProviderW.favMusicList.remove(musicModel)
                            : musicProviderW.favMusicList.add(musicModel);
                        setState(() {});
                      },
                      icon: (musicProviderW.favMusicList.contains(musicModel))
                          ? const Icon(
                              Icons.favorite,
                              color: Colors.white,
                            )
                          : const Icon(
                              Icons.favorite_border,
                            ),
                    ),
                  ],
                ),
                Text(
                  "${musicModel.singer}",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
                Slider(
                  value: musicProviderW.liveDuration.inSeconds.toDouble(),
                  max: musicProviderW.totalDuration.inSeconds.toDouble(),
                  onChanged: (value) {
                    musicProviderR.seekMusic(
                      Duration(
                        seconds: value.toInt(),
                      ),
                    );
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${musicProviderW.liveDuration.inMinutes.toString().padLeft(2, '0')} : ${musicProviderW.liveDuration.inSeconds.toString().padLeft(2, '0')}",
                      style: const TextStyle(color: Colors.white),
                    ),
                    Text(
                      "${musicProviderW.totalDuration.inMinutes.toString().padLeft(2, '0')}:${musicProviderW.totalDuration.inSeconds.toString().padLeft(2, '0')}",
                      style: const TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.timer, color: Colors.white),
                    ),
                    IconButton(
                      onPressed: () {
                        context.read<MusicProvider>().previousSong();
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        context.read<MusicProvider>().playMusic();
                      },
                      icon: Icon(
                        context.watch<MusicProvider>().isPlaying
                            ? Icons.pause_circle_filled
                            : Icons.play_circle_fill,
                        color: Colors.white,
                        size: 60,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        context.read<MusicProvider>().nextSong();
                      },
                      icon: const Icon(
                        Icons.arrow_forward_ios_outlined,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.restart_alt_rounded,
                          color: Colors.white),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
