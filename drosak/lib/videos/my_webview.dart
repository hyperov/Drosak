import 'dart:io';

import 'package:drosak/utils/managers/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MyWebView extends StatefulWidget {
  const MyWebView({Key? key}) : super(key: key);

  @override
  State<MyWebView> createState() => _MyWebViewState();
}

class _MyWebViewState extends State<MyWebView> {
  @override
  void initState() {
    super.initState();
    // Enable virtual display.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return WebView(
      javascriptMode: JavascriptMode.unrestricted,
      allowsInlineMediaPlayback: true,
      backgroundColor: ColorManager.deepPurpleMaterial,
      initialMediaPlaybackPolicy: AutoMediaPlaybackPolicy.always_allow,
      zoomEnabled: true,
      initialUrl:
          "https://video.bunnycdn.com/play/65386/6fad0400-3380-40c9-978a-f34f3aa69780",
    );
  }
}
