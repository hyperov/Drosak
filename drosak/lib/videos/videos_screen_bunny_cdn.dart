import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'api/api_client.dart';
import 'viewmodel/video_viewmodel.dart';

class VideosScreenBunnyCdn extends StatefulWidget {
  const VideosScreenBunnyCdn({Key? key}) : super(key: key);

  @override
  State<VideosScreenBunnyCdn> createState() => _VideosScreenBunnyCdnState();
}

class _VideosScreenBunnyCdnState extends State<VideosScreenBunnyCdn> {
  final _videosViewModel = VideoViewModel();
  late BetterPlayerController betterPlayerController;

  @override
  void initState() {
    super.initState();
    BetterPlayerDataSource betterPlayerDataSource = BetterPlayerDataSource(
        BetterPlayerDataSourceType.network,
        // "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4");
        // "https://playready.ezdrm.com/cency/preauth.aspx?pX=ECD463");
        // "https://vz-a3e1effb-e16.b-cdn.net/6fad0400-3380-40c9-978a-f34f3aa69780/playlist.m3u8", //bunny
        "https://vz-a3e1effb-e16.b-cdn.net/46c9e6de-b26a-43bc-882c-6902de73fe70/playlist.m3u8",
        //bunny
        // "https://vz-a3e1effb-e16.b-cdn.net/00454a03-48c7-4d64-aa06-c6ee8b333471/playlist.m3u8", //bunny
        // "https://vz-a3e1effb-e16.b-cdn.net/c61bd346-f8a1-4679-9b59-34c4b61eaec2/playlist.m3u8", //bunny
        videoFormat: BetterPlayerVideoFormat.hls,
        videoExtension: "m3u8",
        headers: {
          'AccessKey': ApiClient.AccessKey,
          'content-type': 'application/*+json',
          'accept': 'application/json',
          // "User-Agent:":
          //     "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:59.0) Gecko/20100101 Firefox/59.0",
          // "Content-Type:": "application/vnd.apple.mpegurl"
          // "Content-Type:": " application/x-mpegURL"
        });
    betterPlayerController = BetterPlayerController(
        const BetterPlayerConfiguration(),
        betterPlayerDataSource: betterPlayerDataSource);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        AspectRatio(
          aspectRatio: 16 / 9,
          child: BetterPlayer(
            controller: betterPlayerController,
          ),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
            onPressed: () async {
              await _videosViewModel.createVideoObj();
            },
            child: const Text("create video")),
      ],
    ));
  }

  onDispose() {
    betterPlayerController.dispose();
    super.dispose();
  }
}
