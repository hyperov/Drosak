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
          LocalizationKeys.phone_number_error_empty: 'Phone number is empty',
          LocalizationKeys.phone_number_error_length:
              'Phone number must be at least 11 digits',
          LocalizationKeys.phone_number_error_format:
              'Phone number must be in the format 01xxxxxxxxx',
          LocalizationKeys.app_login: 'Login with phone number',
          LocalizationKeys.app_logout: 'Logout',
          LocalizationKeys.login_google: 'Login with Google',
          LocalizationKeys.login_facebook: 'Login with Facebook',
          LocalizationKeys.or: 'OR',
          LocalizationKeys.login_error: 'Login error happened !',
          LocalizationKeys.network_error: 'Network error happened !',
          LocalizationKeys.network_error_message:
              'Please check your internet connection and try again',
          LocalizationKeys.network_success: 'Network success !',
          LocalizationKeys.network_success_message:
              'You are connected to the internet',
          LocalizationKeys.facebook_login_error:
              'Login with Facebook error happened !',
        },
        'ar_EG': {
          LocalizationKeys.enter_phone_number: 'أدخل رقم هاتفك',
          LocalizationKeys.phone_confirmation: 'هيجيلك رسالة تأكيد على موبايلك',
          LocalizationKeys.phone_number: 'رقم الهاتف',
          LocalizationKeys.phone_number_hint: '01xxxxxxxxx',
          LocalizationKeys.phone_number_error: 'رقم الهاتف غير صحيح',
          LocalizationKeys.phone_number_error_empty: 'رقم الهاتف فاضي',
          LocalizationKeys.phone_number_error_length:
              'رقم الموبايل لازم يكون 11 رقم',
          LocalizationKeys.phone_number_error_format:
              'رقم الموبايل يجب أن يكون بالشكل 01xxxxxxxxx',
          LocalizationKeys.app_login: 'تسجيل الدخول بالموبايل',
          LocalizationKeys.app_logout: 'تسجيل الخروج',
          LocalizationKeys.login_google: 'سجل الدخول بحساب جوجل',
          LocalizationKeys.login_facebook: 'سجل الدخول بحساب فيسبوك',
          LocalizationKeys.or: 'أو',
          LocalizationKeys.login_error: 'حدث خطأ في تسجيل الدخول !',
          LocalizationKeys.network_error: 'حدث خطأ في الشبكة',
          LocalizationKeys.network_error_message:
              'يرجى التأكد من اتصالك بالشبكة وحاول مرة أخرى',
          LocalizationKeys.network_success: 'تم الاتصال بالشبكة',
          LocalizationKeys.network_success_message: 'لقد قمت بالاتصال بالشبكة',
          LocalizationKeys.facebook_login_error:
              'حدث خطأ في تسجيل الدخول بحساب فيسبوك',
        },
      };
}
