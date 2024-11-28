import 'package:flutter/material.dart';
import 'package:media_booster/pages/music/provider/provider.dart';
import 'package:provider/provider.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  late MusicProvider musicProviderW;
  late MusicProvider musicProviderR;
  @override
  Widget build(BuildContext context) {
    musicProviderW = context.watch<MusicProvider>();
    musicProviderR = context.read<MusicProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite'),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemCount: musicProviderW.favMusicList.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                context,
                'detail',
                arguments: musicProviderW.favMusicList[index],
              );
            },
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      image: DecorationImage(
                        image: NetworkImage(
                            musicProviderW.favMusicList[index].b_image),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "${musicProviderW.favMusicList[index].title}",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
