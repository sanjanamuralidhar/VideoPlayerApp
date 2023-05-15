import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';

import '../list/videolist.dart';
import '../widget/drawer.dart';
import '../widget/video_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerButton(),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 250,
              child: Stack(
                    children: [
                      VideoItems(
                        videoPlayerController: VideoPlayerController.network(
                          videoList[0].dataSource
                        ),
                        looping: true,
                        autoplay: true,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 40.0, left: 20),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: IconButton(
                            icon: Icon(
                              Icons.menu_open_rounded,
                              size: 35.0,
                            ),
                            color: Colors.white,
                            onPressed: () {
                              Scaffold.of(context).openDrawer();
                            },
                          ),
                        ),
                      ),
                    ],
                  )
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.teal,width: 2)
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.volume_up),
                    tooltip: 'Increase volume by 10',
                    onPressed: () {
                      setState(() {});
                    },
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.volume_up),
                  tooltip: 'Increase volume by 10',
                  onPressed: () {
                    setState(() {});
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.volume_up),
                  tooltip: 'Increase volume by 10',
                  onPressed: () {
                    setState(() {});
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
