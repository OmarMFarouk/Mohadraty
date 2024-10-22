import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mohadraty/bloc/main_bloc/main_cubit.dart';
import 'package:mohadraty/components/auth/button.dart';
import 'package:mohadraty/components/dashboard/dash_field.dart';
import 'package:mohadraty/src/app_colors.dart';

import 'day_picker.dart';

class CreateClassSheet extends StatefulWidget {
  const CreateClassSheet(
      {super.key,
      required this.onTap,
      required this.titleCont,
      required this.codeCont});
  final VoidCallback? onTap;
  final TextEditingController? codeCont, titleCont;

  @override
  State<CreateClassSheet> createState() => _CreateClassSheetState();
}

class _CreateClassSheetState extends State<CreateClassSheet> {
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
              CircleAvatar(
                radius: 75,
                backgroundImage: BlocProvider.of<MainCubit>(context)
                            .pickedImage ==
                        null
                    ? null
                    : FileImage(File(
                        BlocProvider.of<MainCubit>(context).pickedImage!.path)),
                backgroundColor: AppColors.primary.withAlpha(75),
                child: IconButton(
                  onPressed: () async {
                    await BlocProvider.of<MainCubit>(context).pickImage();
                    setState(() {});
                  },
                  icon: Icon(
                    BlocProvider.of<MainCubit>(context).pickedImage == null
                        ? Icons.add_photo_alternate
                        : Icons.delete,
                    size:
                        BlocProvider.of<MainCubit>(context).pickedImage == null
                            ? 80
                            : 25,
                    color: AppColors.primary,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              DashField(
                  enabled: true,
                  hint: context.tr('course_title'),
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
                  controller: widget.titleCont!),
              DashField(
                  enabled: true,
                  hint: context.tr('course_code'),
                  validator: (d) {
                    if (d!.isEmpty) {
                      return '*Field is required.';
                    } else if (d.length < 4) {
                      return 'Alteast 4 characters.';
                    }
                    return null;
                  },
                  onTap: () {},
                  icon: Icons.code,
                  controller: widget.codeCont!),
              Row(
                children: [
                  Expanded(
                    child: DashField(
                        enabled: false,
                        hint: context.tr('start_date'),
                        validator: (d) {
                          if (d!.isEmpty) {
                            return '*Field is required.';
                          }
                          return null;
                        },
                        onTap: () async {
                          DateTime? pickedDate;
                          pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2050));
                          if (pickedDate != null) {
                            BlocProvider.of<MainCubit>(context).startDate =
                                '${pickedDate.year}-${pickedDate.month}-${pickedDate.day}';
                            setState(() {});
                          }
                        },
                        icon: Icons.date_range,
                        controller: TextEditingController(
                            text:
                                BlocProvider.of<MainCubit>(context).startDate)),
                  ),
                  Expanded(
                    child: DashField(
                        enabled: false,
                        hint: context.tr('start_date'),
                        validator: (d) {
                          if (d!.isEmpty) {
                            return '*Field is required.';
                          }
                          return null;
                        },
                        onTap: () async {
                          DateTime? pickedDate;
                          pickedDate = await showDatePicker(
                              context: context,
                              initialDate:
                                  DateTime.now().add(Duration(days: 90)),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2050));
                          if (pickedDate != null) {
                            BlocProvider.of<MainCubit>(context).endDate =
                                '${pickedDate.year}-${pickedDate.month}-${pickedDate.day}';
                            setState(() {});
                          }
                        },
                        icon: Icons.date_range,
                        controller: TextEditingController(
                            text: BlocProvider.of<MainCubit>(context).endDate)),
                  ),
                ],
              ),
              const DayPicker(),
              AuthButton(
                  consta: const BoxConstraints.expand(),
                  onTap: () {
                    if (formKey.currentState!.validate() &&
                        BlocProvider.of<MainCubit>(context).pickedImage !=
                            null &&
                        BlocProvider.of<MainCubit>(context)
                            .startDate
                            .isNotEmpty &&
                        BlocProvider.of<MainCubit>(context)
                            .endDate
                            .isNotEmpty &&
                        selectedDays.isNotEmpty &&
                        selectedHours.isNotEmpty) {
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
