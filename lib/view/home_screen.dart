import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:mohadraty/bloc/main_bloc/main_cubit.dart';
import 'package:mohadraty/bloc/main_bloc/main_states.dart';
import 'package:mohadraty/components/home_screen/add_class_dialog.dart';
import 'package:mohadraty/components/home_screen/states_dialog.dart';
import 'package:mohadraty/src/app_colors.dart';
import 'package:mohadraty/src/app_navigator.dart';
import 'package:mohadraty/view/classes_screen.dart';

import '../components/home_screen/appbar.dart';
import '../components/home_screen/class_sheet.dart';
import '../components/home_screen/qr_button.dart';
import '../components/home_screen/side_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final DraggableScrollableController draggableScrollableController =
      DraggableScrollableController();
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
            backgroundColor: AppColors.black,
            bottomSheet: Material(
              color: AppColors.black,
              child: ClassesSheet(
                  cubit: cubit,
                  isDash: false,
                  consta: consta,
                  controller: draggableScrollableController),
            ),
            body: LayoutBuilder(builder: (context, consta) {
              return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: LiquidPullToRefresh(
                    onRefresh: () => cubit.fetchStudentData(),
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
                              '${context.tr('welcome_back')} ${studentModel!.userInfo!.name}',
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
                                      child: QrButton(
                                        cubit: cubit,
                                        qrCont: qrCont,
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
                                                  AddClassDialog(
                                                    idCont: cubit.idCont,
                                                    codeCont: cubit.codeCont,
                                                    onTap: () async =>
                                                        await cubit
                                                            .joinClass()
                                                            .then(
                                                              (value) =>
                                                                  Navigator.pop(
                                                                      context),
                                                            ),
                                                  ).show(context);
                                                },
                                                isRed: false,
                                                title:
                                                    context.tr('join_class')),
                                          ),
                                          SizedBox(
                                            height: consta.maxHeight * 0.02,
                                          ),
                                          Expanded(
                                            child: SideButton(
                                              cubit: cubit,
                                              onTap: () => AppNavigator.push(
                                                  context,
                                                  const ClasessScreen(
                                                      isDash: false),
                                                  NavigatorAnimation
                                                      .slideAnimation),
                                              isRed: true,
                                              title: context.tr('my_classes'),
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
