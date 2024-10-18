import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mohadraty/bloc/main_bloc/main_cubit.dart';
import 'package:mohadraty/src/app_colors.dart';

class CoursesDropDown extends StatelessWidget {
  const CoursesDropDown({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: DropdownButtonFormField(
        dropdownColor: AppColors.secondary,
        isExpanded: true,
        onChanged: (value) {},
        validator: (value) {
          if (BlocProvider.of<MainCubit>(context).selectedCourse == null) {
            return '*Choose Course';
          }
          return null;
        },
        items: tutorModel!.enabledCourses!.map((type) {
          return DropdownMenuItem(
            value: type,
            onTap: () {
              BlocProvider.of<MainCubit>(context).selectedCourse = type;
            },
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: AppColors.primary,
                  foregroundImage: type!.image!.isEmpty
                      ? null
                      : CachedNetworkImageProvider(type.image!),
                  child: Icon(
                    Icons.book,
                    color: AppColors.primary.withAlpha(100),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    type.title!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, color: AppColors.grey),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  type.code!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: AppColors.grey),
                ),
              ],
            ),
          );
        }).toList(),
        decoration: InputDecoration(
          errorStyle: TextStyle(fontWeight: FontWeight.bold),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: AppColors.primary, width: 2.5)),
          filled: true,
          fillColor: AppColors.fillColor,
          labelText: "Choose Course",
          labelStyle: const TextStyle(
              fontWeight: FontWeight.bold, color: AppColors.grey),
        ),
      ),
    );
  }
}
