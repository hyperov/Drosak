import 'package:drosak/common/viewmodel/NetworkViewModel.dart';
import 'package:drosak/common/viewmodel/filter_viewmodel.dart';
import 'package:drosak/follows/follows_viewmodel.dart';
import 'package:drosak/home/HomeViewModel.dart';
import 'package:drosak/login/viewmodel/login_view_model.dart';
import 'package:drosak/profile/viewmodel/profile_view_model.dart';
import 'package:get/get.dart';

class InitialBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NetworkViewModel>(() => NetworkViewModel());
    Get.lazyPut<ProfileViewModel>(() => ProfileViewModel());
    Get.lazyPut<FilterViewModel>(() => FilterViewModel());
    Get.lazyPut<FollowsViewModel>(() => FollowsViewModel());
    Get.put(LoginViewModel());
    Get.put(HomeViewModel());
  }
}
