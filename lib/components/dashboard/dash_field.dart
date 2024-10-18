import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mohadraty/src/app_colors.dart';

class DashField extends StatelessWidget {
  const DashField(
      {super.key,
      required this.validator,
      required this.onTap,
      required this.icon,
      required this.enabled,
      required this.hint,
      required this.controller});
  final IconData icon;
  final String hint;
  final VoidCallback onTap;
  final bool enabled;
  final String? Function(String?)? validator;
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          splashColor: AppColors.goldish.withAlpha(100),
          borderRadius: BorderRadius.circular(15),
          onTap: !enabled ? onTap : null,
          child: Ink(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: AppColors.fillColor,
                  border: Border.all(color: AppColors.primary, width: 2.5)),
              child: TextFormField(
                  inputFormatters: hint == 'Course Code'
                      ? [FilteringTextInputFormatter.deny(' ')]
                      : null,
                  validator: validator,
                  controller: controller,
                  textAlignVertical: TextAlignVertical.center,
                  enabled: enabled,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: hint == 'Start Date' || hint == 'End Date'
                          ? 13
                          : null,
                      fontWeight: FontWeight.bold),
                  decoration: InputDecoration(
                    hintText: hint,
                    errorStyle: const TextStyle(fontWeight: FontWeight.bold),
                    hintStyle: const TextStyle(
                        color: AppColors.grey,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                    prefixIcon: Icon(
                      icon,
                      color: AppColors.primary,
                    ),
                    border: InputBorder.none,
                  ))),
        ),
      ),
    );
  }
}
