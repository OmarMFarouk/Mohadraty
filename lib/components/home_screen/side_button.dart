import 'package:flutter/material.dart';

import '../../bloc/main_bloc/main_cubit.dart';

class SideButton extends StatelessWidget {
  const SideButton(
      {super.key,
      required this.isRed,
      required this.cubit,
      required this.onTap,
      required this.title});

  final MainCubit cubit;
  final String title;
  final bool isRed;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(15),
      splashColor: Colors.white.withAlpha(100),
      onTap: onTap,
      child: Ink(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: isRed ? const Color(0xFFFB816E) : const Color(0xFFF8B533)),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment:
                    isRed ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  Icon(
                    isRed ? Icons.menu_book_sharp : Icons.add,
                    color: Colors.white,
                    size: 40,
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        '${title.split(' ').first}\n${title.split(' ').last}',
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 28),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
