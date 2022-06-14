import 'package:drosak/common/viewmodel/network_viewmodel.dart';
import 'package:drosak/login/viewmodel/login_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/localization/localization_keys.dart';

class EnterSmsCodeScreen extends StatelessWidget {
  EnterSmsCodeScreen({Key? key}) : super(key: key);
  final LoginViewModel _loginViewModel = Get.find();
  final NetworkViewModel _networkViewModel = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              controller: _loginViewModel.smsCodeController,
              maxLength: 6,
              textInputAction: TextInputAction.send,
              textAlign: TextAlign.start,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'SMS Code',
                label: Text(LocalizationKeys.enter_sms_code.tr),
                alignLabelWithHint: true,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.black)),
              ),
            ).marginSymmetric(horizontal: 16),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                if (_networkViewModel.isConnected.value) {
                  _loginViewModel.sendSmsAndLogin();
                } else {
                  _networkViewModel.showNoInternetConnectionDialog();
                }
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
