class StudentLecture {
  String? id;
  String? title;
  String? courseId;
  String? qrDuration;
  String? qrCode;
  String? dateCreated;
  bool? isAttended;

  StudentLecture(
      {this.id,
      this.qrCode,
      this.qrDuration,
      this.title,
      this.courseId,
      this.isAttended,
      this.dateCreated});

  StudentLecture.fromJson(Map<String, dynamic> json) {
    id = json['lecture_id'];
    title = json['lecture_title'];
    courseId = json['lecture_courseId'];
    qrCode = json['lecture_qrCode'];
    qrDuration = json['lecture_qrDuration'];
    isAttended = json['is_attended'] == 'true' ? true : false;
    dateCreated = json['lecture_dateCreated'];
  }
}

class StudentModel {
  bool? success;
  String? message;
  String? dow;
  StudentInfo? userInfo;
  List<StudentCourse?>? userCourses;
  List<StudentCourse?>? todayCourses;
  List<StudentCourse?>? enabledCourses;
  List<StudentCourse?>? disabledCourses;

  StudentModel({
    this.success,
    this.dow,
    this.message,
    this.userInfo,
    this.userCourses,
    this.disabledCourses,
    this.enabledCourses,
    this.todayCourses,
  });

  StudentModel.fromJson(Map<String, dynamic> json) {
    dow = json['dow'];
    if (json['user_courses'] != null) {
      todayCourses = <StudentCourse>[];
      json['user_courses'].forEach((v) {
        if (StudentCourse.fromJson(v).isEnabled! &&
            StudentCourse.fromJson(v).isToday!) {
          todayCourses!.add(StudentCourse.fromJson(v));
        }
      });
    }
    if (json['user_courses'] != null) {
      enabledCourses = <StudentCourse>[];
      json['user_courses'].forEach((v) {
        if (StudentCourse.fromJson(v).isEnabled!) {
          enabledCourses!.add(StudentCourse.fromJson(v));
        }
      });
    }
    if (json['user_courses'] != null) {
      disabledCourses = <StudentCourse>[];
      json['user_courses'].forEach((v) {
        if (!StudentCourse.fromJson(v).isEnabled!) {
          disabledCourses!.add(StudentCourse.fromJson(v));
        }
      });
    }
    success = json['success'];
    message = json['message'];
    userInfo = json['user_info'] != null
        ? StudentInfo?.fromJson(json['user_info'])
        : null;
    if (json['user_courses'] != null) {
      userCourses = <StudentCourse>[];
      json['user_courses'].forEach((v) {
        userCourses!.add(StudentCourse.fromJson(v));
      });
    }
  }
}

class StudentCourse {
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
  List<StudentLecture?>? lectures;

  StudentCourse(
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

  StudentCourse.fromJson(Map<String, dynamic> json) {
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
      lectures = <StudentLecture>[];
      json['lectures'].forEach((v) {
        lectures!.add(StudentLecture.fromJson(v));
      });
    }
  }
}

class StudentInfo {
  String? id;
  String? name;
  String? email;
  String? status;
  String? type;
  String? image;
  String? lastAccess;
  String? dateJoined;

  StudentInfo({
    this.id,
    this.name,
    this.email,
    this.status,
    this.image,
    this.type,
    this.lastAccess,
    this.dateJoined,
  });

  StudentInfo.fromJson(Map<String, dynamic> json) {
    id = json['user_id'];

    image = json['user_image'];
    name = json['user_name'];
    email = json['user_email'];
    status = json['user_status'];
    type = json['user_type'];
    lastAccess = json['user_lastAccess'];
    dateJoined = json['user_dateCreated'];
  }
}
