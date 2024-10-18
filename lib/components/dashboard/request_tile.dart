import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mohadraty/bloc/main_bloc/main_cubit.dart';
import 'package:mohadraty/components/dashboard/request_dialog.dart';
import 'package:mohadraty/model/tutor_model.dart';
import 'package:mohadraty/src/app_colors.dart';
import 'package:mohadraty/src/app_navigator.dart';

class RequestTile extends StatelessWidget {
  const RequestTile(
      {super.key, required this.enrolmentDetails, required this.consta});
  final BoxConstraints consta;
  final TutorEnrolment enrolmentDetails;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: () {
            RequestDialog(
                studentName: 'Omar Farouk',
                onReject: () async {
                  await BlocProvider.of<MainCubit>(context).manageRequest(
                      type: 'rejected',
                      rid: enrolmentDetails.enrolmentid,
                      uid: enrolmentDetails.enrolmentuserId,
                      courseTitle: enrolmentDetails.courseName);
                  AppNavigator.pop(context);
                },
                onAccept: () async {
                  await BlocProvider.of<MainCubit>(context).manageRequest(
                      type: 'accepted',
                      rid: enrolmentDetails.enrolmentid,
                      uid: enrolmentDetails.enrolmentuserId,
                      courseTitle: enrolmentDetails.courseName);
                  AppNavigator.pop(context);
                }).show(context);
          },
          child: Ink(
            child: Column(
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                          width: consta.maxWidth * 0.125,
                          height: consta.maxHeight * 0.07,
                          decoration: BoxDecoration(
                              image: enrolmentDetails.studentImage!.isNotEmpty
                                  ? DecorationImage(
                                      fit: BoxFit.cover,
                                      image: CachedNetworkImageProvider(
                                          enrolmentDetails.studentImage!))
                                  : null,
                              color: AppColors.primary.withAlpha(100),
                              borderRadius: BorderRadius.circular(7)),
                          child: enrolmentDetails.studentImage!.isEmpty
                              ? const Icon(
                                  Icons.person,
                                  color: AppColors.primary,
                                )
                              : SizedBox()),
                    ),
                    SizedBox(width: consta.maxWidth * 0.02),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  enrolmentDetails.enrolmentstudentName!,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 14),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Code: ${enrolmentDetails.enrolmentstudentCode}',
                                maxLines: 1,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.primary),
                              ),
                            ],
                          ),
                          SizedBox(height: consta.maxHeight * 0.002),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  enrolmentDetails.courseName!,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white.withAlpha(100)),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                enrolmentDetails.enrolmentdateCreated!
                                    .split(' ')
                                    .first,
                                maxLines: 1,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white.withAlpha(100)),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MainButton extends StatelessWidget {
  const MainButton(
      {super.key,
      required this.elevation,
      required this.consta,
      required this.onTap,
      required this.onTapCancel,
      required this.onTapUp,
      required this.title,
      required this.onTapDown});
  final BoxConstraints consta;
  final double elevation;
  final String title;
  final VoidCallback onTap, onTapCancel;
  final Function(dynamic) onTapUp, onTapDown;
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: elevation,
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(25),
      child: InkWell(
        onTap: onTap,
        onTapCancel: onTapCancel,
        onTapDown: onTapDown,
        onTapUp: onTapUp,
        borderRadius: BorderRadius.circular(25),
        child: Ink(
          width: consta.maxWidth * 0.4,
          height: elevation == 10
              ? consta.maxHeight * 0.17
              : consta.maxHeight * 0.168,
          decoration: BoxDecoration(
              border: Border.all(width: 5),
              color: Colors.white,
              borderRadius: BorderRadius.circular(25)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset(
                title == 'Attend Class'
                    ? 'assets/images/scan.png'
                    : title == 'Join Class'
                        ? 'assets/images/add_class.png'
                        : 'assets/images/classes.png',
                height: consta.maxHeight * 0.11,
              ),
              const Text(
                'Attend Class',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              )
            ],
          ),
        ),
      ),
    );
  }
}
