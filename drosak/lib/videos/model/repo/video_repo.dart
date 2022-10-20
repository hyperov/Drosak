import 'package:drosak/videos/api/api_client.dart';
import 'package:drosak/videos/model/entity/create_video_body.dart';
import 'package:drosak/videos/model/entity/create_video_res.dart';
import 'package:get/get.dart';

class VideoRepo {
  final ApiClient _apiClient = Get.find();

  Future<CreateVideoRes> createVideoObj(CreateVideoBody body) async {
    return _apiClient.createVideoObj(body);
  }
}
