import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mohadraty/src/app_colors.dart';

class ClassDetailsField extends StatelessWidget {
  const ClassDetailsField({super.key, required this.icon, required this.hint});
  final String hint;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () async {
        await Clipboard.setData(ClipboardData(text: hint));
        Fluttertoast.showToast(msg: 'Copied');
      },
      child: Container(
          margin: const EdgeInsets.all(4),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: AppColors.fillColor),
          child: TextFormField(
              enableInteractiveSelection: true,
              controller: TextEditingController(text: hint),
              enabled: false,
              maxLines: 2,
              minLines: 1,
              textAlignVertical: TextAlignVertical.center,
              style: const TextStyle(
                  color: AppColors.grey,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  overflow: TextOverflow.ellipsis),
              decoration: InputDecoration(
                prefixIcon: Icon(
                  icon,
                  color: AppColors.primary,
                ),
                border: InputBorder.none,
              ))),
    );
  }
}
