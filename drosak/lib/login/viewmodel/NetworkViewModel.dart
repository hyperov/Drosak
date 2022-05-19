import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class NetworkViewModel extends GetxController {
  final RxBool isConnected = true.obs;

  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  // @override
  // onInit() {
  //   super.onInit();
  //   // initConnectivity();
  //   _connectivitySubscription =
  //       _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  // }

  @override
  onReady() {
    super.onReady();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  @override
  dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      printError(
          info: 'Couldn\'t check connectivity status because of: ${e.message}');
      return;
    }

    _updateConnectionStatus(result);
  }

  _updateConnectionStatus(ConnectivityResult event) {
    if (event == ConnectivityResult.mobile ||
        event == ConnectivityResult.wifi) {
      isConnected.value = true;
    } else {
      isConnected.value = false;
    }
    // return isConnected.value;
  }
}
