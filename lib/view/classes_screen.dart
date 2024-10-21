import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mohadraty/bloc/main_bloc/main_cubit.dart';
import 'package:mohadraty/bloc/main_bloc/main_states.dart';
import 'package:mohadraty/components/class/class_tile.dart';
import 'package:mohadraty/components/dashboard/dash_class_tile.dart';
import 'package:mohadraty/src/app_assets.dart';
import 'package:mohadraty/src/app_colors.dart';

class ClasessScreen extends StatefulWidget {
  const ClasessScreen({super.key, required this.isDash});
  final bool isDash;
  @override
  State<ClasessScreen> createState() => _ClasessScreenState();
}

class _ClasessScreenState extends State<ClasessScreen> {
  int currentIndex = 0;
  PageController controller = PageController(initialPage: 0);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit, MainStates>(
        listener: (context, state) {},
        builder: (context, state) {
          MainCubit.get(context);
          return LayoutBuilder(builder: (context, consta) {
            return Scaffold(
              appBar: AppBar(
                foregroundColor: Colors.white,
                backgroundColor: Colors.transparent,
                title: Text(
                  context.tr('my_classes').split(' ').last,
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 22),
                ),
              ),
              backgroundColor: AppColors.black,
              body: LayoutBuilder(builder: (context, consta) {
                return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: consta.maxHeight * 0.02),
                          Expanded(
                            child: Container(
                              decoration: const BoxDecoration(
                                  color: Color(0xFF23262F),
                                  border: Border(
                                    top: BorderSide(
                                        color: Color(0xFFBEFF6C), width: 5),
                                  ),
                                  borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(25))),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
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
                                  InkWell(
                                    onTap: () => controller.animateToPage(
                                        currentIndex == 0 ? 1 : 0,
                                        curve: Curves.fastLinearToSlowEaseIn,
                                        duration: Durations.short4),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: 50,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                          height: MediaQuery.sizeOf(context)
                                                  .height *
                                              0.025,
                                          child: Icon(currentIndex == 0
                                              ? Icons.chevron_right
                                              : Icons.chevron_left),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Expanded(
                                    child: PageView(
                                        onPageChanged: (value) => setState(
                                            () => currentIndex = value),
                                        controller: controller,
                                        children: [
                                          Column(
                                            children: [
                                              Text(
                                                context.tr('active_courses'),
                                                style: const TextStyle(
                                                    fontSize: 32,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              SizedBox(
                                                  height:
                                                      consta.maxHeight * 0.02),
                                              Expanded(
                                                child: studentModel != null &&
                                                            studentModel!
                                                                .enabledCourses!
                                                                .isEmpty ||
                                                        tutorModel != null &&
                                                            tutorModel!
                                                                .enabledCourses!
                                                                .isEmpty
                                                    ? Image.asset(
                                                        AppAssets.notFoundIllu)
                                                    : ListView.separated(
                                                        separatorBuilder:
                                                            (context, index) =>
                                                                const SizedBox(
                                                                    height: 15),
                                                        itemCount: !widget.isDash
                                                            ? studentModel!
                                                                .enabledCourses!
                                                                .length
                                                            : tutorModel!
                                                                .enabledCourses!
                                                                .length,
                                                        itemBuilder: (context, index) {
                                                          return widget.isDash
                                                              ? DashClassTile(
                                                                  consta:
                                                                      consta,
                                                                  courseDetails:
                                                                      tutorModel!
                                                                              .enabledCourses![
                                                                          index]!)
                                                              : ClassTile(
                                                                  isHome: false,
                                                                  consta:
                                                                      consta,
                                                                  courseDetails:
                                                                      studentModel!
                                                                              .enabledCourses![
                                                                          index]!);
                                                        }),
                                              )
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              Text(
                                                context.tr('inactive_courses'),
                                                style: const TextStyle(
                                                    fontSize: 32,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              SizedBox(
                                                  height:
                                                      consta.maxHeight * 0.02),
                                              Expanded(
                                                child: studentModel != null &&
                                                            studentModel!
                                                                .disabledCourses!
                                                                .isEmpty ||
                                                        tutorModel != null &&
                                                            tutorModel!
                                                                .disabledCourses!
                                                                .isEmpty
                                                    ? Image.asset(
                                                        AppAssets.notFoundIllu)
                                                    : ListView.separated(
                                                        separatorBuilder:
                                                            (context, index) =>
                                                                const SizedBox(
                                                                    height: 15),
                                                        itemCount: !widget.isDash
                                                            ? studentModel!
                                                                .disabledCourses!
                                                                .length
                                                            : tutorModel!
                                                                .disabledCourses!
                                                                .length,
                                                        itemBuilder: (context, index) {
                                                          return widget.isDash
                                                              ? DashClassTile(
                                                                  consta:
                                                                      consta,
                                                                  courseDetails:
                                                                      tutorModel!
                                                                              .disabledCourses![
                                                                          index]!)
                                                              : ClassTile(
                                                                  isHome: false,
                                                                  consta:
                                                                      consta,
                                                                  courseDetails:
                                                                      studentModel!
                                                                              .disabledCourses![
                                                                          index]!);
                                                        }),
                                              )
                                            ],
                                          ),
                                        ]),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ]));
              }),
            );
          });
        });
  }
}
