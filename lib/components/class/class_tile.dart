import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mohadraty/src/app_navigator.dart';
import 'package:mohadraty/view/class_screen.dart';

import '../../bloc/main_bloc/main_cubit.dart';
import '../../model/main_model.dart';

class ClassTile extends StatelessWidget {
  const ClassTile(
      {super.key,
      required this.isHome,
      required this.consta,
      required this.courseDetails});
  final UserCourse courseDetails;
  final BoxConstraints consta;
  final bool isHome;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => AppNavigator.push(
            context,
            ClassDetailsScreen(
              courseDetails: courseDetails,
            ),
            NavigatorAnimation.fadeAnimation),
        splashColor: Colors.white.withAlpha(100),
        borderRadius: BorderRadius.circular(7),
        child: Ink(
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      width: consta.maxWidth * 0.175,
                      height: consta.maxHeight * 0.09,
                      decoration: BoxDecoration(
                          image: courseDetails.image!.isEmpty
                              ? null
                              : DecorationImage(
                                  fit: BoxFit.cover,
                                  image: CachedNetworkImageProvider(
                                      courseDetails.image!)),
                          color: const Color(0xFFC5ECB4),
                          borderRadius: BorderRadius.circular(7)),
                      child: courseDetails.image!.isEmpty
                          ? const Icon(Icons.collections_bookmark_outlined,
                              size: 35)
                          : null),
                  SizedBox(width: consta.maxWidth * 0.02),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          courseDetails.title!,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 18),
                        ),
                        SizedBox(height: consta.maxHeight * 0.002),
                        Text(
                          courseDetails.author!,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white.withAlpha(100)),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: consta.maxWidth * 0.02),
                  Column(
                    children: [
                      Text(
                        isHome
                            ? courseDetails.weekHours![
                                courseDetails.weekDays!.indexWhere((e) {
                                return courseDetails.weekDays!
                                    .contains(currentDay);
                              })]
                            : '${courseDetails.startDate!.replaceRange(0, 5, '')}~${courseDetails.endDate!.replaceRange(0, 5, '')}',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: isHome ? 22 : 14),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
