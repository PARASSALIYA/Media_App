import 'package:flutter/material.dart';
import 'package:media_booster/pages/favorite/favorite.dart';
import 'package:media_booster/pages/home/view/home.dart';
import 'package:media_booster/pages/music/provider/provider.dart';
import 'package:media_booster/pages/music/view/music.dart';
import 'package:media_booster/pages/splash/splash.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    const MediaPlayer(),
  );
}

class MediaPlayer extends StatefulWidget {
  const MediaPlayer({super.key});

  @override
  State<MediaPlayer> createState() => _MediaPlayerState();
}

class _MediaPlayerState extends State<MediaPlayer> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: MusicProvider(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData.dark(),
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => const SplashPage(),
          'home': (context) => const HomePage(),
          'detail': (context) => const MusicPage(),
          'favorite': (context) => const FavoritePage(),
        },
      ),
    );
  }
}
