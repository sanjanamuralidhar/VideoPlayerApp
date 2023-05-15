class VideoList {
  final String dataSource;

  const VideoList({required this.dataSource});
}

// List<VideoList> videoList = [
//   const VideoList(dataSource: "assets/video/video1.mp4"),
//   const VideoList(dataSource: "assets/video/video2.mp4"),
//   const VideoList(dataSource: "assets/video/video3.mp4"),
//   const VideoList(dataSource: "assets/video/video4.mp4"),
//   const VideoList(dataSource: "assets/video/video5.mp4"),
//   const VideoList(dataSource: "assets/video/video6.mp4")
// ];
List<VideoList> videoList = [
  const VideoList(dataSource: "https://drive.google.com/uc?export=download&id=1L-dA_j9fM9LteJ4yJZLSQ35UY6r4Pp64"),
  const VideoList(dataSource: "https://drive.google.com/uc?export=download&id=1WMHWHKHgy3tgzUTemfpKVrglyy8eTGkn"),
  const VideoList(dataSource: "https://drive.google.com/uc?export=download&id=1qO7Sxci86ma-rN9205lqt71VdT2JqLg1"),
  const VideoList(dataSource: "https://drive.google.com/uc?export=download&id=1RmHzvr0nf5J__Mn9dS7urAfVXrWD3uGu"),
  const VideoList(dataSource: "https://drive.google.com/uc?export=download&id=17OqUND459mbi74dsG4-tuse_ZeHeyaHC")
];

class Video2List {

static List<String> videoList = [
  "https://drive.google.com/uc?export=download&id=1L-dA_j9fM9LteJ4yJZLSQ35UY6r4Pp64",
  "https://drive.google.com/uc?export=download&id=1WMHWHKHgy3tgzUTemfpKVrglyy8eTGkn",
  "https://drive.google.com/uc?export=download&id=1qO7Sxci86ma-rN9205lqt71VdT2JqLg1",
  "https://drive.google.com/uc?export=download&id=1RmHzvr0nf5J__Mn9dS7urAfVXrWD3uGu",
  "https://drive.google.com/uc?export=download&id=17OqUND459mbi74dsG4-tuse_ZeHeyaHC"
];
}