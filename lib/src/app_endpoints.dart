class AppEndPoints {
  static const String baseUrl = 'https://visaino.com/lawyers/test_moh/public';

  // Authentication
  static const String register = '$baseUrl/auth/register.php';
  static const String login = '$baseUrl/auth/login.php';

  // User
  static const String studentData = '$baseUrl/users/student_data.php';
  static const String tutorData = '$baseUrl/users/tutor_data.php';
  static const String updateImage = '$baseUrl/users/update_image.php';

  // Classes
  static const String manageReqeust = '$baseUrl/enrolments/manage_request.php';
  static const String createClass = '$baseUrl/enrolments/create_class.php';
  static const String joinClass = '$baseUrl/enrolments/request_enrolment.php';
  static const String attendClass = '$baseUrl/attendance/check_attendance.php';
  static const String createLecture = '$baseUrl/attendance/create_lecture.php';
}
