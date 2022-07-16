class FireStoreNames {
  static const String collectionStudents = 'students';
  static const String collectionTeachers = 'teachers';

  static const String collectionTeacherPosts = 'posts';
  static const String collectionTeacherReviews = 'reviews';
  static const String collectionTeacherLectures = 'lectures'; //الحصص

  static const String collectionStudentFollows = 'follows';
  static const String collectionStudentFavs = 'favs';
  static const String collectionStudentBookings = 'bookings';

  //login fields
  static const String studentDocFieldIsLogin = 'isLogin';
  static const String studentDocFieldLastSignInTime = 'lastSignInTime';

  //reviews fields
  static const String collectionTeacherReviewsSortFieldDate = 'date';
  static const String collectionTeacherReviewsSortFieldRating = 'rating';

  //teacher fields
  static const String teacherDocFieldIsActive = 'active';

  //education field values
  static const String educationLevelSecondaryValue = 'high_school';
  static const String educationLevelPrepValue = 'mid_school';

  static Object followDocFieldTeacherName = 'name';
  static Object followDocFieldTeacherId = 'id';
}
