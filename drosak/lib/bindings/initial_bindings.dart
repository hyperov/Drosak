import 'package:drosak/common/viewmodel/NetworkViewModel.dart';
import 'package:drosak/login/viewmodel/login_view_model.dart';
import 'package:get/get.dart';

class InitialBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NetworkViewModel>(() => NetworkViewModel());
    Get.put(LoginViewModel());
  }
}
