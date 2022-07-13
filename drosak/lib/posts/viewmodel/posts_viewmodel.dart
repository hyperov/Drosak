import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../utils/storage_keys.dart';
import '../model/entity/post.dart';
import '../model/repo/posts_repo.dart';

class PostsViewModel extends GetxController {
  final PostsRepo _postsRepo = Get.put(PostsRepo());

  final RxList<Post> posts = <Post>[].obs;

  RxBool isLoading = false.obs;

  final _storage = GetStorage();

  Post? selectedPost; // if null, then add new post, otherwise edit post
  int selectedIndex = -1; // if null, then add new post, otherwise edit post

  @override
  onReady() async {
    super.onReady();
    await getPosts();
  }

  getPosts() async {
    isLoading.value = true;
    String? teacherId = _storage.read<String>(StorageKeys.teacherId);

    var _localPosts = await _postsRepo.getPosts(teacherId!);
    var postsDocs = _localPosts.docs.map((doc) {
      var post = doc.data();
      post.id = doc.id; // set document id to post
      return post;
    });

    isLoading.value = false;
    posts.clear();
    posts.addAll(postsDocs);
  }
}
