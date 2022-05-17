import 'package:drosak/login/login_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EnterSmsCodeScreen extends StatelessWidget {
  EnterSmsCodeScreen({Key? key}) : super(key: key);
  final LoginViewModel loginViewModel = Get.put(LoginViewModel());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginViewModel>(
      init: loginViewModel,
      builder: (controller) => Scaffold(
        appBar: AppBar(
          title: const Text('SMS Code'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Enter the code sent to you by SMS'),
              const SizedBox(height: 16),
              TextField(
                onChanged: controller.smsCode,
                decoration: const InputDecoration(
                  hintText: 'SMS Code',
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: controller.sendSmsAndLogin(),
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
