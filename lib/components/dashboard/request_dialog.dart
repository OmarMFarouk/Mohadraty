import 'package:flutter/material.dart';
import 'package:mohadraty/components/auth/button.dart';

class RequestDialog extends StatelessWidget {
  const RequestDialog({
    super.key,
    required this.onReject,
    required this.studentName,
    required this.onAccept,
  });
  final String studentName;
  final VoidCallback onAccept, onReject;
  show(context) => showDialog(
      context: context,
      builder: (context) => RequestDialog(
            onAccept: onAccept,
            studentName: studentName,
            onReject: onReject,
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
        height: MediaQuery.sizeOf(context).height * 0.2,
        width: MediaQuery.sizeOf(context).width * 0.7,
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "Manage ${studentName.split(' ').first}'s Request",
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.white),
                textAlign: TextAlign.center,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  AuthButton(
                      consta: const BoxConstraints.expand(),
                      onTap: onAccept,
                      hint: 'Accept'),
                  AuthButton(
                      consta: const BoxConstraints.expand(),
                      onTap: onReject,
                      hint: 'Reject'),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
