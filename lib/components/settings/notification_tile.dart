import 'package:flutter/material.dart';
import 'package:mohadraty/src/app_colors.dart';

class NotificationsTile extends StatelessWidget {
  const NotificationsTile({super.key, required this.consta});
  final BoxConstraints consta;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
                width: consta.maxWidth * 0.125,
                height: consta.maxHeight * 0.07,
                decoration: BoxDecoration(
                    color: AppColors.primary.withAlpha(100),
                    borderRadius: BorderRadius.circular(7)),
                child: const Icon(
                  Icons.check_box,
                  color: AppColors.primary,
                )),
            SizedBox(width: consta.maxWidth * 0.02),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Attendance checked for class Digital Electronics',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 14),
                  ),
                  SizedBox(height: consta.maxHeight * 0.002),
                  Text(
                    '2024-10-10',
                    maxLines: 1,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white.withAlpha(100)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class MainButton extends StatelessWidget {
  const MainButton(
      {super.key,
      required this.elevation,
      required this.consta,
      required this.onTap,
      required this.onTapCancel,
      required this.onTapUp,
      required this.title,
      required this.onTapDown});
  final BoxConstraints consta;
  final double elevation;
  final String title;
  final VoidCallback onTap, onTapCancel;
  final Function(dynamic) onTapUp, onTapDown;
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: elevation,
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(25),
      child: InkWell(
        onTap: onTap,
        onTapCancel: onTapCancel,
        onTapDown: onTapDown,
        onTapUp: onTapUp,
        borderRadius: BorderRadius.circular(25),
        child: Ink(
          width: consta.maxWidth * 0.4,
          height: elevation == 10
              ? consta.maxHeight * 0.17
              : consta.maxHeight * 0.168,
          decoration: BoxDecoration(
              border: Border.all(width: 5),
              color: Colors.white,
              borderRadius: BorderRadius.circular(25)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset(
                title == 'Attend Class'
                    ? 'assets/images/scan.png'
                    : title == 'Join Class'
                        ? 'assets/images/add_class.png'
                        : 'assets/images/classes.png',
                height: consta.maxHeight * 0.11,
              ),
              const Text(
                'Attend Class',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              )
            ],
          ),
        ),
      ),
    );
  }
}
