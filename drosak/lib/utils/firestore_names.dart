class FireStoreNames {
  static const String collectionStudents = 'students';
  static const String collectionTeachers = 'teachers';

  static const String collectionTeacherPosts = 'posts';
  static const String collectionTeacherReviews = 'reviews';
  static const String collectionTeacherLectures = 'lectures'; //الحصص
  static const String collectionTeacherBookingsInfo = 'bookings_info'; //الحصص

  static const String collectionStudentFollows = 'follows';
  static const String collectionStudentBookings = 'bookings';
  static const String collectionStudentNotifications = 'notifications';

  //login fields
  static const String studentDocFieldIsLogin = 'isLogin';
  static const String studentDocFieldLastSignInTime = 'lastSignInTime';
  static const String studentDocFieldFcmToken = 'fcm_token';
  static const String studentDocFieldFcmTokenTimeStamp = 'fcm_date';
  static const String studentDocFieldStudentId = 'student_id';

  //reviews fields
  static const String collectionTeacherReviewsSortFieldDate = 'date';
  static const String collectionTeacherReviewsSortFieldRating = 'rating';

  //teacher fields
  static const String teacherDocFieldIsActive = 'active';
  static const String teacherDocFieldMinPrice = 'price_min';
  static const String teacherDocFieldMaxPrice = 'price_max';
  static const String teacherDocFieldEducationLevel = 'eduLevel';
  static const String teacherDocFieldMaterial = 'material';
  static const String teacherDocFieldAreas = 'areas';
  static const String teacherDocFieldName = 'name';

  //booking fields
  static const String bookingDocFieldLecDate = 'lec_date';

  static const String followDocFieldTeacherName = 'name';
  static const String followDocFieldTeacherId = 'teacher_id';

  static const String lectureDocFieldIsEnabled = 'is_enabled';

  //education field values
  static const String educationLevelSecondaryValue = 'high_school';
  static const String educationLevelPrepValue = 'mid_school';

  static const String collectionAppStatistics = 'stats';
  static const String documentAppStatistics = 'app_stats';

  static const studentDocFieldProfileImageUrl = 'photoUrl';
}
