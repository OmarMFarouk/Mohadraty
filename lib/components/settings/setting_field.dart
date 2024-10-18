import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mohadraty/src/app_colors.dart';

class SettingsField extends StatelessWidget {
  const SettingsField(
      {super.key, required this.onTap, required this.hint, required this.icon});
  final IconData icon;
  final String hint;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          splashColor: AppColors.goldish.withAlpha(100),
          borderRadius: BorderRadius.circular(15),
          onTap: onTap,
          onLongPress: icon == Icons.email || icon == Icons.person
              ? () async {
                  await Clipboard.setData(ClipboardData(text: hint));
                  Fluttertoast.showToast(msg: "Copied");
                }
              : () {},
          child: Ink(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: AppColors.fillColor,
                  border: Border.all(color: AppColors.primary, width: 2.5)),
              child: TextFormField(
                  controller: TextEditingController(text: hint),
                  textAlignVertical: TextAlignVertical.center,
                  enabled: false,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
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
