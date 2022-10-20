import 'package:drosak/videos/model/entity/create_video_body.dart';
import 'package:drosak/videos/model/repo/video_repo.dart';
import 'package:get/get.dart';

class VideoViewModel extends GetxController {
  final VideoRepo _videoRepo = Get.put(VideoRepo());

  Future<void> createVideoObj() async {
    CreateVideoBody createVideoBody = const CreateVideoBody(title: "test");
    var createVideoRes = await _videoRepo.createVideoObj(createVideoBody);
    print(createVideoRes);
  }
}
