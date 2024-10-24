import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mohadraty/bloc/main_bloc/main_cubit.dart';
import 'package:mohadraty/components/dashboard/request_tile.dart';
import 'package:mohadraty/src/app_assets.dart';

import '../class/class_tile.dart';

class ClassesSheet extends StatefulWidget {
  const ClassesSheet(
      {super.key,
      required this.controller,
      required this.consta,
      required this.isDash,
      required this.cubit});
  final BoxConstraints consta;
  final bool isDash;
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
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0.4, end: 1.0),
      duration: const Duration(seconds: 1),
      builder: (context, value, child) => Opacity(opacity: value, child: child),
      child: TweenAnimationBuilder<double>(
        tween: Tween<double>(begin: 0.9, end: 0.0),
        duration: const Duration(milliseconds: 750),
        builder: (context, value, child) => Transform.translate(
          offset: Offset(0, value * MediaQuery.of(context).size.height),
          child: child,
        ),
        child: DraggableScrollableSheet(
          expand: false,
          shouldCloseOnMinExtent: false,
          snap: true,
          snapSizes: const [0.52, 1],
          initialChildSize: 0.52,
          minChildSize: 0.52,
          controller: widget.controller,
          builder: (context, animation) => widget.isDash
              ? Container(
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
                      Text(
                        context.tr('join_requests'),
                        style: const TextStyle(
                            fontSize: 32,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: widget.consta.maxHeight * 0.02),
                      tutorModel!.pendingRequests!.isEmpty
                          ? Image.asset(AppAssets.notFoundIllu, scale: 7)
                          : const SizedBox(),
                      for (var i = 0;
                          i <
                              BlocProvider.of<MainCubit>(context)
                                  .pending
                                  .length;
                          i++)
                        RequestTile(
                          consta: widget.consta,
                          enrolmentDetails:
                              BlocProvider.of<MainCubit>(context).pending[i],
                        ),
                    ],
                  ),
                )
              : Container(
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
                      Text(
                        context.tr('today'),
                        style: const TextStyle(
                            fontSize: 32,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: widget.consta.maxHeight * 0.02),
                      studentModel!.todayCourses!.isEmpty
                          ? Image.asset(AppAssets.notFoundIllu, scale: 7)
                          : const SizedBox(),
                      for (var i = 0;
                          i < studentModel!.todayCourses!.length;
                          i++)
                        ClassTile(
                          isHome: true,
                          consta: widget.consta,
                          courseDetails: studentModel!.todayCourses![i]!,
                        )
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
