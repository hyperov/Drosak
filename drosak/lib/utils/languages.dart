import 'package:get/get.dart';

import 'localization_keys.dart';

class Languages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          LocalizationKeys.enter_phone_number: 'Enter your phone number',
          LocalizationKeys.phone_confirmation:
              'you will receive a confirmation code on your phone',
          LocalizationKeys.phone_number: 'Phone number',
          LocalizationKeys.phone_number_hint: '01xxxxxxxxx',
          LocalizationKeys.phone_number_error: 'Phone number is wrong',
          LocalizationKeys.app_login: 'Login with phone number',
          LocalizationKeys.app_logout: 'Logout',
          LocalizationKeys.login_google: 'Login with Google',
          LocalizationKeys.login_facebook: 'Login with Facebook',
          LocalizationKeys.or: 'or',
        },
        'ar_EG': {
          LocalizationKeys.enter_phone_number: 'أدخل رقم هاتفك',
          LocalizationKeys.phone_confirmation: 'هيجيلك رسالة تأكيد على موبايلك',
          LocalizationKeys.phone_number: 'رقم الهاتف',
          LocalizationKeys.phone_number_hint: '01xxxxxxxxx',
          LocalizationKeys.phone_number_error: 'رقم الهاتف غير صحيح',
          LocalizationKeys.app_login: 'تسجيل الدخول بالموبايل',
          LocalizationKeys.app_logout: 'تسجيل الخروج',
          LocalizationKeys.login_google: 'تسجيل الدخول بحساب جوجل',
          LocalizationKeys.login_facebook: 'تسجيل الدخول بحساب فيسبوك',
          LocalizationKeys.or: 'أو',
        },
      };
}
