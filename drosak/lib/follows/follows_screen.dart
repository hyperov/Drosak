import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'follows_viewmodel.dart';

class FollowsScreen extends StatelessWidget {
  FollowsScreen({Key? key}) : super(key: key);

  FollowsViewModel _followsViewModel = Get.find();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemBuilder: (context, index) {
          return Obx(() => SwitchListTile(
                title: Text("ابراهيم خالد الحربي"),
                subtitle: Text("فيزياء"),
                secondary: CircleAvatar(
                  backgroundImage: NetworkImage(
                      "https://images.unsplash.com/photo-1518791841217-8f162f1e1131?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60"),
                ),
                value: _followsViewModel.follows[index],
                onChanged: (value) {
                  _followsViewModel.follows[index] = value;
                },
              ));
        },
        itemCount: _followsViewModel.follows.length);
  }
}
