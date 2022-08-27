import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
import 'package:drosak/common/viewmodel/network_viewmodel.dart';
import 'package:drosak/login/viewmodel/login_view_model.dart';
import 'package:drosak/utils/managers/assets_manager.dart';
import 'package:drosak/utils/managers/color_manager.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../utils/localization/localization_keys.dart';

class EnterSmsCodeScreen extends StatelessWidget {
  EnterSmsCodeScreen({Key? key}) : super(key: key);
  final LoginViewModel _loginViewModel = Get.find();
  final NetworkViewModel _networkViewModel = Get.find();

  @override
  Widget build(BuildContext context) {
    FirebaseAnalytics.instance.logEvent(
      name: 'screen_view',
      parameters: {
        'firebase_screen': 'enter_sms_code_screen',
        'firebase_screen_class': 'EnterSmsCodeScreen',
      },
    );
    return Scaffold(
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        reverse: true,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: Get.height * 0.1,
              ),
              SvgPicture.asset(
                AssetsManager.smsScreenBackground,
                // height: 100,
              ),
              Text(LocalizationKeys.enter_sms_code.tr,
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black)),
              Text(LocalizationKeys.enter_six_digits_code.tr,
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: Colors.grey)),
              const SizedBox(height: 20),
              Wrap(
                alignment: WrapAlignment.spaceBetween,
                direction: Axis.horizontal,
                textDirection: TextDirection.ltr,
                spacing: 14,
                children: [
                  SizedBox(
                    width: 40,
                    child: TextField(
                      maxLength: 1,
                      showCursor: false,
                      controller: _loginViewModel.smsCodeControllerFirst,
                      textInputAction: TextInputAction.next,
                      onChanged: (value) {
                        if (_loginViewModel
                                .smsCodeControllerFirst.text.length ==
                            1) {
                          _loginViewModel.smsCodeFocusNodeSecond.requestFocus();
                        }
                      },
                      focusNode: _loginViewModel.smsCodeFocusNodeFirst,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(1),
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                      ],
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.black)),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 40,
                    child: TextField(
                      maxLength: 1,
                      showCursor: false,
                      controller: _loginViewModel.smsCodeControllerSecond,
                      textInputAction: TextInputAction.next,
                      focusNode: _loginViewModel.smsCodeFocusNodeSecond,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(1),
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                      ],
                      onChanged: (value) {
                        if (_loginViewModel
                                .smsCodeControllerSecond.text.length ==
                            1) {
                          _loginViewModel.smsCodeFocusNodeThird.requestFocus();
                        } else if (_loginViewModel
                            .smsCodeControllerSecond.text.isEmpty) {
                          _loginViewModel.smsCodeFocusNodeFirst.requestFocus();
                        }
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.black)),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 40,
                    child: TextField(
                      maxLength: 1,
                      showCursor: false,
                      controller: _loginViewModel.smsCodeControllerThird,
                      textInputAction: TextInputAction.next,
                      focusNode: _loginViewModel.smsCodeFocusNodeThird,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(1),
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                      ],
                      onChanged: (value) {
                        if (_loginViewModel
                                .smsCodeControllerThird.text.length ==
                            1) {
                          _loginViewModel.smsCodeFocusNodeFourth.requestFocus();
                        } else if (_loginViewModel
                            .smsCodeControllerThird.text.isEmpty) {
                          _loginViewModel.smsCodeFocusNodeSecond.requestFocus();
                        }
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.black)),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 40,
                    child: TextField(
                      maxLength: 1,
                      showCursor: false,
                      controller: _loginViewModel.smsCodeControllerFourth,
                      textInputAction: TextInputAction.next,
                      focusNode: _loginViewModel.smsCodeFocusNodeFourth,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(1),
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                      ],
                      onChanged: (value) {
                        if (_loginViewModel
                                .smsCodeControllerFourth.text.length ==
                            1) {
                          _loginViewModel.smsCodeFocusNodeFifth.requestFocus();
                        } else if (_loginViewModel
                            .smsCodeControllerFourth.text.isEmpty) {
                          _loginViewModel.smsCodeFocusNodeThird.requestFocus();
                        }
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.black)),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 40,
                    child: TextField(
                      maxLength: 1,
                      showCursor: false,
                      controller: _loginViewModel.smsCodeControllerFifth,
                      textInputAction: TextInputAction.next,
                      focusNode: _loginViewModel.smsCodeFocusNodeFifth,
                      textAlign: TextAlign.start,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(1),
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                      ],
                      onChanged: (value) {
                        if (_loginViewModel
                                .smsCodeControllerFifth.text.length ==
                            1) {
                          _loginViewModel.smsCodeFocusNodeSixth.requestFocus();
                        } else if (_loginViewModel
                            .smsCodeControllerFifth.text.isEmpty) {
                          _loginViewModel.smsCodeFocusNodeFourth.requestFocus();
                        }
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.black)),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 40,
                    child: TextField(
                      maxLength: 1,
                      showCursor: false,
                      controller: _loginViewModel.smsCodeControllerSixth,
                      textInputAction: TextInputAction.done,
                      textAlign: TextAlign.start,
                      focusNode: _loginViewModel.smsCodeFocusNodeSixth,
                      onChanged: (value) {
                        if (_loginViewModel
                            .smsCodeControllerSixth.text.isEmpty) {
                          _loginViewModel.smsCodeFocusNodeFifth.requestFocus();
                        }
                      },
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(1),
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                      ],
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.black)),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    LocalizationKeys.sms_code_not_sent_question.tr,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(width: 8),
                  ArgonTimerButton(
                    initialTimer: 30,
                    height: 50,
                    width: MediaQuery.of(context).size.width * 0.45,
                    minWidth: MediaQuery.of(context).size.width * 0.30,
                    color: ColorManager.deepPurple,
                    borderRadius: 25.0,
                    roundLoadingShape: true,
                    child: const Text(
                      "send OTP",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w700),
                    ),
                    loader: (timeLeft) {
                      return Text(
                        "Wait | $timeLeft",
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w700),
                      );
                    },
                    onTap: (startTimer, btnState) async {
                      if (btnState == ButtonState.Idle) {
                        startTimer(30);
                        await _loginViewModel.resendSmsCode();
                      }
                    },
                  )
                ],
              ),
              const SizedBox(height: 48),
              Container(
                width: double.infinity,
                height: 50,
                margin: const EdgeInsets.symmetric(horizontal: 24),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: ColorManager.deepPurple,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: () {
                    if (_networkViewModel.isConnected.value) {
                      clickSendSmsButton(_loginViewModel);
                    } else {
                      _networkViewModel.showNoInternetConnectionDialog();
                    }
                  },
                  child: Text(LocalizationKeys.confirm.tr,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void clickSendSmsButton(LoginViewModel controller) {
    if (_loginViewModel.validateSmsCode() == null) {
      controller.sendSmsAndLogin();
    }
  }
}
