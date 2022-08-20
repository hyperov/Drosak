import 'package:drosak/bookings/viewmodel/booking_view_model.dart';
import 'package:drosak/common/viewmodel/filter_viewmodel.dart';
import 'package:drosak/common/viewmodel/network_viewmodel.dart';
import 'package:drosak/follows/viewmodel/follows_viewmodel.dart';
import 'package:drosak/home/HomeViewModel.dart';
import 'package:drosak/login/viewmodel/login_view_model.dart';
import 'package:drosak/notifications/viewmodel/notifications_viewmodel.dart';
import 'package:drosak/profile/viewmodel/profile_view_model.dart';
import 'package:drosak/reviews/viewmodel/reviews_viewmodel.dart';
import 'package:get/get.dart';

import '../teachers/viewmodel/teachers_list_viewmodel.dart';

class InitialBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NetworkViewModel>(() => NetworkViewModel(), fenix: true);
    Get.lazyPut<ProfileViewModel>(() => ProfileViewModel(), fenix: true);
    Get.lazyPut<FilterViewModel>(() => FilterViewModel());
    Get.lazyPut<FollowsViewModel>(() => FollowsViewModel(), fenix: true);
    Get.lazyPut<NotificationsViewModel>(() => NotificationsViewModel(),fenix: true);
    Get.lazyPut<ReviewsViewModel>(() => ReviewsViewModel(), fenix: true);
    Get.lazyPut<BookingsViewModel>(() => BookingsViewModel(), fenix: true);
    Get.put(LoginViewModel(), permanent: true);
    Get.lazyPut<TeachersListViewModel>(() => TeachersListViewModel(),
        fenix: true);
  }
}

class HomeBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeViewModel>(() => HomeViewModel(), fenix: true);
    Get.lazyPut<FilterViewModel>(() => FilterViewModel());
  }
}
