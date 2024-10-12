class AppEndPoints {
  static const String baseUrl = 'https://visaino.com/lawyers/test_moh/public';

  // Authentication
  static const String register = '$baseUrl/auth/register.php';
  static const String login = '$baseUrl/auth/login.php';

  // User
  static const String userData = '$baseUrl/users/user_data.php';

  // Classes
  static const String joinClass = '$baseUrl/enrolments/request_enrolment.php';
  static const String attendClass = '$baseUrl/attendance/check_attendance.php';
}
