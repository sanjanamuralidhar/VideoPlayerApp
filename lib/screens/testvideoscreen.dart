import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../list/videolist.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';

import '../widget/drawer.dart';

class VideoApp extends StatefulWidget {
  @override
  _VideoAppState createState() => _VideoAppState();
}

class _VideoAppState extends State<VideoApp> {
  late VideoPlayerController _videoController;

  @override
  void initState() {
    _initializePlay();
    super.initState();
  }

  void _nextVideoPlay(String videoPath) {
    ///
    log(videoPath);
    _startPlay(videoPath);
  }

  Future<void> _startPlay(String videoPath) async {
    await _clearPrevious().then((_) {
      _initializePlay(videoPath: videoPath);
    });
  }

  Future<bool> _clearPrevious() async {
    await _videoController.pause();
    _videoController.notifyListeners();
    _videoController.dispose();
    return true;
  }

  Future<void> _initializePlay({String? videoPath}) async {
    _videoController =
        VideoPlayerController.network(videoPath ?? Video2List.videoList.first)
          ..initialize().then((_) {
            _videoController.play();
            setState(() {});
          });
  }

  int videoIndex = 0;
  double? _progress;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Video Demo',
      home: Scaffold(
        drawer: const DrawerButton(),
        body: SafeArea(
          child: Builder(
            builder: (context) {
              return Column(
              children: [
                _videoController.value.isInitialized?Stack(
                  children: [
                    
                        AspectRatio(
                            aspectRatio: _videoController.value.aspectRatio,
                            child: VideoPlayer(_videoController),
                          ),
                       
                    Padding(
                      padding: EdgeInsets.only(top: 0.0, left: 10),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: IconButton(
                          icon: Icon(
                            Icons.menu_open_rounded,
                            size: 35.0,
                            color: Colors.deepOrangeAccent,
                          ),
                          color: Colors.white,
                          onPressed: () {
                            Scaffold.of(context).openDrawer();
                          },
                        ),
                      ),
                    ),
                  ],
                ) : Center(
                            child: const CupertinoActivityIndicator(
                                radius: 20.0, color: CupertinoColors.activeBlue),
                          ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          border: Border.all(color: Colors.teal, width: 2)),
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back_ios_rounded),
                        tooltip: 'Increase volume by 10',
                        onPressed: () {
                          videoIndex -= 1;
                          _nextVideoPlay(Video2List.videoList[
                              videoIndex % Video2List.videoList.length]);
                        },
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          border: Border.all(color: Colors.teal, width: 2)),
                      child: IconButton(
                        icon: Icon(
                          _videoController.value.isPlaying
                              ? Icons.pause
                              : Icons.play_arrow,
                        ),
                        tooltip: 'Increase volume by 10',
                        onPressed: () {
                          setState(() {
                            _videoController.value.isPlaying
                                ? _videoController.pause()
                                : _videoController.play();
                          });
                        },
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          border: Border.all(color: Colors.teal, width: 2)),
                      child: IconButton(
                        icon: const Icon(Icons.arrow_forward_ios_rounded),
                        tooltip: 'Increase volume by 10',
                        onPressed: () {
                          videoIndex += 1;
                          _nextVideoPlay(Video2List.videoList[
                              videoIndex % Video2List.videoList.length]);
                        },
                      ),
                    ),
                    _progress != null
                        ? const CircularProgressIndicator()
                        : Container(
                            decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                                border: Border.all(color: Colors.teal, width: 2)),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0, right: 8),
                              child: TextButton(
                                  onPressed: () {
                                    FileDownloader.downloadFile(
                                        url:"https://drive.google.com/uc?export=download&id=1L-dA_j9fM9LteJ4yJZLSQ35UY6r4Pp64",
                                        name: "PANDA",
                                        onProgress: (fileName, progress) {
                                          setState(() {
                                            _progress = progress;
                                          });
                                        },
                                        onDownloadCompleted: (path) {
                                          setState(() {
                                            _progress = null;
                                          });
                                          final File file = File(path);
                                          log(file.path);
                                          //This will be the path of the downloaded file
                                        });
                                  },
                                  child: Text(
                                    'Download',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 15),
                                  )),
                            ),
                          ),
                  ],
                )
              ],
            );
            }, 
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _videoController.dispose();
    super.dispose();
  }
}
