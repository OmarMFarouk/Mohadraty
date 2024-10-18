import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mohadraty/bloc/auth_bloc/auth_cubit.dart';
import 'package:mohadraty/src/app_colors.dart';

class RoleWidget extends StatelessWidget {
  const RoleWidget({super.key, required this.cubit, required this.consta});
  final BoxConstraints consta;
  final AuthCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Row(
        children: [
          AnimatedContainer(
            width: !cubit.isStudent
                ? consta.maxWidth * 0.48
                : consta.maxWidth * 0.3,
            duration: Durations.extralong4,
            curve: Curves.fastEaseInToSlowEaseOut,
            child: InkWell(
              borderRadius: BorderRadius.circular(15),
              onTap: () {
                cubit.isStudent = false;
                cubit.refreshState();
              },
              child: Ink(
                height: consta.maxHeight * 0.1,
                decoration: BoxDecoration(
                    color: !cubit.isStudent
                        ? AppColors.primary
                        : AppColors.fillColor,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: AppColors.primary, width: 2.5)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      FontAwesomeIcons.chalkboardUser,
                      size: 35,
                      color: !cubit.isStudent
                          ? AppColors.black
                          : AppColors.primary,
                    ),
                    Text(
                      '\t\tTutor',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: !cubit.isStudent
                              ? AppColors.black
                              : AppColors.grey),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            width: 20,
          ),
          AnimatedContainer(
            width:
                cubit.isStudent ? consta.maxWidth * 0.5 : consta.maxWidth * 0.3,
            duration: Durations.extralong3,
            curve: Curves.fastEaseInToSlowEaseOut,
            child: InkWell(
              borderRadius: BorderRadius.circular(15),
              onTap: () {
                cubit.isStudent = true;
                cubit.refreshState();
              },
              child: Ink(
                height: consta.maxHeight * 0.1,
                decoration: BoxDecoration(
                    color: cubit.isStudent
                        ? AppColors.primary
                        : AppColors.fillColor,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: AppColors.primary, width: 2.5)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      FontAwesomeIcons.graduationCap,
                      size: 35,
                      color:
                          cubit.isStudent ? AppColors.black : AppColors.primary,
                    ),
                    Text(
                      '\t\tStudent',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: cubit.isStudent
                              ? AppColors.black
                              : AppColors.grey),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
