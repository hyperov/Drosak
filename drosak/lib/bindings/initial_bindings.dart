import 'package:drosak/common/viewmodel/NetworkViewModel.dart';
import 'package:drosak/home/HomeViewModel.dart';
import 'package:drosak/login/viewmodel/login_view_model.dart';
import 'package:drosak/profile/viewmodel/profile_view_model.dart';
import 'package:get/get.dart';

class InitialBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NetworkViewModel>(() => NetworkViewModel());
    Get.lazyPut<ProfileViewModel>(() => ProfileViewModel());
    Get.put(LoginViewModel());
    Get.put(HomeViewModel());
  }
}
