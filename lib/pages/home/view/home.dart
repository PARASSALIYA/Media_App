import 'package:flutter/material.dart';
import 'package:media_booster/pages/home/provider/home_provider.dart';
import 'package:media_booster/pages/music/provider/provider.dart';
import 'package:media_booster/pages/video/video.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  late MusicProvider musicProviderW;
  late MusicProvider musicProviderR;

  @override
  Widget build(BuildContext context) {
    musicProviderW = context.watch<MusicProvider>();
    musicProviderR = context.read<MusicProvider>();
    return Scaffold(
      drawer: const Drawer(),
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        centerTitle: true,
        title:
            const Text('Home', style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          PopupMenuButton(
            padding: const EdgeInsets.all(10),
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  child: const Text("Favorite Songs"),
                  onTap: () {
                    Navigator.pushNamed(context, 'favorite');
                  },
                ),
              ];
            },
          ),
        ],
        bottom: TabBar(
          labelColor: Colors.white,
          unselectedLabelColor: Colors.grey,
          controller: tabController,
          tabs: const [
            Tab(
                icon: Icon(
                  Icons.music_note,
                  color: Colors.white,
                ),
                text: 'Music'),
            Tab(
                icon: Icon(
                  Icons.video_camera_back_outlined,
                  color: Colors.white,
                ),
                text: 'Video'),
          ],
        ),
      ),
      backgroundColor: Colors.black,
      body: TabBarView(
        controller: tabController,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    height: 50,
                    width: 9.5 * MediaQuery.of(context).size.width / 10,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.black,
                      image: const DecorationImage(
                        image: NetworkImage(
                          "https://images.squarespace-cdn.com/content/5dd66c86ed3b8a71f24664cc/1574796188399-NGXHU1OKP71GCNVGX0WJ/Bryan-Benner-social-media-sharing.jpg?content-type=image%2Fjpeg",
                        ),
                      ),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 15, top: 10, bottom: 10),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Popular Songs",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: GridView.builder(
                    itemCount: musicList.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    itemBuilder: (context, index) => GestureDetector(
                      onTap: () {
                        musicProviderR.indexMusic(index);
                        Navigator.pushNamed(context, 'detail',
                            arguments: musicList[index]);
                      },
                      child: Column(
                        children: [
                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                image: DecorationImage(
                                  image:
                                      NetworkImage(musicList[index].b_image!),
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
                                "${musicList[index].title}",
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
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(10.0),
            child: VideoPage(),
          ),
        ],
      ),
    );
  }
}
