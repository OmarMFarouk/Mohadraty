import 'package:flutter/material.dart';
import 'package:mohadraty/components/class/lecture_tile.dart';
import 'package:mohadraty/model/student_model.dart';

import '../../src/app_colors.dart';

class LectureSheet extends StatelessWidget {
  const LectureSheet(
      {super.key, required this.consta, required this.courseDetails});
  final BoxConstraints consta;
  final StudentCourse courseDetails;

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
        expand: false,
        shouldCloseOnMinExtent: false,
        snap: true,
        snapSizes: const [0.52, 1],
        initialChildSize: 0.52,
        minChildSize: 0.52,
        builder: (context, animation) => Container(
              decoration: const BoxDecoration(
                  color: Color(0xFF23262F),
                  border: Border(
                    top: BorderSide(color: Color(0xFFBEFF6C), width: 5),
                  ),
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(25))),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ListView(
                controller: animation,
                children: [
                  const Row(
                    children: [
                      SizedBox(
                        height: 10,
                        width: 1,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 50,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15)),
                        height: 7,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Lectures",
                        style: TextStyle(
                            fontSize: 32,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '(${courseDetails.lectures!.length})',
                        style: const TextStyle(
                            fontSize: 32,
                            color: AppColors.primary,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ListView.separated(
                    itemCount: courseDetails.lectures!.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) => LecturesTile(
                        index: index + 1,
                        length: courseDetails.lectures!.length,
                        consta: consta,
                        lectureDetails: courseDetails.lectures![index]!),
                    separatorBuilder: (context, index) =>
                        SizedBox(height: consta.maxHeight * 0.02),
                  ),
                ],
              ),
            ));
  }
}
