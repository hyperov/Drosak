import 'package:drosak/utils/managers/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';

import '../../utils/localization/localization_keys.dart';
import '../viewmodel/posts_viewmodel.dart';

class PostsScreen extends StatelessWidget {
  const PostsScreen({Key? key}) : super(key: key);

  PostsViewModel get _postsViewModel => Get.put(PostsViewModel());

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          backgroundColor: ColorManager.redOrangeLight,
          body: _postsViewModel.isLoading.value
              ? const Center(child: CircularProgressIndicator())
              : _postsViewModel.posts.isNotEmpty
                  ? ListView.builder(
                      itemCount: _postsViewModel.posts.length,
                      itemBuilder: (context, index) {
                        return Slidable(
                          startActionPane: ActionPane(
                              motion: const DrawerMotion(),
                              extentRatio: 0.2,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Card(
                                    color: Colors.red,
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 16),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: InkWell(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const Icon(Icons.delete,
                                                color: Colors.white),
                                            Text(
                                              LocalizationKeys.app_delete.tr,
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16),
                                            ),
                                          ],
                                        ),
                                        onTap: () {}),
                                  ),
                                ),
                              ]),
                          child: InkWell(
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(_postsViewModel.posts[index].title),
                                    const SizedBox(height: 8),
                                    SizedBox(
                                      child: Text(
                                          _postsViewModel.posts[index].body),
                                      width: double.infinity,
                                    ),
                                    const SizedBox(height: 24),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                            Jiffy(_postsViewModel
                                                    .posts[index].date)
                                                .format("dd MMM yyyy"),
                                            style: const TextStyle(
                                                fontSize: 16,
                                                color: Colors.grey)),
                                        Icon(Icons.edit, color: Colors.blue),
                                      ],
                                    ),
                                  ],
                                ).paddingSymmetric(
                                    horizontal: 16, vertical: 16)),
                          ),
                        );
                      },
                      physics: const BouncingScrollPhysics())
                  : const Center(child: Text('No posts yet')),
        ));
  }
}
