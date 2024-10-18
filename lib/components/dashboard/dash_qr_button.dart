import 'package:flutter/material.dart';
import 'package:mohadraty/components/dashboard/create_lecture_sheet.dart';
import 'package:mohadraty/src/app_colors.dart';

import '../../bloc/main_bloc/main_cubit.dart';
import '../../src/app_assets.dart';

// ignore: must_be_immutable
class DashQrButton extends StatelessWidget {
  DashQrButton({super.key, required this.cubit});
  final MainCubit cubit;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(15),
      splashColor: Colors.white.withAlpha(100),
      onTap: () async {
        showModalBottomSheet(
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            context: context,
            builder: (context) => CreateLectureSheet(
                titleCont: cubit.codeCont,
                onTap: () async => await cubit.createLecture().then(
                      (value) => Navigator.pop(context),
                    )));
      },
      child: Ink(
        decoration: BoxDecoration(
            image: DecorationImage(
                scale: 1.75, image: AssetImage(AppAssets.scanQrIcon)),
            borderRadius: BorderRadius.circular(15),
            color: AppColors.primary),
        child: const Column(
          children: [
            Text(
              'Create Qr-Code',
              style: TextStyle(
                  color: Color(0xff131a0b),
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
            Spacer(),
            Align(
              alignment: Alignment.bottomRight,
              child: Icon(
                Icons.chevron_right,
                size: 45,
              ),
            )
          ],
        ),
      ),
    );
  }
}
