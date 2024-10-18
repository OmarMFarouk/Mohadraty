class TutorEnrolment {
  String? enrolmentid;
  String? enrolmentuserId;
  String? enrolmentcourseId;
  String? enrolmentstudentCode;
  String? enrolmentstatus;
  String? enrolmentdateCreated;
  String? enrolmentstudentName;
  String? attendancecount;
  String? courseName;
  String? studentImage;

  TutorEnrolment(
      {this.enrolmentid,
      this.enrolmentuserId,
      this.courseName,
      this.studentImage,
      this.enrolmentcourseId,
      this.enrolmentstudentCode,
      this.enrolmentstatus,
      this.enrolmentdateCreated,
      this.enrolmentstudentName,
      this.attendancecount});

  TutorEnrolment.fromJson(Map<String, dynamic> json) {
    enrolmentid = json['enrolment_id'];
    enrolmentuserId = json['enrolment_userId'];
    enrolmentcourseId = json['enrolment_courseId'];
    enrolmentstudentCode = json['enrolment_studentCode'];
    enrolmentstatus = json['enrolment_status'];
    enrolmentdateCreated = json['enrolment_dateCreated'];
    enrolmentstudentName = json['enrolment_studentName'];
    studentImage = json['enrolment_studentImage'];
    attendancecount = json['attendance_count'];
    courseName = json['course_name'];
  }
}

class TutorLecture {
  String? lectureid;
  String? lecturetitle;
  String? lecturecourseId;
  String? lectureqrCode;
  String? lectureqrDuration;
  String? lecturelocation;
  String? lecturedateCreated;
  String? attendance;

  TutorLecture(
      {this.lectureid,
      this.lecturetitle,
      this.lecturecourseId,
      this.lectureqrCode,
      this.lectureqrDuration,
      this.lecturelocation,
      this.lecturedateCreated,
      this.attendance});

  TutorLecture.fromJson(Map<String, dynamic> json) {
    lectureid = json['lecture_id'];
    lecturetitle = json['lecture_title'];
    lecturecourseId = json['lecture_courseId'];
    lectureqrCode = json['lecture_qrCode'];
    lectureqrDuration = json['lecture_qrDuration'];
    lecturelocation = json['lecture_location'];
    lecturedateCreated = json['lecture_dateCreated'];
    attendance = json['attendance'];
  }
}

class TutorModel {
  String? dow;
  bool? success;
  String? message;
  TutorInfo? tutorInfo;
  List<TutorCourse?>? tutorCourses;
  List<TutorEnrolment?>? pendingRequests;
  List<TutorCourse?>? todayCourses;
  List<TutorCourse?>? enabledCourses;
  List<TutorCourse?>? disabledCourses;

  TutorModel(
      {this.dow,
      this.success,
      this.disabledCourses,
      this.enabledCourses,
      this.todayCourses,
      this.pendingRequests,
      this.message,
      this.tutorInfo,
      this.tutorCourses});

  TutorModel.fromJson(Map<String, dynamic> json) {
    dow = json['dow'];
    success = json['success'];
    message = json['message'];

    if (json['tutor_courses'] != null) {
      todayCourses = <TutorCourse>[];
      json['tutor_courses'].forEach((v) {
        if (TutorCourse.fromJson(v).isEnabled! &&
            TutorCourse.fromJson(v).isToday!) {
          todayCourses!.add(TutorCourse.fromJson(v));
        }
      });
    }
    pendingRequests = <TutorEnrolment>[];
    if (json['tutor_courses'] != null) {
      disabledCourses = <TutorCourse>[];
      json['tutor_courses'].forEach((v) {
        if (!TutorCourse.fromJson(v).isEnabled!) {
          disabledCourses!.add(TutorCourse.fromJson(v));
        }
      });
    }
    if (json['tutor_courses'] != null) {
      enabledCourses = <TutorCourse>[];
      json['tutor_courses'].forEach((v) {
        if (TutorCourse.fromJson(v).isEnabled!) {
          enabledCourses!.add(TutorCourse.fromJson(v));
        }
      });
    }
    tutorInfo = json['user_info'] != null
        ? TutorInfo?.fromJson(json['user_info'])
        : null;
    if (json['tutor_courses'] != null) {
      tutorCourses = <TutorCourse>[];
      json['tutor_courses'].forEach((v) {
        tutorCourses!.add(TutorCourse.fromJson(v));
      });
    }
  }
}

class TutorCourse {
  String? id;
  String? adminId;
  String? code;
  String? title;
  String? startDate;
  String? endDate;
  bool? isEnabled;
  String? image;
  List<String>? weekDays;
  List<String>? weekHours;
  String? dateModified;
  String? dateCreated;
  bool? isToday;
  List<TutorEnrolment?>? enrolments;
  List<TutorEnrolment?>? acceptedEnrolments;
  List<TutorLecture?>? lectures;

  TutorCourse(
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
      this.acceptedEnrolments,
      this.isToday,
      this.enrolments,
      this.lectures});

  TutorCourse.fromJson(Map<String, dynamic> json) {
    id = json['course_id'];
    adminId = json['course_adminId'];
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
    if (json['enrolments'] != null) {
      enrolments = <TutorEnrolment>[];
      json['enrolments'].forEach((v) {
        enrolments!.add(TutorEnrolment.fromJson(v));
      });
    }
    if (json['enrolments'] != null) {
      acceptedEnrolments = <TutorEnrolment>[];
      json['enrolments'].forEach((v) {
        if (TutorEnrolment.fromJson(v).enrolmentstatus == 'accepted') {
          acceptedEnrolments!.add(TutorEnrolment.fromJson(v));
        }
      });
    }
    if (json['lectures'] != null) {
      lectures = <TutorLecture>[];
      json['lectures'].forEach((v) {
        lectures!.add(TutorLecture.fromJson(v));
      });
    }
  }
}

class TutorInfo {
  String? id;
  String? fullName;
  String? email;
  String? status;
  String? type;
  String? image;
  String? lastAccess;
  String? dateCreated;

  TutorInfo({
    this.id,
    this.fullName,
    this.email,
    this.status,
    this.image,
    this.type,
    this.lastAccess,
    this.dateCreated,
  });

  TutorInfo.fromJson(Map<String, dynamic> json) {
    id = json['user_id'];
    fullName = json['user_name'];
    email = json['user_email'];
    status = json['user_status'];
    type = json['user_type'];
    image = json['user_image'];
    lastAccess = json['user_lastAccess'];
    dateCreated = json['user_dateCreated'];
  }
}
