import 'package:flutter/material.dart';
import 'package:mohadraty/bloc/main_bloc/main_cubit.dart';

import '../class/class_tile.dart';

class ClassesSheet extends StatefulWidget {
  const ClassesSheet(
      {super.key,
      required this.controller,
      required this.consta,
      required this.cubit});
  final BoxConstraints consta;
  final MainCubit cubit;
  final DraggableScrollableController controller;

  @override
  State<ClassesSheet> createState() => _ClassesSheetState();
}

class _ClassesSheetState extends State<ClassesSheet>
    with TickerProviderStateMixin {
  late final AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 3500))
      ..repeat();
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      shouldCloseOnMinExtent: false,
      snap: true,
      snapSizes: const [0.52, 1],
      initialChildSize: 0.52,
      minChildSize: 0.52,
      controller: widget.controller,
      builder: (context, animation) => Container(
        decoration: const BoxDecoration(
            color: Color(0xFF23262F),
            border: Border(
              top: BorderSide(color: Color(0xFFBEFF6C), width: 5),
            ),
            borderRadius: BorderRadius.vertical(top: Radius.circular(25))),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          controller: animation,
          shrinkWrap: true,
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
            const Text(
              "Today",
              style: TextStyle(
                  fontSize: 32,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: widget.consta.maxHeight * 0.02),
            for (var i = 0; i < mainModel!.todayCourses!.length; i++)
              ClassTile(
                isHome: true,
                consta: widget.consta,
                courseDetails: mainModel!.todayCourses![i]!,
              )
          ],
        ),
      ),
    );
  }
}
