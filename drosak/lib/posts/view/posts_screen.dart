import 'package:drosak/utils/localization/localization_keys.dart';
import 'package:drosak/utils/managers/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';

import '../viewmodel/posts_viewmodel.dart';

class PostsScreen extends StatelessWidget {
  const PostsScreen(
      {Key? key,
      required this.scrollController,
      required,
      required this.isFollowing})
      : super(key: key);

  final ScrollController scrollController;
  final bool Function() isFollowing;

  PostsViewModel get _postsViewModel => Get.put(PostsViewModel());

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          backgroundColor: ColorManager.redOrangeLight,
          body: _postsViewModel.isLoading.value
              ? const Center(child: CircularProgressIndicator())
              : _postsViewModel.posts.isNotEmpty
                  ? isFollowing()
                      ? ListView.builder(
                          controller: scrollController,
                          itemCount: _postsViewModel.posts.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                _postsViewModel.selectedPost =
                                    _postsViewModel.posts[index];
                                _postsViewModel.selectedIndex = index;
                              },
                              child: Card(
                                  margin: const EdgeInsets.all(16),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  elevation: 4,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(_postsViewModel.posts[index].title),
                                      const SizedBox(height: 8),
                                      SizedBox(
                                        child: Text(
                                            _postsViewModel.posts[index].body),
                                        width: double.infinity,
                                      ),
                                      const SizedBox(height: 24),
                                      Text(
                                          Jiffy(_postsViewModel
                                                  .posts[index].date)
                                              .format("dd MMM yyyy"),
                                          style: const TextStyle(
                                              fontSize: 16,
                                              color: Colors.grey)),
                                    ],
                                  ).paddingSymmetric(
                                      horizontal: 16, vertical: 16)),
                            );
                          },
                          physics: const BouncingScrollPhysics())
                      : Center(
                          child:
                              Text(LocalizationKeys.follow_teacher_no_posts.tr))
                  : const Center(child: Text('No posts yet')),
        ));
  }
}
