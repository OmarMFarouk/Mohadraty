import 'package:flutter/material.dart';
import 'package:mohadraty/components/class/lecture_tile.dart';
import 'package:mohadraty/components/dashboard/dash_enrolment_tile.dart';
import 'package:mohadraty/components/dashboard/dash_lecture_tile.dart';
import 'package:mohadraty/model/student_model.dart';
import 'package:mohadraty/model/tutor_model.dart';

import '../../src/app_colors.dart';

class DashLectureSheet extends StatefulWidget {
  const DashLectureSheet(
      {super.key, required this.consta, required this.courseDetails});
  final BoxConstraints consta;
  final TutorCourse courseDetails;

  @override
  State<DashLectureSheet> createState() => _DashLectureSheetState();
}

class _DashLectureSheetState extends State<DashLectureSheet> {
  final PageController pageController = PageController(initialPage: 0);
  int currentIndex = 0;
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
          borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
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
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    splashColor: AppColors.grey.withAlpha(100),
                    borderRadius: BorderRadius.circular(15),
                    onTap: () {
                      pageController.animateToPage(currentIndex == 0 ? 1 : 0,
                          duration: Durations.long4,
                          curve: Curves.fastLinearToSlowEaseIn);
                    }, // Implement action on tap
                    child: Ink(
                      width: widget.consta.maxWidth * 0.25,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      height: widget.consta.maxHeight * 0.035,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            currentIndex == 0 ? 'Students' : "Lectures",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Icon(currentIndex == 0
                              ? Icons.chevron_right
                              : Icons.chevron_left),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  currentIndex == 0 ? "Lectures" : "Students",
                  style: TextStyle(
                    fontSize: 32,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  currentIndex == 0
                      ? '${widget.courseDetails.lectures!.length}'
                      : "${widget.courseDetails.enrolments!.length}",
                  style: const TextStyle(
                    fontSize: 32,
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Expanded(
              // Wrap PageView in Expanded to fill remaining space
              child: PageView(
                onPageChanged: (value) {
                  setState(() {
                    currentIndex = value;
                  });
                },
                controller: pageController,
                scrollDirection: Axis.horizontal,
                children: [
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: widget.courseDetails.lectures!.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) => DashLecturesTile(
                      index: index + 1,
                      length: widget.courseDetails.lectures!.length,
                      consta: widget.consta,
                      lectureDetails: widget.courseDetails.lectures![index]!,
                    ),
                  ),
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: widget.courseDetails.acceptedEnrolments!.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) => DashEnrolmentTile(
                      index: index + 1,
                      length: widget.courseDetails.lectures!.length,
                      consta: widget.consta,
                      enrolmentDetails:
                          widget.courseDetails.acceptedEnrolments![index]!,
                    ),
                  ),
                  // Add more pages if needed
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
