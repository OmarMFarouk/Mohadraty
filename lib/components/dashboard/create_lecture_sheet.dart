import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mohadraty/components/auth/button.dart';
import 'package:mohadraty/components/dashboard/courses_dropdown.dart';
import 'package:mohadraty/components/dashboard/dash_field.dart';
import 'package:mohadraty/components/dashboard/duration_picker.dart';
import 'package:mohadraty/src/app_colors.dart';

class CreateLectureSheet extends StatefulWidget {
  const CreateLectureSheet({
    super.key,
    required this.onTap,
    required this.titleCont,
  });
  final VoidCallback? onTap;
  final TextEditingController titleCont;

  @override
  State<CreateLectureSheet> createState() => _CreateLectureSheetState();
}

class _CreateLectureSheetState extends State<CreateLectureSheet> {
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom == 0
              ? 10
              : MediaQuery.of(context).viewInsets.bottom,
          left: 20,
          right: 20),
      decoration: const BoxDecoration(
          color: AppColors.fillColor,
          borderRadius: BorderRadius.vertical(top: Radius.circular(35)),
          border: Border(top: BorderSide(color: AppColors.primary, width: 5))),
      child: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                context.tr('fill_msg'),
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.white),
              ),
              Text(
                context.tr('location_msg'),
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: AppColors.red),
              ),
              DashField(
                  enabled: true,
                  hint: context.tr('lecture_title'),
                  validator: (d) {
                    if (d!.isEmpty) {
                      return '*Field is required.';
                    } else if (d.length < 4) {
                      return 'Alteast 4 characters.';
                    }
                    return null;
                  },
                  onTap: () {},
                  icon: Icons.title,
                  controller: widget.titleCont),
              const CoursesDropDown(),
              Text(
                context.tr('qr_duration'),
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.grey,
                    fontSize: 16),
              ),
              const DurationPicker(),
              AuthButton(
                  consta: const BoxConstraints.expand(),
                  onTap: () {
                    if (formKey.currentState!.validate() &&
                        selectedDuration.isNotEmpty) {
                      widget.onTap!();
                    } else {
                      Fluttertoast.showToast(msg: 'Fill all requirements');
                    }
                  },
                  hint: context.tr('create'))
            ],
          ),
        ),
      ),
    );
  }
}
