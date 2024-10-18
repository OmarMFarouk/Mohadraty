import 'package:flutter/material.dart';
import 'package:mohadraty/model/student_model.dart';
import 'package:mohadraty/model/tutor_model.dart';
import 'package:mohadraty/src/app_colors.dart';
import 'package:screenshot/screenshot.dart';

import 'gen_qr_dialog.dart';

class DashLecturesTile extends StatelessWidget {
  const DashLecturesTile(
      {super.key,
      required this.length,
      required this.lectureDetails,
      required this.consta,
      required this.index});
  final BoxConstraints consta;
  final TutorLecture lectureDetails;
  final int index, length;
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
          onTap: () {
            QrGeneratorDialog.show(
                context, lectureDetails.lectureqrCode, ScreenshotController());
          },
          child: Ink(
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                        width: consta.maxWidth * 0.125,
                        height: consta.maxHeight * 0.07,
                        decoration: BoxDecoration(
                            color: AppColors.primary.withAlpha(100),
                            borderRadius: BorderRadius.circular(7)),
                        child: const Icon(
                          Icons.book,
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
                                lectureDetails.lecturetitle!,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 16),
                              ),
                              SizedBox(height: consta.maxHeight * 0.002),
                              Text(
                                lectureDetails.lecturedateCreated!
                                    .split(' ')
                                    .first,
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
                          'no. $index',
                          maxLines: 1,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.white),
                        ),
                      ],
                    )),
                  ],
                ),
              ],
            ),
          )),
    );
  }
}
