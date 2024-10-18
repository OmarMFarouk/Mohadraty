import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:mohadraty/bloc/main_bloc/main_cubit.dart';
import 'package:mohadraty/bloc/main_bloc/main_states.dart';
import 'package:mohadraty/components/dashboard/create_class_sheet.dart';
import 'package:mohadraty/components/dashboard/dash_qr_button.dart';
import 'package:mohadraty/components/dashboard/gen_qr_dialog.dart';
import 'package:mohadraty/components/home_screen/add_class_dialog.dart';
import 'package:mohadraty/components/home_screen/states_dialog.dart';
import 'package:mohadraty/src/app_colors.dart';
import 'package:mohadraty/src/app_navigator.dart';
import 'package:mohadraty/view/classes_screen.dart';
import 'package:screenshot/screenshot.dart';

import '../components/home_screen/appbar.dart';
import '../components/home_screen/class_sheet.dart';
import '../components/home_screen/side_button.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final DraggableScrollableController draggableScrollableController =
      DraggableScrollableController();
  ScreenshotController screenshotController = ScreenshotController();
  MobileScannerController qrCont = MobileScannerController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit, MainStates>(listener: (context, state) {
      if (state is MainAdded) {
        StateDialog.show(context, state.msg, false);
      }
      if (state is MainFailure) {
        StateDialog.show(context, state.msg, true);
      }
      if (state is MainGenQr) {
        QrGeneratorDialog.show(context, state.qrCode, screenshotController);
      }
    }, builder: (context, state) {
      var cubit = MainCubit.get(context);
      return PopScope(
        canPop: cubit.canPop,
        onPopInvoked: (didPop) => cubit.onAppClose(didPop, context),
        child: LayoutBuilder(builder: (context, consta) {
          return Scaffold(
            appBar: const PreferredSize(
              preferredSize: Size.fromHeight(kToolbarHeight),
              child: HomeAppBar(),
            ),
            backgroundColor: const Color(0xFF141416),
            bottomSheet: ClassesSheet(
                isDash: true,
                cubit: cubit,
                consta: consta,
                controller: draggableScrollableController),
            body: LayoutBuilder(builder: (context, consta) {
              return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: LiquidPullToRefresh(
                    onRefresh: () async => await cubit.fetchTutorData(),
                    showChildOpacityTransition: false,
                    backgroundColor: AppColors.primary,
                    color: Colors.transparent,
                    springAnimationDurationInMilliseconds: 100,
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: consta.maxHeight * 0.02),
                            Text(
                              'Welcome Back, ${tutorModel!.tutorInfo!.fullName}',
                              style: const TextStyle(
                                  color: Color(0xffffffEF),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                            SizedBox(height: consta.maxHeight * 0.04),
                            SizedBox(
                                height: consta.maxHeight * 0.33,
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: DashQrButton(
                                        cubit: cubit,
                                      ),
                                    ),
                                    SizedBox(
                                      width: consta.maxWidth * 0.08,
                                    ),
                                    Expanded(
                                      child: Column(
                                        children: [
                                          Expanded(
                                            child: SideButton(
                                              cubit: cubit,
                                              onTap: () {
                                                showModalBottomSheet(
                                                    isScrollControlled: true,
                                                    backgroundColor:
                                                        Colors.transparent,
                                                    context: context,
                                                    builder: (context) =>
                                                        CreateClassSheet(
                                                            titleCont:
                                                                cubit.idCont,
                                                            codeCont:
                                                                cubit.codeCont,
                                                            onTap: () async =>
                                                                await cubit
                                                                    .createClass()
                                                                    .then(
                                                                      (value) =>
                                                                          Navigator.pop(
                                                                              context),
                                                                    )));
                                              },
                                              isRed: false,
                                              title: 'Create Class',
                                            ),
                                          ),
                                          SizedBox(
                                            height: consta.maxHeight * 0.02,
                                          ),
                                          Expanded(
                                            child: SideButton(
                                              cubit: cubit,
                                              onTap: () => AppNavigator.push(
                                                  context,
                                                  ClasessScreen(
                                                    isDash: true,
                                                  ),
                                                  NavigatorAnimation
                                                      .slideAnimation),
                                              isRed: true,
                                              title: 'My Classes',
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                )),
                            SizedBox(height: consta.maxHeight * 0.06),
                          ]),
                    ),
                  ));
            }),
          );
        }),
      );
    });
  }
}
