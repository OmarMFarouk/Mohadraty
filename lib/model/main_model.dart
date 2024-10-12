class Lecture {
  String? id;
  String? title;
  String? courseId;
  String? dateCreated;

  Lecture({this.id, this.title, this.courseId, this.dateCreated});

  Lecture.fromJson(Map<String, dynamic> json) {
    id = json['lecture_id'];
    title = json['lecture_title'];
    courseId = json['lecture_courseId'];
    dateCreated = json['lecture_dateCreated'];
  }
}

class MainModel {
  bool? success;
  String? message;
  String? dow;
  UserInfo? userInfo;
  List<UserCourse?>? userCourses;
  List<UserCourse?>? todayCourses;
  List<UserCourse?>? enabledCourses;
  List<UserCourse?>? disabledCourses;

  MainModel({
    this.success,
    this.dow,
    this.message,
    this.userInfo,
    this.userCourses,
    this.disabledCourses,
    this.enabledCourses,
    this.todayCourses,
  });

  MainModel.fromJson(Map<String, dynamic> json) {
    dow = json['dow'];
    if (json['user_courses'] != null) {
      todayCourses = <UserCourse>[];
      json['user_courses'].forEach((v) {
        if (UserCourse.fromJson(v).isEnabled! &&
            UserCourse.fromJson(v).isToday!) {
          todayCourses!.add(UserCourse.fromJson(v));
        }
      });
    }
    if (json['user_courses'] != null) {
      enabledCourses = <UserCourse>[];
      json['user_courses'].forEach((v) {
        if (UserCourse.fromJson(v).isEnabled!) {
          enabledCourses!.add(UserCourse.fromJson(v));
        }
      });
    }
    if (json['user_courses'] != null) {
      disabledCourses = <UserCourse>[];
      json['user_courses'].forEach((v) {
        if (!UserCourse.fromJson(v).isEnabled!) {
          disabledCourses!.add(UserCourse.fromJson(v));
        }
      });
    }
    success = json['success'];
    message = json['message'];
    userInfo = json['user_info'] != null
        ? UserInfo?.fromJson(json['user_info'])
        : null;
    if (json['user_courses'] != null) {
      userCourses = <UserCourse>[];
      json['user_courses'].forEach((v) {
        userCourses!.add(UserCourse.fromJson(v));
      });
    }
  }
}

class UserCourse {
  String? id;
  String? adminId;
  String? code;
  String? title;
  String? startDate;
  String? endDate;
  bool? isEnabled;
  String? image;
  String? dateModified;
  List<String>? weekDays;
  List<String>? weekHours;
  String? dateCreated;
  String? author;
  bool? isToday;
  List<Lecture?>? lectures;

  UserCourse(
      {this.id,
      this.adminId,
      this.code,
      this.title,
      this.startDate,
      this.endDate,
      this.isEnabled,
      this.image,
      this.weekDays,
      this.weekHours,
      this.dateModified,
      this.dateCreated,
      this.isToday,
      this.author,
      this.lectures});

  UserCourse.fromJson(Map<String, dynamic> json) {
    id = json['course_id'];
    adminId = json['course_adminId'];
    author = json['course_author'];
    code = json['course_code'];
    title = json['course_title'];
    startDate = json['course_startDate'];
    endDate = json['course_endDate'];
    isEnabled = json['course_status'] == 'enabled' ? true : false;
    image = json['course_image'];
    weekDays = json['course_weekDays'].toString().split(',');
    weekHours =
        json['course_weekHours'].toString().split(',').reversed.toList();
    dateModified = json['course_dateModified'];

    dateCreated = json['course_dateCreated'];
    isToday = json['is_today'] == 'true' ? true : false;
    if (json['lectures'] != null) {
      lectures = <Lecture>[];
      json['lectures'].forEach((v) {
        lectures!.add(Lecture.fromJson(v));
      });
    }
  }
}

class UserInfo {
  String? id;
  String? name;
  String? email;
  String? status;
  String? type;
  String? lastAccess;
  String? dateJoined;

  UserInfo({
    this.id,
    this.name,
    this.email,
    this.status,
    this.type,
    this.lastAccess,
    this.dateJoined,
  });

  UserInfo.fromJson(Map<String, dynamic> json) {
    id = json['user_id'];
    name = json['user_name'];
    email = json['user_email'];
    status = json['user_status'];
    type = json['user_type'];
    lastAccess = json['user_lastAccess'];
    dateJoined = json['user_dateCreated'];
  }
}
