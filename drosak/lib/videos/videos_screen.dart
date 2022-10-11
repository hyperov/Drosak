import 'package:better_player/better_player.dart';
import 'package:drosak/videos/my_webview.dart';
import 'package:flutter/material.dart';

import 'videos_viewmodel.dart';

class VideosScreen extends StatefulWidget {
  VideosScreen({Key? key}) : super(key: key);

  @override
  State<VideosScreen> createState() => _VideosScreenState();
}

class _VideosScreenState extends State<VideosScreen> {
  final _videosViewModel = VideosViewModel();
  late BetterPlayerController betterPlayerController;

  @override
  void initState() {
    super.initState();
    BetterPlayerDataSource betterPlayerDataSource = BetterPlayerDataSource(
        BetterPlayerDataSourceType.network,
        // "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4");
        // "https://playready.ezdrm.com/cency/preauth.aspx?pX=ECD463");
        "https://video.bunnycdn.com/play/65386/6fad0400-3380-40c9-978a-f34f3aa69780",
        videoFormat: BetterPlayerVideoFormat.hls,
        headers: {
          "User-Agent:":
              "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:59.0) Gecko/20100101 Firefox/59.0",
          "Content-Type:": "application/vnd.apple.mpegurl"
        });
    // "https://s3.eu-central-1.wasabisys.com/drosak-bucket/Detective%20Conan%20episode%201.avi");
    betterPlayerController = BetterPlayerController(
        const BetterPlayerConfiguration(),
        betterPlayerDataSource: betterPlayerDataSource);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: AspectRatio(
      aspectRatio: 16 / 9,
      child: BetterPlayer(
        controller: betterPlayerController,
      ),
    ));
  }

  onDispose() {
    betterPlayerController.dispose();
    super.dispose();
  }
}
