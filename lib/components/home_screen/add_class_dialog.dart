import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mohadraty/components/auth/button.dart';
import 'package:mohadraty/components/auth/formfield.dart';

class AddClassDialog extends StatelessWidget {
  const AddClassDialog(
      {super.key,
      required this.onTap,
      required this.idCont,
      required this.codeCont});
  final VoidCallback? onTap;
  final TextEditingController? codeCont;
  final TextEditingController? idCont;
  show(context) => showDialog(
      context: context,
      builder: (context) => AddClassDialog(
            codeCont: codeCont,
            idCont: idCont,
            onTap: onTap,
          ).build(context));
  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    return Dialog(
      child: Container(
        decoration: BoxDecoration(
            color: const Color(0xFF141416),
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: const Color(0xFFBEFF6C), width: 5)),
        height: MediaQuery.sizeOf(context).height * 0.4,
        width: MediaQuery.sizeOf(context).width * 0.7,
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                context.tr('join_class'),
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.white),
                textAlign: TextAlign.center,
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: AuthField(
                      hint: context.tr('course_code'),
                      controller: codeCont!,
                      validator: (s) {
                        if (s!.isEmpty) {
                          '*Field is required';
                        }
                        return null;
                      })),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: AuthField(
                      hint: context.tr('student_code'),
                      controller: idCont!,
                      validator: (s) {
                        if (s!.isEmpty) {
                          '*Field is required';
                        }
                        return null;
                      })),
              AuthButton(
                  consta: const BoxConstraints.expand(),
                  onTap: () {
                    if (formKey.currentState!.validate()) {
                      onTap!();
                    }
                  },
                  hint: context.tr('join'))
            ],
          ),
        ),
      ),
    );
  }
}
