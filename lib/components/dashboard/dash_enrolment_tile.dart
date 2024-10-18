import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mohadraty/model/tutor_model.dart';
import 'package:mohadraty/src/app_colors.dart';

class DashEnrolmentTile extends StatelessWidget {
  const DashEnrolmentTile(
      {super.key,
      required this.length,
      required this.enrolmentDetails,
      required this.consta,
      required this.index});
  final BoxConstraints consta;
  final TutorEnrolment enrolmentDetails;
  final int index, length;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
                width: consta.maxWidth * 0.125,
                height: consta.maxHeight * 0.07,
                decoration: BoxDecoration(
                    image: enrolmentDetails.studentImage!.isEmpty
                        ? null
                        : DecorationImage(
                            image: CachedNetworkImageProvider(
                                enrolmentDetails.studentImage!)),
                    color: AppColors.primary.withAlpha(100),
                    borderRadius: BorderRadius.circular(7)),
                child: enrolmentDetails.studentImage!.isNotEmpty
                    ? null
                    : const Icon(
                        Icons.person,
                        color: AppColors.primary,
                      )),
            SizedBox(width: consta.maxWidth * 0.02),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          enrolmentDetails.enrolmentstudentName!,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 16),
                        ),
                        SizedBox(height: consta.maxHeight * 0.002),
                        Text(
                          'Attended ${enrolmentDetails.attendancecount!.split(' ').first}/$length',
                          maxLines: 1,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white.withAlpha(100)),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: consta.maxWidth * 0.01),
                  Text(
                    enrolmentDetails.enrolmentstudentCode!,
                    maxLines: 1,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.white),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
