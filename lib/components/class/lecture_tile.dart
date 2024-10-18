import 'package:flutter/material.dart';
import 'package:mohadraty/model/student_model.dart';
import 'package:mohadraty/src/app_colors.dart';

class LecturesTile extends StatelessWidget {
  const LecturesTile(
      {super.key,
      required this.length,
      required this.lectureDetails,
      required this.consta,
      required this.index});
  final BoxConstraints consta;
  final StudentLecture lectureDetails;
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
                    color: lectureDetails.isAttended!
                        ? AppColors.primary.withAlpha(100)
                        : AppColors.red.withAlpha(100),
                    borderRadius: BorderRadius.circular(7)),
                child: Icon(
                  lectureDetails.isAttended!
                      ? Icons.check_box
                      : Icons.indeterminate_check_box,
                  color: lectureDetails.isAttended!
                      ? AppColors.primary
                      : AppColors.red,
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
                          lectureDetails.title!,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 16),
                        ),
                        SizedBox(height: consta.maxHeight * 0.002),
                        Text(
                          lectureDetails.dateCreated!.split(' ').first,
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
              ),
            ),
          ],
        ),
      ],
    );
  }
}
