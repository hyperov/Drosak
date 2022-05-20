import 'package:drosak/login/login_view_model.dart';
import 'package:drosak/login/viewmodel/NetworkViewModel.dart';
import 'package:get/get.dart';

class InitialBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NetworkViewModel>(() => NetworkViewModel());
    Get.put(LoginViewModel());
  }
}
