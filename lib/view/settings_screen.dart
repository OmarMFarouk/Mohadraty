import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mohadraty/bloc/main_bloc/main_cubit.dart';
import 'package:mohadraty/bloc/main_bloc/main_states.dart';
import 'package:mohadraty/components/settings/setting_field.dart';
import 'package:mohadraty/src/app_colors.dart';
import 'package:mohadraty/src/app_navigator.dart';
import 'package:mohadraty/src/app_shared.dart';
import 'package:mohadraty/view/notification_screen.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
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
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Settings',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 22),
                    ),
                    IconButton(
                        onPressed: () => AppNavigator.push(
                            context,
                            const NotificationScreen(),
                            NavigatorAnimation.fadeAnimation),
                        icon: const Icon(Icons.notifications))
                  ],
                ),
              ),
              backgroundColor: const Color(0xFF141416),
              body: LayoutBuilder(builder: (context, consta) {
                return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: consta.maxHeight * 0.02),
                          Expanded(
                            child: Container(
                              width: double.infinity,
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
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  CircleAvatar(
                                    radius: 75,
                                    backgroundColor:
                                        AppColors.primary.withAlpha(75),
                                    child: IconButton(
                                      onPressed: () {},
                                      icon: const Icon(
                                        Icons.add_photo_alternate,
                                        size: 80,
                                        color: AppColors.primary,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  SettingsField(
                                      icon: Icons.person,
                                      hint: mainModel!.userInfo!.name!),
                                  SettingsField(
                                      icon: Icons.person,
                                      hint: mainModel!.userInfo!.email!),
                                  const Spacer(),
                                  Row(
                                    children: [
                                      const Expanded(
                                        child: SettingsField(
                                            icon: Icons.policy_sharp,
                                            hint: 'Policy'),
                                      ),
                                      SizedBox(
                                        width: consta.maxWidth * 0.05,
                                      ),
                                      const Expanded(
                                        child: SettingsField(
                                            icon: FontAwesomeIcons.legal,
                                            hint: 'Terms'),
                                      )
                                    ],
                                  ),
                                  SettingsField(
                                      icon: Icons.verified_sharp,
                                      hint:
                                          'Version: ${AppShared.appInfo.version}'),
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
