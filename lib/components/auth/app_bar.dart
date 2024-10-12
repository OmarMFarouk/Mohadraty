import 'package:flutter/material.dart';

class AuthAppBar extends StatelessWidget {
  const AuthAppBar({super.key, required this.controller});
  final PageController controller;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      foregroundColor: Colors.white,
      backgroundColor: Colors.transparent,
      title: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: IconButton(
          onPressed: () => controller.animateToPage(0,
              curve: Curves.fastLinearToSlowEaseIn,
              duration: const Duration(milliseconds: 350)),
          icon: const Icon(
            Icons.chevron_left_outlined,
            color: Colors.black,
          ),
          style: ButtonStyle(
              elevation: const WidgetStatePropertyAll(10),
              shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10))),
              backgroundColor: const WidgetStatePropertyAll(Colors.white)),
        ),
      ),
    );
  }
}
