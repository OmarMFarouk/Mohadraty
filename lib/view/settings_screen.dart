import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mohadraty/bloc/main_bloc/main_cubit.dart';
import 'package:mohadraty/bloc/main_bloc/main_states.dart';
import 'package:mohadraty/components/dashboard/courses_dropdown.dart';
import 'package:mohadraty/components/settings/language_dropdown.dart';
import 'package:mohadraty/components/settings/setting_field.dart';
import 'package:mohadraty/src/app_colors.dart';
import 'package:mohadraty/src/app_endpoints.dart';
import 'package:mohadraty/src/app_navigator.dart';
import 'package:mohadraty/src/app_shared.dart';
import 'package:mohadraty/view/notification_screen.dart';
import 'package:restart_app/restart_app.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  void initState() {
    BlocProvider.of<MainCubit>(context).pickedImage = null;

    super.initState();
  }

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
                    LanguageDropDown(
                      consta: consta,
                    )
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
                                    foregroundImage: studentModel == null &&
                                            tutorModel == null
                                        ? null
                                        : CachedNetworkImageProvider(
                                            studentModel != null
                                                ? studentModel!.userInfo!.image!
                                                : tutorModel!
                                                    .tutorInfo!.image!),
                                    backgroundImage: BlocProvider.of<MainCubit>(
                                                    context)
                                                .pickedImage ==
                                            null
                                        ? null
                                        : FileImage(File(
                                            BlocProvider.of<MainCubit>(context)
                                                .pickedImage!
                                                .path)),
                                    backgroundColor:
                                        AppColors.primary.withAlpha(75),
                                    child: IconButton(
                                      onPressed: () async {
                                        await BlocProvider.of<MainCubit>(
                                                context)
                                            .updateProfileImage();
                                        setState(() {});
                                      },
                                      icon: Icon(
                                        BlocProvider.of<MainCubit>(context)
                                                    .pickedImage ==
                                                null
                                            ? Icons.add_photo_alternate
                                            : Icons.delete,
                                        size:
                                            BlocProvider.of<MainCubit>(context)
                                                        .pickedImage ==
                                                    null
                                                ? 80
                                                : 25,
                                        color: AppColors.primary,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  SettingsField(
                                      onTap: () {},
                                      icon: Icons.person,
                                      hint: studentModel != null
                                          ? studentModel!.userInfo!.name!
                                          : tutorModel!.tutorInfo!.fullName!),
                                  SettingsField(
                                      onTap: () {},
                                      icon: Icons.email,
                                      hint: studentModel != null
                                          ? studentModel!.userInfo!.email!
                                          : tutorModel!.tutorInfo!.email!),
                                  const Spacer(),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: SettingsField(
                                            onTap: () => launchUrl(Uri.parse(
                                                AppEndPoints.privacy)),
                                            icon: Icons.policy_sharp,
                                            hint: 'Policy'),
                                      ),
                                      SizedBox(
                                        width: consta.maxWidth * 0.03,
                                      ),
                                      Expanded(
                                        child: SettingsField(
                                            onTap: () => launchUrl(
                                                Uri.parse(AppEndPoints.terms)),
                                            icon: FontAwesomeIcons.legal,
                                            hint: 'Terms'),
                                      )
                                    ],
                                  ),
                                  SettingsField(
                                      onTap: () => AppNavigator.push(
                                          context,
                                          const NotificationScreen(),
                                          NavigatorAnimation.fadeAnimation),
                                      icon: Icons.notifications,
                                      hint: 'Notifications'),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: SettingsField(
                                            onTap: () {},
                                            icon: Icons.verified_sharp,
                                            hint:
                                                'Ver: ${AppShared.appInfo.version}'),
                                      ),
                                      SizedBox(
                                        width: consta.maxWidth * 0.03,
                                      ),
                                      Expanded(
                                        child: SettingsField(
                                            onTap: () async {
                                              await AppShared.localStorage
                                                  .setBool('active', false);
                                              Restart.restartApp();
                                            },
                                            icon: FontAwesomeIcons.signOut,
                                            hint: 'Logout'),
                                      )
                                    ],
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
