import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mohadraty/src/app_colors.dart';

ValueNotifier<bool> obscurity = ValueNotifier(true);

class AuthField extends StatelessWidget {
  const AuthField(
      {super.key,
      required this.hint,
      required this.controller,
      this.obscure,
      required this.validator});
  final String hint;
  final bool? obscure;
  final TextEditingController controller;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: obscurity,
        builder: (context, value, child) {
          return Container(
            margin: const EdgeInsets.only(bottom: 20),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: AppColors.fillColor,
                border: Border.all(color: AppColors.primary, width: 2.5)),
            child: TextFormField(
                textCapitalization: hint == 'Password'
                    ? TextCapitalization.none
                    : TextCapitalization.sentences,
                textInputAction: hint == 'Password'
                    ? TextInputAction.done
                    : TextInputAction.next,
                keyboardType: TextInputType.emailAddress,
                controller: controller,
                inputFormatters: [FilteringTextInputFormatter.deny(' ')],
                validator: validator,
                cursorColor: AppColors.primary,
                obscureText: obscure == null || obscure == false
                    ? false
                    : obscurity.value,
                textAlignVertical: TextAlignVertical.center,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    prefixIcon: Icon(
                      hint == 'Student ID'
                          ? Icons.badge
                          : hint == 'Course Code'
                              ? Icons.numbers_rounded
                              : hint == 'Email'
                                  ? Icons.email
                                  : hint == 'Password'
                                      ? Icons.password
                                      : Icons.person,
                      color: AppColors.primary,
                    ),
                    suffixIcon: obscure != null
                        ? InkWell(
                            onTap: () {
                              obscurity.value = !obscurity.value;
                            },
                            child: Icon(
                              obscurity.value == false
                                  ? Icons.remove_red_eye
                                  : Icons.remove_red_eye_outlined,
                              color: AppColors.primary,
                            ),
                          )
                        : null,
                    border: InputBorder.none,
                    hintText: hint,
                    errorStyle: const TextStyle(fontWeight: FontWeight.bold),
                    hintStyle: const TextStyle(
                        color: AppColors.grey, fontWeight: FontWeight.bold))),
          );
        });
  }
}
