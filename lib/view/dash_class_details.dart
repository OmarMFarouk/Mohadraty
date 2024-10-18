// ignore_for_file: unused_import

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mohadraty/bloc/main_bloc/main_cubit.dart';
import 'package:mohadraty/bloc/main_bloc/main_states.dart';
import 'package:mohadraty/components/class/class_details_field.dart';
import 'package:mohadraty/components/class/lecture_tile.dart';
import 'package:mohadraty/components/dashboard/dash_lecture_sheet.dart';
import 'package:mohadraty/model/student_model.dart';
import 'package:mohadraty/model/tutor_model.dart';
import 'package:mohadraty/src/app_colors.dart';
import 'package:mohadraty/src/app_shared.dart';

import '../components/class/lecture_sheet.dart';

class DashClassDetailsScreen extends StatefulWidget {
  const DashClassDetailsScreen({super.key, required this.courseDetails});
  final TutorCourse courseDetails;
  @override
  State<DashClassDetailsScreen> createState() => _DashClassDetailsScreenState();
}

class _DashClassDetailsScreenState extends State<DashClassDetailsScreen> {
  @override
  void initState() {
    if (AppShared.localStorage.getBool('course-${widget.courseDetails.id}') ==
            null &&
        !kIsWeb) {
      AppShared.localStorage
              .setBool('course-${widget.courseDetails.id}', true) ==
          FirebaseMessaging.instance
              .subscribeToTopic('course-${widget.courseDetails.id}');
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit, MainStates>(
        listener: (context, state) {},
        builder: (context, state) {
          MainCubit.get(context);
          return LayoutBuilder(builder: (context, consta) {
            return Scaffold(
              bottomSheet: DashLectureSheet(
                  consta: consta, courseDetails: widget.courseDetails),
              appBar: AppBar(
                foregroundColor: Colors.white,
                backgroundColor: Colors.transparent,
                title: const Text(
                  'Class Details',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 22),
                ),
              ),
              backgroundColor: AppColors.black,
              body: LayoutBuilder(builder: (context, consta) {
                return Container(
                  constraints: BoxConstraints(
                    maxHeight: consta.maxHeight * 0.435,
                  ),
                  margin: const EdgeInsets.only(
                      top: 10, bottom: 20, left: 20, right: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: widget.courseDetails.isEnabled!
                        ? AppColors.primary
                        : AppColors.red,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ClassDetailsField(
                              icon: Icons.class_,
                              hint: widget.courseDetails.title!,
                            ),
                            ClassDetailsField(
                                icon: Icons.people,
                                hint: widget.courseDetails.enrolments!.length
                                    .toString()),
                            ClassDetailsField(
                                icon: FontAwesomeIcons.calendarDays,
                                hint:
                                    '${widget.courseDetails.startDate!.replaceRange(0, 5, '')} to ${widget.courseDetails.endDate!.replaceRange(0, 5, '')}'),
                            ClassDetailsField(
                                icon: FontAwesomeIcons.calendarDay,
                                hint: widget.courseDetails.weekDays!
                                    .toString()
                                    .replaceAll('[', '')
                                    .replaceAll(']', '')),
                            ClassDetailsField(
                                icon: FontAwesomeIcons.clock,
                                hint: widget.courseDetails.weekHours
                                    .toString()
                                    .replaceAll('[', '')
                                    .replaceAll(']', '')),
                          ],
                        ),
                      ),
                      kIsWeb
                          ? SizedBox()
                          : Expanded(
                              flex: 1,
                              child: Container(
                                decoration: const BoxDecoration(
                                    color: AppColors.fillColor,
                                    borderRadius: BorderRadius.horizontal(
                                        right: Radius.circular(15))),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      AppShared.localStorage.getBool(
                                              'course-${widget.courseDetails.id}')!
                                          ? Icons.notifications
                                          : Icons.notifications_off,
                                      size: 35,
                                      color: AppShared.localStorage.getBool(
                                              'course-${widget.courseDetails.id}')!
                                          ? AppColors.primary
                                          : AppColors.grey,
                                    ),
                                    SizedBox(
                                      height: consta.maxHeight * 0.05,
                                    ),
                                    Switch(
                                      value: AppShared.localStorage.getBool(
                                          'course-${widget.courseDetails.id}')!,
                                      onChanged: (s) {
                                        if (s == false) {
                                          FirebaseMessaging.instance
                                              .unsubscribeFromTopic(
                                                  'course-${widget.courseDetails.id}');
                                          AppShared.localStorage.setBool(
                                              'course-${widget.courseDetails.id}',
                                              s);
                                        } else {
                                          FirebaseMessaging.instance
                                              .subscribeToTopic(
                                                  'course-${widget.courseDetails.id}');
                                          AppShared.localStorage.setBool(
                                              'course-${widget.courseDetails.id}',
                                              s);
                                        }
                                        setState(() {});
                                      },
                                      thumbIcon:
                                          const WidgetStatePropertyAll(Icon(
                                        Icons.circle,
                                        size: 35,
                                        color: AppColors.primary,
                                      )),
                                      inactiveTrackColor: AppColors.grey,
                                      activeColor: AppColors.primary,
                                    )
                                  ],
                                ),
                              ),
                            )
                    ],
                  ),
                );
              }),
            );
          });
        });
  }
}
